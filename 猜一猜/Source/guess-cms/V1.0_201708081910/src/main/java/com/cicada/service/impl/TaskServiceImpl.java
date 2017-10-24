package com.cicada.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.cicada.commons.Exception.ApiException;
import com.cicada.commons.utils.*;
import com.cicada.enums.*;
import com.cicada.mapper.*;
import com.cicada.pojo.*;
import com.cicada.pojo.vo.LotteryResultVo;
import com.cicada.pojo.vo.TaskPicturesVo;
import com.cicada.pojo.vo.TaskVo;
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

import java.sql.Timestamp;
import java.util.*;
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

        //获取竞猜项目的所有答案
        Map<String,Object> queryMap = new HashMap<>();
        queryMap = new HashMap<>();
        queryMap.put("task_id",task.getTaskId());
        List<TaskAnswer> answerList = taskAnswerMapper.selectByMap(queryMap);
        List<TaskAnswer> temp = answerList.stream().filter(x -> x.getIsRight() == 1).collect(Collectors.toList());
        if(temp.size() == 0) {
            //重新扔回REDIS队列，等待5分钟后处理
            JedisPool jedisPool = (JedisPool)SpringContextUtil.getBean("jedisPool");
            String key = ConstantInterface.REDIS_KEY_LOTTERY_PREFIX + String.valueOf(task.getTaskId());
            if(jedisPool.getResource().exists(key)) jedisPool.getResource().del(key);
            jedisPool.getResource().setex(key,5*60,String.format("待开奖%s",task.getTaskId()));

            //必须先设置正确答案
            throw new ApiException(ErrorCodeEnum.TaskRightAnswerNotFound);
        }
        // </editor-fold>

        Map<String,Integer> msgMap = new HashMap<>();
        double orgBalance = 0;//原账户余额

        //参与玩家 每个答案的盈亏合计发通知用
        LotteryResultVo lotteryResult= new LotteryResultVo(task.getTaskId(),task.getUserId(),task.getTaskContent(),task.getSalePrice(),"");
        //微信模板消息通知的时候带上答案信息
        String answerInfo = "";
        try
        {
            //玩家发布项目时冻结的金币
            double coinLocked = task.getQuantity() * task.getSalePrice() * (temp.get(0).getOdds() - 1);
            //未来事件 发布的时候是不知道正确答案，冻结金币是按最大赔率计算的，保存在locked_coins字段
            if(task.getLockedCoins() > 0){
                coinLocked = task.getLockedCoins();
            }

            //获取竞猜项目的所有下注订单
            queryMap.put("task_id",task.getTaskId());
            List<TaskOrder> orders = taskOrderMapper.selectByMap(queryMap);

            //获取庄家账户
            queryMap = new HashMap<>();
            queryMap.put("user_id",task.getUserId());
            ClientAccountEntity dealerAccount = accountMapper.selectByMap(queryMap).get(0);
            orgBalance = dealerAccount.getCoinBalance();

            ClientEntity dealer = clientMapper.selectById(task.getUserId());
            String dealerName = StringUtils.isEmpty(dealer.getNickname())?dealer.getPhonenumber():dealer.getNickname();
            int cnt = 0;
            for (TaskAnswer answer:answerList) {
                cnt++;
                char abc = (char)(cnt+64);
                //在微信消息中换行用 \r\n
                answerInfo +=String.format("%s.%s%s \r\n",abc,answer.getAnswer(),answer.getIsRight()==1?"【开奖答案】":"");

                List<TaskOrder> answerOrders = orders.stream()
                        .filter(x -> x.getAnswerId() == answer.getAnswerId())
                        .collect(Collectors.toList());

                //没人买过这个答案
                if(answerOrders.size()==0) continue;

                // <editor-fold desc="每个玩家的下注合计">
                Map<Long, Integer> userCount = new HashMap<>();
                for (int i = answerOrders.size() - 1; i>=0; i--) {
                    TaskOrder x = answerOrders.get(i);
                    Integer qty = userCount.containsKey(x.getUserId())?userCount.get(x.getUserId())+x.getQuantity():x.getQuantity();
                    userCount.put(x.getUserId(),qty);
                    answerOrders.remove(i);
                }
                // </editor-fold>

                // <editor-fold desc="开奖结算处理--玩家">

                //这个答案的下注合计
                int totalQty = 0;
                //玩家收支金币
                double coins;
                for (Map.Entry<Long,Integer> entry:userCount.entrySet()) {
                    totalQty += entry.getValue();
                    coins = 0;

                    if(answer.getIsRight() == 1) {

                        //恭喜你猜对了~
                        coins = task.getSalePrice() * entry.getValue() * answer.getOdds();
                        queryMap = new HashMap<>();
                        queryMap.put("user_id",entry.getKey());
                        ClientAccountEntity accountEntity = accountMapper.selectByMap(queryMap).get(0);
                        //生成玩家收支明细
                        ClientAccountDetailEntity detailEntity = new ClientAccountDetailEntity();
                        detailEntity.setUserId(entry.getKey());
                        detailEntity.setAccountId(accountEntity.getAccountId());
                        detailEntity.setCoins(coins);
                        detailEntity.setTaskId(task.getTaskId());
                        detailEntity.setFromType(TradeTypeEnum.TaskReward);
                        detailEntity.setCreateBy(task.getUserId());
                        detailEntity.setCreateDate(new Timestamp(System.currentTimeMillis()));
                        accountDetailMapper.insert(detailEntity);

                        //玩家账户信息表数据
                        accountEntity.setCoinBalance(accountEntity.getCoinBalance()+coins);
                        accountEntity.setCoinIncome(accountEntity.getCoinIncome()+coins);
                        accountMapper.updateAccountCoins(accountEntity);

                        //跑马灯消息
                        ClientEntity client = clientMapper.selectById(entry.getKey());
                        String clientName = StringUtils.isEmpty(client.getNickname())?client.getPhonenumber():client.getNickname();
                        String content = String.format("玩家%s猜对了%s发布的竞猜，赢了%s金币", clientName,dealerName, new Double(coins).intValue());
                        marqueeQueueService.insertMarqueeRoll(MarqueeTypeEnum.LotteryWinners,content,task.getTaskId());

                        coins = task.getSalePrice() * entry.getValue() * (answer.getOdds() - 1);
                    }
                    else {
                        //智商是硬伤啊~
                        coins = task.getSalePrice() *  entry.getValue();
                    }

                    LOTTERY_LOGGER.info(String.format("玩家【%s】购买答案【%s】，%s注", entry.getKey(),answer.getAnswerId(),entry.getValue()));
                    lotteryResult.addPlayerResult(entry.getKey(),answer.getAnswerId(),abc,
                            answer.getIsRight()==1,answer.getOdds(),entry.getValue(),coins);
                }
                // </editor-fold>

                // <editor-fold desc="开奖结算处理--庄家">

                //哼哼，你猜错了 钱拿来
                double clientBet = task.getSalePrice() * totalQty;
                //生成庄家 发布竞猜盈利
                ClientAccountDetailEntity dealerAd = new ClientAccountDetailEntity();
                dealerAd.setUserId(task.getUserId());
                dealerAd.setAccountId(dealerAccount.getAccountId());
                dealerAd.setCoins(clientBet);
                dealerAd.setTaskId(task.getTaskId());
                dealerAd.setFromType(TradeTypeEnum.TaskLotteryIncome);
                dealerAd.setCreateBy(task.getUserId());
                dealerAd.setCreateDate(new Timestamp(System.currentTimeMillis()));
                accountDetailMapper.insert(dealerAd);

                //更新庄家账户信息表数据
                dealerAccount.setCoinBalance(dealerAccount.getCoinBalance() + clientBet);
                dealerAccount.setCoinIncome(dealerAccount.getCoinIncome() + clientBet);

                if(answer.getIsRight() == 1){
                    //有人猜对了，赔钱货
                    double dealerExpendCoins = task.getSalePrice() * totalQty * answer.getOdds();
                    //生成庄家 发布竞猜赔付
                    ClientAccountDetailEntity dealerExpend = new ClientAccountDetailEntity();
                    dealerExpend.setUserId(task.getUserId());
                    dealerExpend.setAccountId(dealerAccount.getAccountId());
                    dealerExpend.setCoins(dealerExpendCoins);
                    dealerExpend.setTaskId(task.getTaskId());
                    dealerExpend.setFromType(TradeTypeEnum.TaskLotteryExpend);
                    dealerExpend.setCreateBy(task.getUserId());
                    dealerExpend.setCreateDate(new Timestamp(System.currentTimeMillis()));
                    accountDetailMapper.insert(dealerExpend);

                    //更新庄家账户信息表数据
                    dealerAccount.setCoinBalance(dealerAccount.getCoinBalance() - dealerExpendCoins);
                    dealerAccount.setCoinIncome(dealerAccount.getCoinIncome() - dealerExpendCoins);
                }

                // </editor-fold>
            }
            lotteryResult.setAnswer(answerInfo);

            // <editor-fold desc="庄家发布时冻结的金币解冻处理">

            //这个函数只更新冻结金币，余额以及收支统计由触发器处理
            dealerAccount.setCoinLocked(dealerAccount.getCoinLocked() - coinLocked);
            accountMapper.updateAccountCoins(dealerAccount);

            // </editor-fold>

            // <editor-fold desc = "提交开奖状态">
            task.setTaskStatus(TaskStatusEnum.Complete);
            task.setSettleTime(new Timestamp(System.currentTimeMillis()));
            task.setLotteryResult(jacksonSerializer.toJson(lotteryResult));
            task.setSettleCoins(lotteryResult.getIncomeTotal() - lotteryResult.getExpendTotal());
            task.setUpdateBy(task.getUserId());
            task.setUpdateDate(task.getUpdateDate());
            taskMapper.updateLotteryComplete(task);

            // </editor-fold>

            // <editor-fold desc="庄家盈亏通知 跑马灯消息">

            //跑马灯消息
            int ieCoins = new Double(dealerAccount.getCoinBalance() - orgBalance).intValue();
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

            LOTTERY_LOGGER.info(String.format("竞猜项目【%s】成功加入倒计时开奖队列，过期时间%s秒", taskId,expire));
        }catch (Exception e){
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
}
