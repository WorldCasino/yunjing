package com.cicada.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.cicada.commons.Exception.ApiException;
import com.cicada.commons.utils.*;
import com.cicada.enums.*;
import com.cicada.mapper.*;
import com.cicada.pojo.*;
import com.cicada.pojo.vo.*;
import com.cicada.redis.MessageQueueProducer;
import com.cicada.result.DatatablesResult;
import com.cicada.result.PicUploadResult;
import com.cicada.service.IMarqueeQueueService;
import com.cicada.service.IMessageService;
import com.cicada.service.ITaskAnswerService;
import com.cicada.service.ITaskService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import redis.clients.jedis.JedisPool;

import java.math.RoundingMode;
import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * Created by Administrator on 2017/5/11.
 * Description: *_*
 */
@Service
@Transactional
public class TaskServiceImpl extends ServiceImpl<TaskMapper, Task> implements ITaskService {
    private static final Logger LOTTERY_LOGGER = LogManager.getLogger("lottery");

    @Autowired
    private TaskMapper taskMapper;
    @Autowired
    private TaskAnswerMapper taskAnswerMapper;
    @Autowired
    private ITaskAnswerService taskAnswerService;
    @Autowired
    private TaskPictureMapper taskPictureMapper;
    @Autowired
    private TaskFootballMapper taskFootballMapper;
    @Autowired
    private TaskOrderMapper taskOrderMapper;
    @Autowired
    private ClientAccountDetailMapper accountDetailMapper;
    @Autowired
    private ClientAccountMapper accountMapper;
    @Autowired
    private TaskLotteryLogsMapper lotteryLogsMapper;
    @Autowired
    private ClientMapper clientMapper;
    @Autowired
    private IMarqueeQueueService marqueeQueueService;
    @Autowired
    private IMessageService messageService;
    @Autowired
    private JacksonSerializer jacksonSerializer;


    @Override
    public List<Task> getInProgressTasks() {
        Map<String, Object> m = new HashMap<>();
        m.put("task_status", TaskStatusEnum.Published.getCode());
        return selectByMap(m);
    }

    /**
     * 根据id查询竞猜项目
     * @param taskId 竞猜项目ID
     * @return
     * @throws ApiException
     */
    public TaskVo selectTaskVoById(int taskId) throws ApiException{
        return this.taskMapper.selectTaskVoById(taskId);
    }

    /**
     * 更新竞猜状态
     * @param taskId 竞猜项目ID
     * @param status 竞猜状态
     * @return
     */
    public boolean updateTaskStatus(int taskId,TaskStatusEnum status) throws ApiException{
        try {
            Task task = taskMapper.selectById(taskId);
            task.setTaskStatus(status);
            task.setUpdateDate(new Timestamp(System.currentTimeMillis()));
            taskMapper.updateTaskStatus(task);
        }catch (Exception e){
            throw new ApiException(ErrorCodeEnum.SystemError.getCode(),String.format("竞猜项目【%s】更新状态【%s】失败",taskId,status.getDesc()));
        }

        return true;
    }

    /**
     * 开奖处理
     * @param taskId 待开奖项目ID
     * @param mustLottery 是否没买完也开奖
     * @return
     * @throws ApiException
     */
    public LotteryResultVo runLotteryProcess(long taskId,boolean mustLottery) throws ApiException{

        /**
         * 重要重要重要：处理失败全部走throw new ApiException 不然事务不能回滚
         *
         * 1.发布项目 需冻结金币 = 单价*注数*（赔率 - 1） ，单价200，注数 10 正确答案赔率 1.5，需冻结=200*10*（1.5 -1） = 1000
         * 2.玩家下注 扣除金币 = 单价*下注数
         * 3.开奖处理 统计玩家每个答案的下注数合计
         *   3.1 猜对了 玩家收入 = 庄家支出 = 合计下注数 * 单价 * 赔率
         *   3.2 猜错了 玩家支出 = 庄家收入 * -1 = 合计下注数 * 单价 * -1
         *
         */
        Task task = taskMapper.selectById(taskId);
        if(task == null){
            LOTTERY_LOGGER.error(String.format("竞猜项目【%s】不存在，不能开奖！",taskId));
            return null;
        }

        // <editor-fold desc="开奖前验证">

        if(!mustLottery){
            //没买完并且时间没到不能开奖
            int orderQtyCount = taskOrderMapper.selectOrdersTotalByTaskId(task.getTaskId());
            if(orderQtyCount < task.getQuantity()
                    && task.getSettleTime().getTime() > System.currentTimeMillis()) {

                LOTTERY_LOGGER.error(String.format("竞猜项目【%s】开奖时间没到不能开奖！",task.getTaskId()));
                return null;
            }
        }

        //已开奖的不能重复开奖
        if(task.getTaskStatus() == TaskStatusEnum.Complete) {
            LOTTERY_LOGGER.error(String.format("竞猜项目【%s】已开奖，不能重复开奖！",task.getTaskId()));
            return null;
        }
        else if(task.getTaskStatus() != TaskStatusEnum.Published)
            throw new ApiException(ErrorCodeEnum.TaskLotteryStatusError);

        //手动开奖的没设置下注截止时间不能开奖
        if (task.getLotteryType() == 1 && null == task.getLockTime()){
            LOTTERY_LOGGER.error(String.format("手动开奖必须设置下注截止时间"));
            return null;
        }

        //获取竞猜项目的所有答案
        Map<String,Object> queryMap = new HashMap<>();
        queryMap.put("task_id",task.getTaskId());
        List<TaskAnswer> answerList = taskAnswerMapper.selectByMap(queryMap);
        List<TaskAnswer> temp = answerList.stream().filter(x -> x.getIsRight() == 1).collect(Collectors.toList());
        if (!(System.currentTimeMillis() > task.getSettleTime().getTime() && task.getLotteryType() == 1)){
            if(temp.size() == 0) {
                //重新扔回REDIS队列，等待5分钟后处理
                JedisPool jedisPool = (JedisPool)SpringContextUtil.getBean("jedisPool");
                String key = ConstantInterface.REDIS_KEY_LOTTERY_PREFIX + String.valueOf(task.getTaskId());
                if(jedisPool.getResource().exists(key)) jedisPool.getResource().del(key);
                jedisPool.getResource().setex(key,5*60,String.format("待开奖%s",task.getTaskId()));

                //必须先设置正确答案
                throw new ApiException(ErrorCodeEnum.TaskRightAnswerNotFound);
            }
        }

        // </editor-fold>

        Map<String,Integer> msgMap = new HashMap<>();
        double orgCoinBalance = 0;//原账户余额
        double orgBeanBalance = 0;//原账户余额

        //参与玩家 每个答案的盈亏合计发通知用
        LotteryResultVo lotteryResult;
        //微信模板消息通知的时候带上答案信息
        String answerInfo = "";
        try
        {
            //玩家发布项目时冻结的金币
             double coinLocked = 0;
            if (System.currentTimeMillis() > task.getSettleTime().getTime() && task.getLotteryType() == 1){
                double odds = 0;

                for (TaskAnswer answers : answerList){
                    if (answers.getOdds() > odds){
                        odds = answers.getOdds();
                    }
                }
                coinLocked = task.getQuantity() * task.getSalePrice() * (odds - 1);
            }else
           coinLocked = task.getQuantity() * task.getSalePrice() * (temp.get(0).getOdds() - 1);
            //未来事件 发布的时候是不知道正确答案，冻结金币是按最大赔率计算的，保存在locked_coins字段
            if(task.getLockedCoins() > 0){
                coinLocked = task.getLockedCoins();
            }

            //获取庄家账户
            queryMap = new HashMap<>();
            queryMap.put("user_id", task.getUserId());
            List<ClientAccountEntity> dealerAccount = accountMapper.selectByMap(queryMap);
            ClientAccountEntity dealerCoinAccount = dealerAccount.get(0).getCoinType() == CurrencyTypeEnum.Coin ? dealerAccount.get(0) : dealerAccount.get(1);
            ClientAccountEntity dealerBeanAccount = dealerAccount.get(0).getCoinType() == CurrencyTypeEnum.Peas ? dealerAccount.get(0) : dealerAccount.get(1);

            ClientEntity dealer = clientMapper.selectById(task.getUserId());//庄家用户
            String dealerName = StringUtils.isEmpty(dealer.getNickname()) ? dealer.getPhonenumber() : dealer.getNickname();

            orgCoinBalance = dealerCoinAccount.getCoinBalance();
            orgBeanBalance = dealerBeanAccount.getCoinBalance();

            //获取竞猜项目的所有下注订单
            queryMap = new HashMap<>();
            queryMap.put("task_id", task.getTaskId());
            List<TaskOrder> orders = taskOrderMapper.selectByMap(queryMap);

            //超时开奖，奖金平分
            if (task.getLotteryType() == 1 && System.currentTimeMillis() > task.getSettleTime().getTime()){
                lotteryResult = new LotteryResultVo(task.getTaskId(),task.getUserId(),task.getTaskContent(),2,task.getSalePrice(),"");

                //保留一位小数
                DecimalFormat df=new DecimalFormat(".#");
                df.setRoundingMode(RoundingMode.FLOOR);
                int totalQty = 0;
                for(TaskOrder taskOrder : orders){
                    totalQty += taskOrder.getQuantity();
                }
                //玩家、币种、下注数
                Map<Long, Map<String, Integer>> userQty = new HashMap<>();
                for (TaskAnswer answer : answerList) {
                    int cnt = 0;
                    cnt++;
                    char abc = (char) (cnt + 64);
                    List<TaskOrder> answerOrders = orders.stream()
                            .filter(x -> x.getAnswerId() == answer.getAnswerId())
                            .collect(Collectors.toList());

                    //没人买过这个答案
                    if (answerOrders.size() == 0) continue;
                    //每个玩家下注合计
                    Map<Long, Map<String, Integer>> userQtySmall = new HashMap<>();
                    for(TaskOrder taskOrder : answerOrders) {
                        Map<String, Integer> map = new HashMap<>();
                        Map<String, Integer> map1 = new HashMap<>();
                        if (taskOrder.getCoinType() == 0) {
                            int qty = userQtySmall.containsKey(taskOrder.getUserId()) && userQtySmall.get(taskOrder.getUserId()).containsKey("coin")
                                    ? userQtySmall.get(taskOrder.getUserId()).get("coin") + taskOrder.getQuantity() : taskOrder.getQuantity();
                            int qty1 = userQty.containsKey(taskOrder.getUserId()) && userQty.get(taskOrder.getUserId()).containsKey("coin")
                                    ? userQty.get(taskOrder.getUserId()).get("coin") + taskOrder.getQuantity() : taskOrder.getQuantity();
                            //非空判断
                            if (userQtySmall.containsKey(taskOrder.getUserId())) {
                                userQtySmall.get(taskOrder.getUserId()).put("coin", qty);
                                userQty.get(taskOrder.getUserId()).put("coin", qty1);
                            } else {
                                map.put("coin", qty);
                                map1.put("coin", qty1);
                                userQtySmall.put(taskOrder.getUserId(), map);
                                userQty.put(taskOrder.getUserId(), map1);
                            }
                        } else {
                            int qty = userQtySmall.containsKey(taskOrder.getUserId()) && userQtySmall.get(taskOrder.getUserId()).containsKey("bean")
                                    ? userQtySmall.get(taskOrder.getUserId()).get("bean") + taskOrder.getQuantity() : taskOrder.getQuantity();
                            int qty1 = userQtySmall.containsKey(taskOrder.getUserId()) && userQtySmall.get(taskOrder.getUserId()).containsKey("bean")
                                    ? userQtySmall.get(taskOrder.getUserId()).get("bean") + taskOrder.getQuantity() : taskOrder.getQuantity();
                            //非空判断
                            if (userQtySmall.containsKey(taskOrder.getUserId())) {
                                userQtySmall.get(taskOrder.getUserId()).put("bean", qty);
                                userQty.get(taskOrder.getUserId()).put("bean", qty1);
                            } else {
                                map.put("bean", qty);
                                map1.put("bean", qty1);
                                userQtySmall.put(taskOrder.getUserId(), map);
                                userQty.put(taskOrder.getUserId(), map1);
                            }
                        }
                    }

                        //添加到玩家开奖结果
                    for (Map.Entry<Long,Map<String, Integer>> entry : userQtySmall.entrySet()){
                        int userTotalQty = 0;
                        //Map<String, Integer> map1 = new HashMap<>();
                        //非空判断
                        if (null == entry.getValue().get("coin")) {
                            userTotalQty = entry.getValue().get("bean");
                            double avgCoin = Double.valueOf(df.format((double) userTotalQty / totalQty*coinLocked));
                            lotteryResult.addPlayerResult(entry.getKey(), answer.getAnswerId(), abc, true,
                                    answer.getOdds(), 0, avgCoin, entry.getValue().get("bean"),
                                    0);
//                            int qty = userQty.containsKey(entry.getKey()) && userQty.get(entry.getKey()).containsKey("coin")
//                                    ? userQty.get(entry.getKey()).get("coin") + userTotalQty : userTotalQty;
//                            map1.put("bean",qty);
                        }else if (null == entry.getValue().get("bean")){
                            userTotalQty = entry.getValue().get("coin");
                            double avgCoin = Double.valueOf(df.format((double) userTotalQty / totalQty*coinLocked));
                            lotteryResult.addPlayerResult(entry.getKey(), answer.getAnswerId(), abc, true,
                                    answer.getOdds(), entry.getValue().get("coin"), avgCoin, 0, 0);
//                            int qty = userQty.containsKey(entry.getKey()) && userQty.get(entry.getKey()).containsKey("bean")
//                                    ? userQty.get(entry.getKey()).get("bean") + userTotalQty : userTotalQty;
//                            map1.put("coin",qty);
                        }else if (null != entry.getValue().get("bean") && null != entry.getValue().get("coin")){
                            userTotalQty = entry.getValue().get("coin") + entry.getValue().get("bean");
                            double avgCoin = Double.valueOf(df.format((double) userTotalQty / totalQty*coinLocked));
                            lotteryResult.addPlayerResult(entry.getKey(), answer.getAnswerId(), abc, true,
                                    answer.getOdds(), entry.getValue().get("coin"), avgCoin, entry.getValue().get("bean"), 0);
//                            int qtyCoin = userQty.containsKey(entry.getKey()) && userQty.get(entry.getKey()).containsKey("coin")
//                                    ? userQty.get(entry.getKey()).get("coin") + userTotalQty : userTotalQty;
//                            int qtyBean = userQty.containsKey(entry.getKey()) && userQty.get(entry.getKey()).containsKey("bean")
//                                    ? userQty.get(entry.getKey()).get("bean") + userTotalQty : userTotalQty;
//                            map1.put("coin",qtyCoin);
//                            map1.put("bean",qtyBean);
                        }
                        //userQty.put(entry.getKey(),map1);
                    }
                }


                //下注金额退还+平均分庄家冻结金额
                double newCoinTotal = coinLocked;
                for (Map.Entry<Long,Map<String, Integer>> entry : userQty.entrySet()){
                    queryMap = new HashMap<>();
                    queryMap.put("user_id",entry.getKey());
                    List<ClientAccountEntity> userAccount = accountMapper.selectByMap(queryMap);
                    ClientAccountEntity coinAccount = userAccount.get(0).getCoinType() == CurrencyTypeEnum.Coin ? userAccount.get(0) : userAccount.get(1);
                    ClientAccountEntity beanAccount = userAccount.get(0).getCoinType() == CurrencyTypeEnum.Peas ? userAccount.get(0) : userAccount.get(1);
                    //生成玩家收支明细，先退款再得金币
                    ClientAccountDetailEntity detailEntity = new ClientAccountDetailEntity();
                    detailEntity.setUserId(entry.getKey());
                    detailEntity.setTaskId(task.getTaskId());
                    detailEntity.setFromType(TradeTypeEnum.TaskReward);
                    detailEntity.setCreateBy(task.getUserId());
                    detailEntity.setCreateDate(new Timestamp(System.currentTimeMillis()));
                    int userTotalQty = 0;
                    //非空判断
                    if (null == entry.getValue().get("coin")) {
                        userTotalQty = entry.getValue().get("bean");
                        double avgCoin = Double.valueOf(df.format ((double) userTotalQty / totalQty*coinLocked));
                        newCoinTotal -= avgCoin;
                        coinAccount.setCoinBalance(coinAccount.getCoinBalance()  + avgCoin);
                        coinAccount.setCoinIncome(coinAccount.getCoinIncome()  + avgCoin);
                        beanAccount.setCoinBalance(beanAccount.getCoinBalance() + entry.getValue().get("bean")*task.getSalePrice());
                        beanAccount.setCoinIncome(beanAccount.getCoinIncome() + entry.getValue().get("bean")*task.getSalePrice());

                        //退金豆
                        detailEntity.setCoins(entry.getValue().get("bean")*task.getSalePrice());
                        detailEntity.setAccountId(beanAccount.getAccountId());
                        accountDetailMapper.insert(detailEntity);
                        //得金币
                        detailEntity.setCoins(avgCoin);
                        detailEntity.setAccountId(coinAccount.getAccountId());
                        accountDetailMapper.insert(detailEntity);

                    }else if (null == entry.getValue().get("bean")){
                        userTotalQty = entry.getValue().get("coin");
                        double avgCoin = Double.valueOf(df.format((double) userTotalQty / totalQty*coinLocked));
                        newCoinTotal -= avgCoin;
                        coinAccount.setCoinBalance(coinAccount.getCoinBalance() + entry.getValue().get("coin")*task.getSalePrice() + avgCoin);
                        coinAccount.setCoinIncome(coinAccount.getCoinIncome() + entry.getValue().get("coin")*task.getSalePrice() + avgCoin);

                        //只有金币
                        detailEntity.setCoins(entry.getValue().get("coin")*task.getSalePrice() + avgCoin);
                        detailEntity.setAccountId(coinAccount.getAccountId());
                        accountDetailMapper.insert(detailEntity);
                    }else{
                        userTotalQty = entry.getValue().get("coin") + entry.getValue().get("bean");
                        double avgCoin = Double.valueOf(df.format((double) userTotalQty / totalQty*coinLocked));
                        newCoinTotal -= avgCoin;
                        coinAccount.setCoinBalance(coinAccount.getCoinBalance() + entry.getValue().get("coin")*task.getSalePrice() + avgCoin);
                        coinAccount.setCoinIncome(coinAccount.getCoinIncome() + entry.getValue().get("coin")*task.getSalePrice() + avgCoin);
                        beanAccount.setCoinBalance(beanAccount.getCoinBalance() + entry.getValue().get("bean")*task.getSalePrice());
                        beanAccount.setCoinIncome(beanAccount.getCoinIncome() + entry.getValue().get("bean")*task.getSalePrice());

                        //退金豆
                        detailEntity.setCoins(entry.getValue().get("bean")*task.getSalePrice());
                        detailEntity.setAccountId(beanAccount.getAccountId());
                        accountDetailMapper.insert(detailEntity);
                        //退金币再得金币
                        detailEntity.setCoins(entry.getValue().get("coin")*task.getSalePrice() + avgCoin);
                        detailEntity.setAccountId(coinAccount.getAccountId());
                        accountDetailMapper.insert(detailEntity);
                    }
                    accountMapper.updateAccountCoins(coinAccount);
                    accountMapper.updateAccountCoins(beanAccount);
                }

                //多余的还给庄家
                dealerCoinAccount.setCoinBalance(dealerCoinAccount.getCoinBalance() - coinLocked + newCoinTotal);
                dealerCoinAccount.setCoinExpend(dealerCoinAccount.getCoinExpend() + coinLocked - newCoinTotal);
                accountMapper.updateAccountCoins(dealerCoinAccount);
                //明细：庄家只会赔钱，而且还是金币
                ClientAccountDetailEntity dealerAd = new ClientAccountDetailEntity();
                dealerAd.setUserId(task.getUserId());
                dealerAd.setAccountId(dealerCoinAccount.getAccountId());
                dealerAd.setCoins(coinLocked - newCoinTotal);
                dealerAd.setTaskId(task.getTaskId());
                dealerAd.setFromType(TradeTypeEnum.TaskLotteryExpend);
                dealerAd.setCreateBy(task.getUserId());
                dealerAd.setCreateDate(new Timestamp(System.currentTimeMillis()));
                accountDetailMapper.insert(dealerAd);

                //TODO 跑马灯、APP推送消息、微信模板消息
                LOTTERY_LOGGER.info(String.format("竞猜项目【%s】开奖超时，【%s】金币平均下发给下注玩家",task.getTaskId(),coinLocked));
            }else {
                //正常开奖
                lotteryResult = new LotteryResultVo(task.getTaskId(),task.getUserId(),task.getTaskContent(),1,task.getSalePrice(),"");


                int cnt = 0;
                for (TaskAnswer answer : answerList) {
                    cnt++;
                    char abc = (char) (cnt + 64);
                    //在微信消息中换行用 \r\n
                    answerInfo += String.format("%s.%s%s \r\n", abc, answer.getAnswer(), answer.getIsRight() == 1 ? "【开奖答案】" : "");

                    List<TaskOrder> answerOrders = orders.stream()
                            .filter(x -> x.getAnswerId() == answer.getAnswerId())
                            .collect(Collectors.toList());

                    //没人买过这个答案
                    if (answerOrders.size() == 0) continue;

                    // <editor-fold desc="每个玩家的下注合计">
                    Map<Long, Map<String, Integer>> userCount = new HashMap<>();//玩家、币种、下注数
                    Map<String, Integer> map = new HashMap<>();
                    for (int i = answerOrders.size() - 1; i >= 0; i--) {
                        TaskOrder x = answerOrders.get(i);
                        String type = "";
                        Integer qty = 0;
                        if (x.getCoinType() == 0) {
                            type = "coin";
                        } else {
                            type = "bean";
                        }
                        qty = userCount.containsKey(x.getUserId()) && userCount.get(x.getUserId()).containsKey(type)
                                ? userCount.get(x.getUserId()).get(type) + x.getQuantity() : x.getQuantity();
                        map.put(type, qty);
                        userCount.put(x.getUserId(), map);
                        answerOrders.remove(i);
                    }
                    // </editor-fold>

                    // <editor-fold desc="开奖结算处理--玩家">

                    //这个答案的下注合计
                    int totalCoinQty = 0;
                    int totalBeanQty = 0;
                    //玩家收支金币
                    double coins = 0;
                    double beans = 0;
                    for (Map.Entry<Long, Map<String, Integer>> entry : userCount.entrySet()) {
                        for (Map.Entry<String, Integer> entryEntry : map.entrySet()) {
                            if ("coin".contains(entryEntry.getKey())) {
                                totalCoinQty += entryEntry.getValue();
                            } else totalBeanQty += entryEntry.getValue();
                        }

                        if (answer.getIsRight() == 1) {

                            //恭喜你猜对了~
                            if (null != map.get("coin"))
                                coins = task.getSalePrice() * map.get("coin") * answer.getOdds();
                            if (null != map.get("bean"))
                                beans = task.getSalePrice() * map.get("bean") * answer.getOdds();
                            queryMap = new HashMap<>();
                            queryMap.put("user_id", entry.getKey());
                            for (int i = 0; i < 2; i++) {
                                ClientAccountEntity accountEntity = accountMapper.selectByMap(queryMap).get(i);
                                //生成玩家收支明细
                                ClientAccountDetailEntity detailEntity = new ClientAccountDetailEntity();

                                detailEntity.setUserId(entry.getKey());
                                detailEntity.setAccountId(accountEntity.getAccountId());
                                double money = 0;
                                if (accountEntity.getCoinType() == CurrencyTypeEnum.Coin) {
                                    money = coins;
                                } else {
                                    money = beans;
                                }
                                if (money != 0) {
                                    detailEntity.setCoins(money);
                                    detailEntity.setTaskId(task.getTaskId());
                                    detailEntity.setFromType(TradeTypeEnum.TaskReward);
                                    detailEntity.setCreateBy(task.getUserId());
                                    detailEntity.setCreateDate(new Timestamp(System.currentTimeMillis()));
                                    accountDetailMapper.insert(detailEntity);
                                }
                                //更新玩家账户信息表数据
                                accountEntity.setCoinBalance(accountEntity.getCoinBalance() + money);
                                accountEntity.setCoinIncome(accountEntity.getCoinIncome() + money);
                                accountMapper.updateAccountCoins(accountEntity);

                                //跑马灯消息
                                ClientEntity client = clientMapper.selectById(entry.getKey());
                                String clientName = StringUtils.isEmpty(client.getNickname())?client.getPhonenumber():client.getNickname();
                                String content = String.format("玩家%s猜对了%s发布的竞猜，赢了%s金币", clientName,dealerName, new Double(coins).intValue());
                                marqueeQueueService.insertMarqueeRoll(MarqueeTypeEnum.LotteryWinners,content,task.getTaskId());
                                /*//跑马灯消息
                                ClientEntity client = clientMapper.selectById(entry.getKey());
                                String clientName = StringUtils.isEmpty(client.getNickname()) ? client.getPhonenumber() : client.getNickname();
                                String content = String.format("玩家%s猜对了%s发布的竞猜，赢了%s金币" , clientName, dealerName, new Double(money).intValue());
                                marqueeQueueService.insertMarqueeRoll(MarqueeTypeEnum.LotteryWinners, content, task.getTaskId());*/

                                if (null != map.get("coin") && accountEntity.getCoinType()== CurrencyTypeEnum.Coin)
                                    coins = task.getSalePrice() * map.get("coin") * (answer.getOdds() - 1);
                                if (null != map.get("bean") && accountEntity.getCoinType()== CurrencyTypeEnum.Peas)
                                    beans = task.getSalePrice() * map.get("bean") * (answer.getOdds() - 1);
                            }
                        } else {
                            //智商是硬伤啊~
                            if (null != map.get("coin"))
                                coins = task.getSalePrice() * map.get("coin");
                            if (null != map.get("bean"))
                                beans = task.getSalePrice() * map.get("bean");
                        }

                        for (int i = 0; i < 2; i++) {
                            queryMap = new HashMap<>();
                            queryMap.put("user_id", entry.getKey());
                            ClientAccountEntity accountEntity = accountMapper.selectByMap(queryMap).get(i);
                            double moneyType = 0;
                            String keyType = "";
                            if (accountEntity.getCoinType() == CurrencyTypeEnum.Coin) {
                                moneyType = coins;
                                keyType = "coin";
                            } else {
                                moneyType = beans;
                                keyType = "bean";
                            }
                            LOTTERY_LOGGER.info(String.format("玩家【%s】用【%s】购买答案【%s】，%s注", entry.getKey(), accountEntity.getCoinType().getDesc(), answer.getAnswerId(), map.get(keyType)));
                            if (null == map.get("coin")) {
                                map.put("coin", 0);
                            }
                            if (null == map.get("bean")) {
                                map.put("bean", 0);
                            }
                        }
                        lotteryResult.addPlayerResult(entry.getKey(), answer.getAnswerId(), abc,
                                answer.getIsRight() == 1, answer.getOdds(), map.get("coin"), coins, map.get("bean"), beans);
                    }
                    // </editor-fold>

                    // <editor-fold desc="开奖结算处理--庄家">

                    //不管对错，先下注给钱
                    double clientCoinBet = task.getSalePrice() * totalCoinQty;
                    double clientBeanBet = task.getSalePrice() * totalBeanQty;
                    //庄家收入
                    for (int i = 0; i < 2; i++) {
                        ClientAccountEntity accountEntity = dealerAccount.get(i);
                        double betType = 0;
                        long accountId = 0;
                        if (accountEntity.getCoinType() == CurrencyTypeEnum.Coin) {
                            accountId = accountEntity.getAccountId();
                            betType = clientCoinBet;
                        } else {
                            accountId = accountEntity.getAccountId();
                            betType = clientBeanBet;
                        }
                        ClientAccountDetailEntity dealerAd = new ClientAccountDetailEntity();
                        if (betType != 0) {
                            dealerAd.setUserId(task.getUserId());
                            dealerAd.setAccountId(accountId);
                            dealerAd.setCoins(betType);
                            dealerAd.setTaskId(task.getTaskId());
                            dealerAd.setFromType(TradeTypeEnum.TaskLotteryIncome);
                            dealerAd.setCreateBy(task.getUserId());
                            dealerAd.setCreateDate(new Timestamp(System.currentTimeMillis()));
                            accountDetailMapper.insert(dealerAd);
                        }
                        dealerAccount.get(i).setCoinBalance(accountEntity.getCoinBalance() + betType);
                        dealerAccount.get(i).setCoinIncome(accountEntity.getCoinIncome() + betType);
                        accountMapper.updateAccountCoins(accountEntity);
                    }


                    if (answer.getIsRight() == 1) {
                        //有人猜对了，赔钱货
                        double dealerExpendCoins = clientCoinBet * answer.getOdds();
                        double dealerExpendBeans = clientBeanBet * answer.getOdds();
                        //生成庄家 发布竞猜赔付
                        for (int i = 0; i < 2; i++) {
                            ClientAccountEntity accountEntity = dealerAccount.get(i);
                            double expendType = 0;
                            long accountId = 0;
                            if (accountEntity.getCoinType() == CurrencyTypeEnum.Coin) {
                                accountId = accountEntity.getAccountId();
                                expendType = dealerExpendCoins;
                            } else {
                                accountId = accountEntity.getAccountId();
                                expendType = dealerExpendBeans;
                            }
                            ClientAccountDetailEntity dealerExpend = new ClientAccountDetailEntity();
                            if (expendType != 0) {
                                dealerExpend.setUserId(task.getUserId());
                                dealerExpend.setAccountId(accountId);
                                dealerExpend.setCoins(expendType);
                                dealerExpend.setTaskId(task.getTaskId());
                                dealerExpend.setFromType(TradeTypeEnum.TaskLotteryExpend);
                                dealerExpend.setCreateBy(task.getUserId());
                                dealerExpend.setCreateDate(new Timestamp(System.currentTimeMillis()));
                                accountDetailMapper.insert(dealerExpend);
                            }
                            dealerAccount.get(i).setCoinBalance(accountEntity.getCoinBalance() - expendType);
                            dealerAccount.get(i).setCoinIncome(accountEntity.getCoinIncome() - expendType);
                            accountMapper.updateAccountCoins(accountEntity);
                        }
                    }
                    // </editor-fold>
                }
            }
            lotteryResult.setAnswer(answerInfo);

            // <editor-fold desc="庄家发布时冻结的金币解冻处理">

            //这个函数只更新冻结金币，余额以及收支统计由触发器处理
            dealerCoinAccount.setCoinLocked(dealerCoinAccount.getCoinLocked() - coinLocked);
            accountMapper.updateAccountCoins(dealerCoinAccount);

            // </editor-fold>

            // <editor-fold desc = "提交开奖状态">
            task.setTaskStatus(TaskStatusEnum.Complete);
            task.setSettleTime(new Timestamp(System.currentTimeMillis()));
            //task.setLotteryResult(jacksonSerializer.toJson(lotteryResult));
            task.setSettleCoins(lotteryResult.getCoinIncomeTotal() - lotteryResult.getCoinExpendTotal());
            task.setUpdateBy(task.getUserId());
            task.setUpdateDate(task.getUpdateDate());
            taskMapper.updateLotteryComplete(task);

            // </editor-fold>

            // <editor-fold desc="庄家盈亏通知 跑马灯消息">

            //跑马灯消息
            int ieCoins = new Double(dealerCoinAccount.getCoinBalance() - orgCoinBalance).intValue();
            if(ieCoins > 0){
                String content = String.format("恭喜玩家%s在发布的竞猜中赢了%s金币", dealerName, ieCoins);
                marqueeQueueService.insertMarqueeRoll(MarqueeTypeEnum.DealerIncome,content,task.getTaskId());

            }else if(ieCoins < 0){
                String content = String.format("很遗憾，玩家%s发布竞猜输了%s金币", dealerName, Math.abs(ieCoins));
                marqueeQueueService.insertMarqueeRoll(MarqueeTypeEnum.DealerExpend,content,task.getTaskId());
            }

            // </editor-fold>

            // <editor-fold desc = "记录开奖日志">
            TaskLotteryLogsEntity logEntity = new TaskLotteryLogsEntity();
            logEntity.setTaskId(task.getTaskId());
            logEntity.setUserId(task.getUserId());
            logEntity.setIsSuccess(1);
            logEntity.setLotteryResult(jacksonSerializer.toJson(lotteryResult));
            logEntity.setLotteryTime(new Timestamp(System.currentTimeMillis()));
            logEntity.setCreateBy(task.getUserId());
            logEntity.setCreateDate(new Timestamp(System.currentTimeMillis()));
            lotteryLogsMapper.insert(logEntity);

            LOTTERY_LOGGER.info(String.format("竞猜项目【%s】开奖成功",task.getTaskId()));
            // </editor-fold>

            //开奖结果通知 放到业务外部处理 ，这里注释掉
            //this.runLotterySuccessNotify(taskId, null);

        }catch (Exception e){
            e.printStackTrace();

            //重新扔回REDIS队列，等待5分钟后处理
            this.pushCountDownLotteryQueue(task.getTaskId(),5*60);

            //事务处理由SpringMvc处理，只要跑出ApiException就可以
            throw new ApiException(ErrorCodeEnum.SystemError.getCode(),e.getMessage());
        }

        return lotteryResult;
    }

    /**
     * 开奖处理
     * @param taskId 开奖项目
     * @param answerId 竞猜正确答案
     * @return
     * @throws ApiException
     */
    public LotteryResultVo runLotteryProcess(long taskId,long answerId) throws ApiException{
        //设定正确答案
        taskAnswerService.resetRightAnswer(taskId, answerId);

        //开奖处理
        return this.runLotteryProcess(taskId, true);
    }

    /**
     * 开奖成功结果通知
     * @param resultVo 竞猜项目开奖结果
     */
    public void runLotterySuccessNotify(LotteryResultVo resultVo){
        // <editor-fold desc="跑马灯消息及时通知">

        try {

            JSONObject payload = new JSONObject();
            payload.put("type","award");
            JSONObject msg = new JSONObject();
            msg.put("task",resultVo.getTaskId());
            msg.put("content","竞猜项目开奖啦，快去看看收益吧");
            payload.put("award",msg);
            MessageQueueProducer queueProducer = (MessageQueueProducer) SpringContextUtil.getBean("sendMessage");
            queueProducer.sendPushMessage(jacksonSerializer.toJson(payload));

            LOTTERY_LOGGER.info(String.format("竞猜项目【%s】开奖成功通知已发", resultVo.getTaskId()));
        }catch (Exception e){
            e.printStackTrace();
            LOTTERY_LOGGER.error(String.format("竞猜项目【%s】开奖成功通知发送失败", resultVo.getTaskId()),e);
        }
        // </editor-fold>

        // <editor-fold desc="微信用户模板消息通知">
        try{

            boolean rtn =  messageService.sendLotteryMessage(resultVo);

        }catch (Exception e){
            e.printStackTrace();
            //TODO 通知失败 暂时不处理

        }
        // </editor-fold>
    }

    /**
     * {@link com.cicada.service.impl.TaskServiceImpl#selectTaskVoByPage(JSONObject, Integer, Integer, Integer)}
     *
     * 获取竞猜项目列表
     * @param params 查询参数
     * @param page 页码
     * @param rows 返回行数
     * @param draw
     * @return
     * @throws ApiException
     */
    @Deprecated
    public DatatablesResult<TaskVo> selectTaskVo(JSONObject params, Integer page, Integer rows, Integer draw) throws ApiException{

        DatatablesResult pageResult = new DatatablesResult<TaskVo>();
        try {
            PageHelper.startPage(page, rows);
            List<TaskVo> taskVos = this.taskMapper.selectTaskVo();
            PageInfo<TaskVo> pageInfo = new PageInfo<>(taskVos);

            pageResult.setData(taskVos);
            pageResult.setDraw(draw);
            pageResult.setRecordsTotal((int) pageInfo.getTotal());
            pageResult.setRecordsFiltered(pageResult.getRecordsTotal());

        }catch (Exception e){
            e.printStackTrace();
            throw new ApiException(ErrorCodeEnum.SystemError.getCode(), ErrorCodeEnum.SystemError.getDesc());
        }

        return pageResult;
    }

    /**
     * 分页查询竞猜项目列表
     * @param params 查询参数
     * @param page 页码
     * @param rows 返回行数
     * @param draw
     * @return
     * @throws ApiException
     */
    public DatatablesResult<TaskVo> selectTaskVoByPage(JSONObject params, Integer page, Integer rows, Integer draw) throws ApiException{
        DatatablesResult pageResult = new DatatablesResult<TaskVo>();
        try {
            Map<String,Object> whereMap = CicadaUtil.toHashMap(params);
            whereMap.put("limit",rows);
            whereMap.put("offset",rows*(page - 1));
            List<TaskVo> taskVos = this.taskMapper.selectTaskVoByPage(whereMap);
            SystemConfig sysConfig = SystemConfig.getInstance();

            for (TaskVo task:taskVos) {
                List<TaskPicturesVo> picList = task.getPicturesVoList();
                for (TaskPicturesVo pic:picList) {
                    String newUrl = sysConfig.getURL_BASE_IMG_TASK() + pic.getPicUrl();
                    pic.setPicUrl(newUrl);
                }
            }
            pageResult.setData(taskVos);
            pageResult.setDraw(draw);
            pageResult.setRecordsTotal((int) taskMapper.selectTaskTotal(whereMap));
            pageResult.setRecordsFiltered(pageResult.getRecordsTotal());

        }catch (Exception e){
            e.printStackTrace();
            throw new ApiException(ErrorCodeEnum.SystemError.getCode(), ErrorCodeEnum.SystemError.getDesc());
        }

        return pageResult;
    }

    /**
     * 发布竞猜
     * @param params 前台提交的参数
     * @param imgRightResult 正确答案图片上传结果
     * @param imgOthersResult 错误答案图片上传结果
     * @return
     * @throws ApiException
     */
    public Task publish(JSONObject params, PicUploadResult imgRightResult, List<PicUploadResult> imgOthersResult) throws ApiException{

        Task task = new Task();
        try {
            int shiroUser = params.getIntValue("shiro_user");

            // <editor-fold desc="保存竞猜项目">
            //保存竞猜项目
            int taskId = params.getIntValue("task_id");
            if( taskId > 0) {
                task.setTaskId(taskId);
                task.setCreateBy(shiroUser);
                task.setCreateDate(new Timestamp(System.currentTimeMillis()));
            }
            TaskTypeEnum taskType = CodeEnumUtil.codeOf(TaskTypeEnum.class, params.getInteger("task_type"));
            int quantity = params.getIntValue("quantity");
            int salePrice = params.getIntValue("sale_price");

            task.setUserId(params.getIntValue("user_id"));
            task.setTaskType(taskType);
            task.setTaskContent(params.getString("task_content"));
            task.setTaskTitle(taskType.getDesc());
            task.setTaskStatus(TaskStatusEnum.Published);

            String lockTime =  params.getString("lock_time");
            if(!StringUtils.isEmpty(lockTime))
                task.setLockTime(Timestamp.valueOf(lockTime));

            String settleTime = params.getString("settle_time");
            if(!StringUtils.isEmpty(settleTime))
                task.setSettleTime(Timestamp.valueOf(settleTime));
            else
                task.setSettleTime(new Timestamp(System.currentTimeMillis() + 1000L * 60L * 60L * 99L));

            task.setQuantity(quantity);
            task.setSalePrice(salePrice);
            task.setSaleAmount(quantity * salePrice);
            task.setIsHot(params.getIntValue("hot"));
            task.setUpdateBy(shiroUser);
            task.setUpdateDate(new Timestamp(System.currentTimeMillis()));
            super.insertOrUpdate(task);
            // </editor-fold>

            if(taskType == TaskTypeEnum.QUIZ || taskType == TaskTypeEnum.COMING) {
                // <editor-fold desc="保存正确答案">
                //保存正确答案
                TaskAnswer right = new TaskAnswer();
                int rightAnswerId = params.getIntValue("answer_right_id");
                if (rightAnswerId > 0) {
                    right.setAnswerId(rightAnswerId);
                }
                right.setTaskId(task.getTaskId());
                right.setAnswer(params.getString("answer_right"));
                right.setOdds(params.getDouble("answer_right_odds"));
                right.setIsRight(taskType == TaskTypeEnum.QUIZ ? 1:0);
                right.setCreateBy(params.getIntValue("shiro_user"));
                right.setCreateDate(new Timestamp(System.currentTimeMillis()));
                right.setUpdateBy(params.getIntValue("shiro_user"));
                right.setUpdateDate(new Timestamp(System.currentTimeMillis()));
                if (right.getAnswerId() > 0)
                    taskAnswerMapper.updateById(right);
                else
                    taskAnswerMapper.insert(right);
                // </editor-fold>

                // <editor-fold desc="保存错误答案">
                //保存错误答案
                TaskAnswer errAnswer = new TaskAnswer();
                int errAnswerId = params.getIntValue("answer_err_id");
                if (errAnswerId > 0) {
                    errAnswer.setAnswerId(errAnswerId);
                }
                errAnswer.setTaskId(task.getTaskId());
                errAnswer.setAnswer(params.getString("answer_err"));
                errAnswer.setOdds(params.getDouble("answer_err_odds"));
                errAnswer.setIsRight(0);
                errAnswer.setCreateBy(shiroUser);
                errAnswer.setCreateDate(new Timestamp(System.currentTimeMillis()));
                errAnswer.setUpdateBy(shiroUser);
                errAnswer.setUpdateDate(new Timestamp(System.currentTimeMillis()));
                if (errAnswer.getAnswerId() > 0)
                    taskAnswerMapper.updateById(errAnswer);
                else
                    taskAnswerMapper.insert(errAnswer);
                // </editor-fold>

                // <editor-fold desc="保存参考图片">
                if(imgRightResult!=null) {
                    if (imgRightResult.getError() == 0) {
                        TaskPicture pic = this.converUploadResult(task.getTaskId(), shiroUser, imgRightResult);
                        pic.setPicType(TaskPicTypeEnum.AnswerImages);
                        taskPictureMapper.insert(pic);
                    } else {
                        throw new ApiException(ErrorCodeEnum.ImageUploadError);
                    }
                }
                if(imgOthersResult!=null) {
                    for (PicUploadResult uploadResult : imgOthersResult) {

                        if (uploadResult.getError() == 0) {
                            TaskPicture pic = this.converUploadResult(task.getTaskId(), shiroUser, uploadResult);
                            pic.setPicType(TaskPicTypeEnum.OtherImages);
                            taskPictureMapper.insert(pic);
                        } else {
                            throw new ApiException(ErrorCodeEnum.ImageUploadError);
                        }
                    }
                }
                // </editor-fold>
            }else{
                // <editor-fold desc="保存球队信息">
                // TODO 更新处理
                TaskFootball teamA = new TaskFootball();
                teamA.setTaskId(task.getTaskId());
                teamA.setCourtType(CourtTypeEnum.HomeField);
                teamA.setTeamName(params.getString("team_name_a"));
                teamA.setCreateBy(shiroUser);
                teamA.setCreateDate(new Timestamp(System.currentTimeMillis()));
                teamA.setUpdateBy(shiroUser);
                teamA.setUpdateDate(new Timestamp(System.currentTimeMillis()));
                taskFootballMapper.insert(teamA);

                TaskFootball teamB = new TaskFootball();
                teamB.setTaskId(task.getTaskId());
                teamB.setCourtType(CourtTypeEnum.UnfamiliarField);
                teamB.setTeamName(params.getString("team_name_b"));
                teamB.setCreateBy(shiroUser);
                teamB.setCreateDate(new Timestamp(System.currentTimeMillis()));
                teamB.setUpdateBy(shiroUser);
                teamB.setUpdateDate(new Timestamp(System.currentTimeMillis()));
                taskFootballMapper.insert(teamB);
                // </editor-fold>

                // <editor-fold desc="保存赔率信息">

                //主场胜
                TaskAnswer answerAwin = new TaskAnswer();
                int answerAwinId = params.getIntValue("answer_awin_id");
                if (answerAwinId > 0) {
                    answerAwin.setAnswerId(answerAwinId);
                }
                answerAwin.setTaskId(task.getTaskId());
                answerAwin.setAnswer("主胜");
                answerAwin.setOdds(params.getDouble("odds_a_win"));
                answerAwin.setIsRight(0);
                answerAwin.setCreateBy(shiroUser);
                answerAwin.setCreateDate(new Timestamp(System.currentTimeMillis()));
                answerAwin.setUpdateBy(shiroUser);
                answerAwin.setUpdateDate(new Timestamp(System.currentTimeMillis()));
                if (answerAwin.getAnswerId() > 0)
                    taskAnswerMapper.updateById(answerAwin);
                else
                    taskAnswerMapper.insert(answerAwin);

                //篮球没有平局
                if(taskType.equals(TaskTypeEnum.FOOTBALL)) {
                    //平局
                    TaskAnswer dogfall = new TaskAnswer();
                    int dogfallId = params.getIntValue("answer_dogfall_id");
                    if (dogfallId > 0) {
                        dogfall.setAnswerId(dogfallId);
                    }
                    dogfall.setTaskId(task.getTaskId());
                    dogfall.setAnswer("平");
                    dogfall.setOdds(params.getDouble("odds_dogfall"));
                    dogfall.setIsRight(0);
                    dogfall.setCreateBy(shiroUser);
                    dogfall.setCreateDate(new Timestamp(System.currentTimeMillis()));
                    dogfall.setUpdateBy(shiroUser);
                    dogfall.setUpdateDate(new Timestamp(System.currentTimeMillis()));
                    if (dogfall.getAnswerId() > 0)
                        taskAnswerMapper.updateById(dogfall);
                    else
                        taskAnswerMapper.insert(dogfall);
                }
                //客场胜
                TaskAnswer answerBwin = new TaskAnswer();
                int answerBwinId = params.getIntValue("answer_bwin_id");
                if (answerBwinId > 0) {
                    answerBwin.setAnswerId(answerBwinId);
                }
                answerBwin.setTaskId(task.getTaskId());
                answerBwin.setAnswer("客胜");
                answerBwin.setOdds(params.getDouble("odds_b_win"));
                answerBwin.setIsRight(0);
                answerBwin.setCreateBy(shiroUser);
                answerBwin.setCreateDate(new Timestamp(System.currentTimeMillis()));
                answerBwin.setUpdateBy(shiroUser);
                answerBwin.setUpdateDate(new Timestamp(System.currentTimeMillis()));
                if (answerBwin.getAnswerId() > 0)
                    taskAnswerMapper.updateById(answerBwin);
                else
                    taskAnswerMapper.insert(answerBwin);
                // </editor-fold>
            }

            LOTTERY_LOGGER.info(String.format("竞猜项目【%s】发布成功！",task.getTaskId()));
        }catch (ApiException e){
            throw e;
        }catch (Exception e){
            LOTTERY_LOGGER.error(e.getMessage(),e);
            throw new ApiException(ErrorCodeEnum.ArgumentException);
        }

        return task;
    }

    /**
     * 加入倒计时开奖队列
     * @param taskId 竞猜项目ID
     * @param expire 倒计时时间（秒）
     */
    public void pushCountDownLotteryQueue(long taskId,int expire){

        try {
            //发布成功提交REDIS，倒计时开奖
            JedisPool jedisPool = (JedisPool)SpringContextUtil.getBean("jedisPool");
            String key = ConstantInterface.REDIS_KEY_LOTTERY_PREFIX + String.valueOf(taskId);
            jedisPool.getResource().setex(key, expire, String.format("待开奖任务 %s", taskId));

            LOTTERY_LOGGER.info(String.format("竞猜项目【%s】 成功加入倒计时开奖队列，过期时间%s秒", taskId,expire));
        }catch (Exception e){
            e.printStackTrace();
            //REDIS提交失败 不能影响业务流程
            LOTTERY_LOGGER.error(String.format("竞猜项目【%s】加入倒计时开奖队列失败,过期时间%s秒，原因：%s",taskId,expire, e.getMessage()),e);
        }
    }

    private TaskPicture converUploadResult(long taskId,int shiroUser,PicUploadResult result){
        TaskPicture pic = new TaskPicture();
        pic.setTaskId(taskId);
        pic.setPicType(TaskPicTypeEnum.AnswerImages);
        pic.setPicUrl(result.getUrl());
        pic.setBlurPicUrl(result.getBlurFileUrl());
        pic.setCreateBy(shiroUser);
        pic.setCreateDate(new Timestamp(System.currentTimeMillis()));
        pic.setUpdateBy(shiroUser);
        pic.setUpdateDate(new Timestamp(System.currentTimeMillis()));

        return pic;
    }

    /**
     * 锁定竞猜项目
     * @param taskId 需要锁定的竞猜项目
     * @return
     */
    public boolean lockTask(long taskId) throws ApiException{
        List<Long> ids = new ArrayList<>();
        ids.add(taskId);

        return this.lockTask(ids);
    }

    /**
     * 锁定竞猜项目
     * @param taskIds 所有需要锁定的竞猜项目
     * @return
     */
    public boolean lockTask(List<Long> taskIds) throws ApiException{
        if(null == taskIds || taskIds.size()==0) throw new ApiException(ErrorCodeEnum.ArgumentException);

        boolean rtn =false;
        try{

            for (long id:taskIds) {
                taskMapper.updateTaskLocked(id);
            }

        }catch (Exception e){
            throw new ApiException(ErrorCodeEnum.ArgumentException);
        }

        return rtn;
    }

    /**
     * 检查所有待开奖任务（倒计时 未及时处理的）
     * @return
     * @throws ApiException
     */
    public List<TaskVo> selectWattingLotteryTasks() throws ApiException{
        return taskMapper.selectWattingLotteryTasks();
    }

    /**
     * 获取竞猜详情
     * @param params
     * @return
     * @throws ApiException
     */
    public TaskVo selectTaskVo(JSONObject params) throws ApiException{
        try {
            Map<String, Object> whereMap = CicadaUtil.toHashMap(params);
            TaskVo vo = taskMapper.selectTaskVo(whereMap);


            List<TaskOrderVo> orderVoList=vo.getOrderVoList();

            int sale_price=vo.getSalePrice();//单注
            double profit = 0;//玩家赢
            double loss=0;//玩家亏
            double profit_and_loss_playtotal = 0;//玩家盈亏

            double profit_total = 0;//玩家赢
            double loss_total=0;//玩家亏

            List<TaskAnswerVo> answerVoList;
            for(TaskOrderVo taskOrderVo:orderVoList){
                answerVoList=taskOrderVo.getAnswerVoList();

                //判断是否有人下注
                if(taskOrderVo.getUserName()==null){
                    vo.setOrderVoList(null);
                    break;
                }

                for (TaskAnswerVo taskAnswer:answerVoList){
                    if(taskAnswer.getIsRight()==1){
                        System.out.println(taskOrderVo.getQuantity());
                        System.out.println(taskAnswer.getOdds());
                        profit=taskAnswer.getQuantity()*(taskAnswer.getOdds()-1)*sale_price;
                        loss_total+=profit;
                    }else if(taskAnswer.getIsRight()==0){
                        loss=taskAnswer.getQuantity()*sale_price;
                        profit_total+=loss;
                    }
                    profit_and_loss_playtotal=ArithUtil.round(profit-loss,0);
                    //profit_and_loss_playtotal= new BigDecimal(Double.toString(profit)).multiply(new BigDecimal(Double.toString(loss))).doubleValue();
                }
                taskOrderVo.setProfit_and_loss_usertotal(profit_and_loss_playtotal);
                //计算完一个玩家后，清0
                profit = 0;//玩家赢
                loss=0;//玩家亏
                profit_and_loss_playtotal = 0;//玩家盈亏
            }

            vo.setProfitTotal(ArithUtil.round(profit_total,0));
            vo.setLossTotal(ArithUtil.round(loss_total,0));

            SystemConfig sysConfig = SystemConfig.getInstance();

            List<TaskPicturesVo> picList = vo.getPicturesVoList();
            for (TaskPicturesVo pic:picList) {
                String newUrl = sysConfig.getURL_BASE_IMG_TASK() + pic.getPicUrl();
                pic.setPicUrl(newUrl);
            }

            return vo;
        }catch (Exception e){
            throw new ApiException(ErrorCodeEnum.SystemError.getCode(),e.getMessage());
        }
    }
}
