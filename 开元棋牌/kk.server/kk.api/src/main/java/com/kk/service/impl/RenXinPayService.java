package com.kk.service.impl;


import com.kk.commons.Exception.ApiException;
import com.kk.commons.utils.*;
import com.kk.entity.*;
import com.kk.entity.vo.RenXinPayVo;
import com.kk.enums.*;
import com.kk.kygame.GameRsp;
import com.kk.kygame.HttpClientUtil;
import com.kk.kygame.IGameConnector;
import com.kk.kygame.dentity.DBack;
import com.kk.mapper.*;

import com.kk.redis.RedisHelper;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;

import com.kk.service.*;
import org.apache.log4j.LogManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.jms.Destination;
import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.util.*;

/**
 * Created by Administrator on 2017/8/22.
 */

@Service
@Transactional
public class RenXinPayService implements IRenXinPayService {

    private static final org.apache.log4j.Logger RECHARGE_LOGGER = LogManager.getLogger("kkrecharge");

    private static final org.apache.log4j.Logger GAMES = LogManager.getLogger("kkgames");


    @Autowired
    private SystemConfig systemConfig;

    @Autowired
    private ItemMapper itemMapper;
    @Autowired
    private PaymentRecordMapper paymentRecordMapper;
    @Autowired
    private PaymentMapper paymentMapper;
    @Autowired
    private UserAccountDetailMapper accountDetailMapper;
    @Autowired
    private UserAccountMapper accountMapper;
    @Autowired
    private UserMapper userMapper;

    @Autowired
    private IGameConnector gameConnector;

    @Autowired
    private IRechargeService rechargeService;

    @Autowired
    private IMessageProducerService producerService;
    @Autowired
    @Qualifier("payNotifyQueueDestination")
    private Destination payDestination;

    @Autowired
    private IMessageService messageService;
    @Autowired
    private IMessageContentService messageContentService;

    /**
     * 请求支付
     * @param params 支付参数
     * @return
     * @throws ApiException
     * payment_mode : 7-QQ钱包,  5-支付宝,  2-微信二维码
     * item_id
     */
    public RenXinPayVo requestPay(UserEntity user, JSONObject params) throws ApiException{

        if(user.getUserId() != null){
            UserEntity userEntity=userMapper.selectById(user.getUserId());
            if(userEntity.getUserType().getCode() == UserTypeEnum.Tourist.getCode()){
                throw new ApiException(ErrorCodeEnum.GoLoginRegister);
            }
        }

        RenXinPayVo renXinPayVo=new RenXinPayVo();

        //支付金额
        double payAmount = 0D;

        //前端有手动输入充值金额的需求，那就不能从后台设定了~ 坑爹
        ItemEntity item = itemMapper.selectById(params.getLong("item_id"));
        if (item == null) throw new ApiException(ErrorCodeEnum.ArgumentError);

        payAmount=item.getPrice();

        renXinPayVo.setPayMoney(payAmount);

        //支付类型
        PaymentModeEnum paymentMode;
        if(params.get("payment_mode")==null || params.get("payment_mode").equals("")) throw new ApiException(ErrorCodeEnum.ArgumentError.getCode(),"参数payment_mode不能为空！");
        else paymentMode = CodeEnumUtil.codeOf(PaymentModeEnum.class,params.getIntValue("payment_mode"));

        String payment_mode=paymentMode.getDesc();

        String orderId=CodeFactory.generateRechargeCode();
        renXinPayVo.setOrderId(orderId);

        //保存充值记录
        RechargeEntity entity = new RechargeEntity();
        entity.setUserId(user.getUserId());
        entity.setRechargeCode(orderId);
        entity.setRechargeAmount(payAmount);
        entity.setRechargeStatus(RechargeStatusEnum.Paying);
        entity.setCreateBy(user.getUserId());
        entity.setCreateDate(new Timestamp(System.currentTimeMillis()));
        entity.setUpdateBy(user.getUserId());
        entity.setUpdateDate(new Timestamp(System.currentTimeMillis()));
        entity.setIsDelete(0);
        rechargeService.insert(entity);

        //保存支付记录
        PaymentRecordEntity record = new PaymentRecordEntity();
        record.setUserId(user.getUserId());
        record.setOrderode(entity.getRechargeCode());
        record.setPayAmount(payAmount);
        record.setPaymentTarget(PaymentTargetEnum.RechargePay);
        record.setPayStatus(PaymentStatusEnum.Paying);
        record.setCreateBy(user.getUserId());
        record.setCreateBy(user.getUserId());
        record.setCreateDate(new Timestamp(System.currentTimeMillis()));
        record.setUpdateBy(user.getUserId());
        record.setUpdateDate(new Timestamp(System.currentTimeMillis()));
        record.setIsDelete(0);
        paymentRecordMapper.insert(record);

        //支付明细
        PaymentEntity detail = new PaymentEntity();
        detail.setPayId(record.getRecordId());
        detail.setPaymentMode(paymentMode);
        detail.setAmountPaid(payAmount);
        detail.setPaymentStatus(PaymentStatusEnum.Paying);
        detail.setCreateBy(user.getUserId());
        detail.setCreateBy(user.getUserId());
        detail.setCreateDate(new Timestamp(System.currentTimeMillis()));
        detail.setUpdateBy(user.getUserId());
        detail.setUpdateDate(new Timestamp(System.currentTimeMillis()));
        detail.setIsDelete(0);
        paymentMapper.insert(detail);

        //支付后前端获取不到新宝的同步通知，不知道支付状态，因此充值申请的时候先生成支付中的交易记录，等充值成功后再更新交易状态为已完成
        this.insertBalance(user.getUserId(),payAmount,RechargeStatusEnum.Paying,entity.getRechargeCode(),TradeTypeEnum.Recharge,entity.getRechargeId(),"玩家充值","",false);

        //仁信请求参数-直接拼接一个url给前端
        String URL=systemConfig.getRX_PAYMENT_REQUEST_URL()+"?partner=%s&version=%s&method=%s&banktype=%s&paymoney=%s&ordernumber=%s&callbackurl=%s&hrefbackurl=%s&goodsname=%s&attach=%s&isshow=%s&sign=%s";

        String partner=systemConfig.getRX_PAYMENT_PARTNER();
        String version=systemConfig.getRX_PAYMENT_API_VERSION();
        String method="Rx.online.pay";
        String banktype=payment_mode;
        String paymoney= new DecimalFormat("######0.00").format(payAmount);
        String ordernumber=record.getOrderode();
        String callbackurl=systemConfig.getRX_PAYMENT_NOTIFY_URL();
        String hrefbackurl=systemConfig.getRX_PAYMENT_RETURN_URL();
        String goodsname= item.getItemName();
        String attach=String.valueOf(record.getRecordId());
        String isshow="1";

        String Md5_str="version=%s&method=%s&partner=%s&banktype=%s&paymoney=%s&ordernumber=%s&callbackurl=%s%s";
        Md5_str=String.format(Md5_str,version,method,partner,banktype,paymoney,ordernumber,callbackurl,systemConfig.getRX_PAYMENT_SECRET_KEY());
        String sign = MD5Util.getMD5Str(Md5_str);

        if(banktype.equals("WEIXIN")){
            isshow="0";
        }

        URL=String.format(URL,partner,version,method,banktype,paymoney,ordernumber,callbackurl,hrefbackurl,goodsname,attach,isshow,sign);

        RECHARGE_LOGGER.info("支付的URL地址"+URL);
        renXinPayVo.setGetUrl(URL);

        if(banktype.equals("WEIXIN")){
            try {
                String respose= HttpClientUtil.get(URL);
                RECHARGE_LOGGER.info("微信支付返回结果"+respose);
                JSONObject jsonObject= JSON.parseObject(respose);
                String QRCode=jsonObject.getString("qrurl");
                RECHARGE_LOGGER.info("支付二维码"+QRCode);
                renXinPayVo.setQRCode(QRCode);
            }catch (Exception e){
                e.printStackTrace();
                RECHARGE_LOGGER.error(String.format("【%s】获取支付二维码失败，参数：%s",ordernumber,params.toJSONString()),e);
            }
        }

        return renXinPayVo;
    }



    /**
     * 支付回调
     * @param params 回调参数
     * @return
     * @throws ApiException
     */
    public String notifyProccess(JSONObject params) throws ApiException{

        String orderstatus = params.getString("orderstatus");
        if(StringUtils.isEmpty(orderstatus)) {
            throw new ApiException(ErrorCodeEnum.ArgumentError.getCode(),"orderstatus 参数为空");
        }

        String ordernumber=params.getString("ordernumber");
        if(StringUtils.isEmpty(ordernumber)) {
            throw new ApiException(ErrorCodeEnum.ArgumentError.getCode(),"ordernumber 参数为空");
        }

        String sysnumber=params.getString("sysnumber");
        if(StringUtils.isEmpty(sysnumber)) {
            throw new ApiException(ErrorCodeEnum.ArgumentError.getCode(),"sysnumber 参数为空");
        }


        String signSource = String.format("partner=%s&ordernumber=%s&orderstatus=%s&paymoney=%s%s", params.getString("partner"), params.getString("ordernumber"), params.getString("orderstatus"), params.getString("paymoney"), systemConfig.getRX_PAYMENT_SECRET_KEY());
        if (!params.getString("sign").equals(MD5Util.getMD5Str(signSource)))//签名正确
        {
            RECHARGE_LOGGER.error(String.format("【%s】支付通知接收失败，原因：%s，参数：%s",ordernumber,"验签失败",params.toJSONString()));
            throw new ApiException(ErrorCodeEnum.ArgumentError.getCode(),"【"+ordernumber+"】 验签失败"+params.toJSONString());
        }


        Map<String,Object> whereMap = new HashMap<>();
        whereMap.put("recharge_code",ordernumber);
        List<RechargeEntity> list = rechargeService.selectByMap(whereMap);
        if(list.size()==0){
            RECHARGE_LOGGER.error(String.format("【%s】支付通知接收失败，原因：%s，参数：%s",ordernumber,"订单不存在",params.toJSONString()));
            throw new ApiException(ErrorCodeEnum.ArgumentError.getCode(),"【"+ordernumber+"】 订单不存在");
        }
        RechargeEntity rechargeEntity = list.get(0);
        if(rechargeEntity.getRechargeStatus().getCode() != RechargeStatusEnum.Paying.getCode()){
            RECHARGE_LOGGER.error(String.format("【%s】支付通知接收失败，原因：%s，参数：%s",ordernumber,"订单已通知，不能重复通知",params.toJSONString()));
            RedisHelper.delKey(ConstantInterface.KEY_RECHARGE_NOTIFY+ordernumber);
            return "ok";
        }
        whereMap = new HashMap<>();
        whereMap.put("order_code",ordernumber);
        List<PaymentRecordEntity> tempRecord = paymentRecordMapper.selectByMap(whereMap);
        if(tempRecord.size()==0 ){
            RECHARGE_LOGGER.error(String.format("【%s】支付通知接收失败，原因：%s，参数：%s",ordernumber,"订单不存在",params.toJSONString()));
            throw new ApiException(ErrorCodeEnum.ArgumentError.getCode(),"【"+ordernumber+"】 订单不存在");
        }
        PaymentRecordEntity recordEntity = tempRecord.get(0);
        if(recordEntity.getPayStatus().getCode()!=PaymentStatusEnum.Paying.getCode()){
            RECHARGE_LOGGER.error(String.format("【%s】支付通知接收失败，原因：%s，参数：%s",ordernumber,"订单已通知，不能重复通知",params.toJSONString()));
            RedisHelper.delKey(ConstantInterface.KEY_RECHARGE_NOTIFY+ordernumber);
            return "ok";
        }

        whereMap = new HashMap<>();
        whereMap.put("pay_id",recordEntity.getRecordId());
        List<PaymentEntity> tempPayment = paymentMapper.selectByMap(whereMap);
        if(tempPayment.size()==0 ){
            RECHARGE_LOGGER.error(String.format("【%s】支付通知接收失败，原因：%s，参数：%s",ordernumber,"订单不存在",params.toJSONString()));
            throw new ApiException(ErrorCodeEnum.ArgumentError.getCode(),"【"+ordernumber+"】 订单不存在");
        }

        RedisTemplate<String, Object> redisTemplate = (RedisTemplate<String, Object>)SpringContextUtil.getBean("redisTemplate");
        RedisLockUtil lock = new RedisLockUtil(redisTemplate, ConstantInterface.KEY_RECHARGE_LOCK + ordernumber, 10000, 20000);
        try{
            if(lock.lock()) {
                if(orderstatus.equals("1")){
                    //交易成功
                    rechargeEntity.setRechargeStatus(RechargeStatusEnum.RechargeSuccess);
                    rechargeEntity.setSummery(params.toJSONString());
                    rechargeEntity.setUpdateBy(rechargeEntity.getCreateBy());
                    rechargeEntity.setUpdateDate(new Timestamp(System.currentTimeMillis()));
                    boolean result = rechargeService.updateById(rechargeEntity);
                    if(!result) throw new ApiException(ErrorCodeEnum.ExpiredDataException);
                    for (PaymentEntity payment:tempPayment) {
                        if(payment.getPaymentStatus().getCode()!=PaymentStatusEnum.Paying.getCode()) continue;

                        payment.setPaymentStatus(PaymentStatusEnum.PaySuccessed);
                        payment.setPaymentCode(sysnumber);
                        payment.setUpdateBy(rechargeEntity.getCreateBy());
                        payment.setUpdateDate(new Timestamp(System.currentTimeMillis()));
                        Integer rows = paymentMapper.updateById(payment);
                        if(rows.intValue()<1) throw new ApiException(ErrorCodeEnum.ExpiredDataException);
                    }

                    //开始充值
                    insertBalance(rechargeEntity.getUserId(),rechargeEntity.getRechargeAmount(),rechargeEntity.getRechargeStatus(),rechargeEntity.getRechargeCode(),TradeTypeEnum.Recharge,rechargeEntity.getRechargeId(),"玩家充值","",true);

                }else{
                    //交易失败
                    rechargeEntity.setRechargeStatus(RechargeStatusEnum.RechargeFailed);
                    rechargeEntity.setUpdateBy(rechargeEntity.getCreateBy());
                    rechargeEntity.setUpdateDate(new Timestamp(System.currentTimeMillis()));
                    boolean result = rechargeService.updateById(rechargeEntity);
                    if(!result) throw new ApiException(ErrorCodeEnum.ExpiredDataException);

                    recordEntity.setPayStatus(PaymentStatusEnum.PayFailed);
                    recordEntity.setUpdateBy(rechargeEntity.getCreateBy());
                    recordEntity.setUpdateDate(new Timestamp(System.currentTimeMillis()));
                    Integer acrow = paymentRecordMapper.updateById(recordEntity);
                    if(acrow==null || acrow.intValue()<1) throw new ApiException(ErrorCodeEnum.ExpiredDataException);

                    for (PaymentEntity payment:tempPayment) {
                        if(payment.getPaymentStatus().getCode()!=PaymentStatusEnum.Paying.getCode()) continue;

                        payment.setPaymentStatus(PaymentStatusEnum.PayFailed);
                        payment.setUpdateBy(rechargeEntity.getCreateBy());
                        payment.setUpdateDate(new Timestamp(System.currentTimeMillis()));
                        acrow = paymentMapper.updateById(payment);
                        if(acrow==null || acrow.intValue()<1) throw new ApiException(ErrorCodeEnum.ExpiredDataException);
                    }
                }
            }else {
                RECHARGE_LOGGER.error(String.format("【%s】支付通知接收失败，原因：%s，参数：%s",ordernumber,"redis锁获取失败",params.toJSONString()));
            }
        }catch (ApiException e) {
            //e.printStackTrace();
            RECHARGE_LOGGER.error(String.format("【%s】支付通知接收失败，原因：%s，参数：%s",ordernumber,e.getMessage(),params.toJSONString()),e);
            throw e;
        }catch (Exception e){
            //e.printStackTrace();
            RECHARGE_LOGGER.error(String.format("【%s】支付通知接收失败，原因：%s，参数：%s",ordernumber,e.getMessage(),params.toJSONString()),e);
            throw new ApiException(ErrorCodeEnum.SystemError);
        }
        finally {
            //为了让分布式锁的算法更稳键些，持有锁的客户端在解锁之前应该再检查一次自己的锁是否已经超时，再去做DEL操作，因为可能客户端因为某个耗时的操作而挂起，
            //操作完的时候锁因为超时已经被别人获得，这时就不必解锁了。 ————这里没有做
            lock.unlock();
        }

        RECHARGE_LOGGER.info(String.format("【%s】支付通知接收成功，充值%s，参数：%s",ordernumber,orderstatus.equals("1")?"成功":"失败",params.toJSONString()));

        try {
            RedisHelper.delKey(ConstantInterface.KEY_RECHARGE_NOTIFY + ordernumber);
        }catch (Exception e){
            //TODO 充值成功 redis移除失败不处理
        }
        return "ok";
    }


    /**
     *  后台充值通用接口
     */
    public void saveMoneyForUser(long userId,double addAmount,String remarks,String systemUserId) {
        RechargeEntity entity = new RechargeEntity();
        entity.setUserId(userId);
        entity.setSummery(remarks);
        entity.setRechargeAmount(addAmount);
        entity.setCreateBy(1L);
        entity.setCreateDate(new Timestamp(System.currentTimeMillis()));
        entity.setUpdateBy(1L);
        entity.setUpdateDate(new Timestamp(System.currentTimeMillis()));
        entity.setIsDelete(0);
        entity.setRechargeCode(CodeFactory.generateRechargeCode());
        //后台充值 直接成功状态
        entity.setRechargeStatus(RechargeStatusEnum.RechargeSuccess);

        rechargeService.insert(entity);

        insertBalance(  userId,  addAmount,  entity.getRechargeStatus(),  entity.getRechargeCode(), TradeTypeEnum.SystemRecharge,  entity.getRechargeId(),  remarks,systemUserId,true);

        RECHARGE_LOGGER.info(String.format("后台代充值，用户【%s】成功充值【%s】元",userId,entity.getRechargeAmount()));
    }

    /**
     * 充值通用接口
     * @param userId
     * @param addAmount
     * @param recharge_status
     * @param recharge_code
     * @param tradeType
     * @param rechargeId
     * @param remarks
     * @param systemUserId 系统充值的操作员ID
     * @param messageFlag  是否新增记录
     */
    public void insertBalance(long userId,double addAmount,
                              RechargeStatusEnum recharge_status,String recharge_code,TradeTypeEnum tradeType,
                              long rechargeId,String remarks,String systemUserId,boolean messageFlag){
        UserAccountEntity account;
        Map<String,Object> whereMap = new HashMap<>();
        whereMap.put("user_id",userId);
        List<UserAccountEntity> tempAccount = accountMapper.selectByMap(whereMap);
        if(tempAccount.size()==0){
            account = new UserAccountEntity();
            account.setUserId(userId);
            account.setActype(1);
            account.setCurrency(CurrencyEnum.CNY);
            if(recharge_status == RechargeStatusEnum.RechargeSuccess) {
                account.setBalance(addAmount);
                account.setTotalRecharge(addAmount);
            }else {
                account.setBalance(0D);
                account.setTotalRecharge(0D);
            }
            account.setTotalExpend(0D);
            account.setTotalIncome(0D);
            account.setTotalLottery(0D);
            account.setCreateBy(userId);
            account.setCreateDate(new Timestamp(System.currentTimeMillis()));
            account.setUpdateBy(userId);
            account.setUpdateDate(new Timestamp(System.currentTimeMillis()));
            account.setIsDelete(0);
            accountMapper.insert(account);
        }else{
            account = tempAccount.get(0);
            if(recharge_status == RechargeStatusEnum.RechargeSuccess) {
                account.setBalance(account.getBalance() + addAmount);
                account.setTotalRecharge(account.getTotalRecharge() + addAmount);
            }
            account.setUpdateBy(userId);
            account.setUpdateDate(new Timestamp(System.currentTimeMillis()));
            account.setIsDelete(0);
            Integer acrow = accountMapper.updateById(account);
                if(acrow.intValue()< 1) throw new ApiException(ErrorCodeEnum.ExpiredDataException);
        }

        whereMap = new HashMap<>();
        whereMap.put("user_id",userId);
        whereMap.put("trade_no",recharge_code);
        List<UserAccountDetailEntity> tempDetail = accountDetailMapper.selectByMap(whereMap);
        String orderid=systemConfig.getGAME_AGENT()+ DateUtil.getDayshms();
        long tradeId=0L;
        String tradeNo="";
        if(tempDetail.size()==0) {
            UserAccountDetailEntity adEntity = new UserAccountDetailEntity();
            adEntity.setAccountId(account.getAccountId());
            adEntity.setAmount(addAmount);
            adEntity.setNewBalance(account.getBalance());
            adEntity.setTradeKindEnum(TradeKindEnum.Income);
            adEntity.setTradeTypeEnum(tradeType);
            adEntity.setTradeNo(recharge_code);
            adEntity.setOrderId(orderid);
            adEntity.setTradeStatusEnum(recharge_status == RechargeStatusEnum.Paying ? TradeStatusEnum.Paying : TradeStatusEnum.Complete);
            adEntity.setUserId(userId);
            adEntity.setCreateBy(userId);
            adEntity.setCreateDate(new Timestamp(System.currentTimeMillis()));
            adEntity.setUpdateBy(userId);
            adEntity.setUpdateDate(new Timestamp(System.currentTimeMillis()));
            adEntity.setRemarks(remarks);
            adEntity.setIsDelete(0);
            accountDetailMapper.insert(adEntity);
            tradeId=adEntity.getTradeId();
            tradeNo=adEntity.getTradeNo();
        }else {
            UserAccountDetailEntity adEntity = tempDetail.get(0);
            adEntity.setNewBalance(account.getBalance());
            if(adEntity.getTradeStatusEnum()==TradeStatusEnum.Complete){
                //不能重复支付
                throw new ApiException(ErrorCodeEnum.RepetitivePaymentException);
            }
            adEntity.setTradeStatusEnum(TradeStatusEnum.Complete);
            adEntity.setUpdateDate(new Timestamp(System.currentTimeMillis()));
            adEntity.setUpdateBy(userId);
            adEntity.setOrderId(orderid);
            accountDetailMapper.updateById(adEntity);
            tradeId=adEntity.getTradeId();
            tradeNo=adEntity.getTradeNo();
        }

        /**
         * 充值成功后需要更新开元
         */
        UserEntity userEntity=userMapper.selectById(userId);
        if(recharge_status.getCode() == RechargeStatusEnum.RechargeSuccess.getCode()) {
            /**
             *  更新开元余额
             */
            try {
                GameRsp<Object> gameRsp= gameConnector.upScore(userEntity.getKyAccount(),String.valueOf(addAmount),orderid);
                GAMES.info("【"+userEntity.getKyAccount()+"】充值信息【"+recharge_code+"】更新余额："+gameRsp.toString());
                DBack dBack= JSON.parseObject(JSONObject.toJSONString(gameRsp.getD()), DBack.class);
                if( dBack.getCode() != 0) {
                     throw new ApiException(ErrorCodeEnum.IapRechargeError);
                }
            } catch (Exception e) {
                RECHARGE_LOGGER.error(String.format("【%s】充值失败，原因：开元转账申请失败",recharge_code),e);
                throw new ApiException(ErrorCodeEnum.IapRechargeError);
            }

        }


//是否可以新增信息
        if(messageFlag){
            //发送短信到管理
            boolean flag=true;
            String beUserName="";
            String content=userEntity.getNickName() == null?userEntity.getPhone():userEntity.getNickName() +" 发起了一笔充值，金额："+addAmount+"，订单编号："+tradeNo +"。";
            long roleId=RoleTypeEnum.admin.getCode();
            long createBy=userEntity.getUserId();
            int type=QueueMessageTypeEnum.UserRechargeMax.getCode();
            if(!systemUserId.equals("")){
                UserEntity be_userEntity=userMapper.selectById( Long.parseLong(systemUserId) );
                if(be_userEntity != null){
                    beUserName=be_userEntity.getNickName();
                }
                type=QueueMessageTypeEnum.SystemRechargeMax.getCode();
//                roleId=be_userEntity.getRoleId();
                content="客服"+be_userEntity.getNickName()+"在后台给玩家[ "+userEntity.getNickName() == null?userEntity.getPhone():userEntity.getNickName()+" ]充值了"+addAmount+"元，订单编号："+tradeNo +"。";
                createBy=be_userEntity.getUserId();
            }else{
                if(systemConfig.getRECHARGE_MONEY_MAX() < addAmount ) {
                    flag=false;
                }
            }
            if(flag && messageFlag){
                UserEntity admin_userEntity=userMapper.selectById( SystemIdEnum.admin.getCode());
                if(admin_userEntity != null){
                    try{
                        //新增充值记录
                        MessageEntity messageEntity=new MessageEntity();
                        messageEntity.setIcon("fa fa-users text-aqua");
                        messageEntity.setMessageType(TradeTypeEnum.Recharge);
                        messageEntity.setTradeId(tradeId);
                        messageEntity.setCreateBy(createBy);
                        messageEntity.setCreateDate(new Timestamp(System.currentTimeMillis()));
                        messageEntity.setUpdateDate(new Timestamp(System.currentTimeMillis()));
                        messageEntity.setIsDelete(0);
                        messageService.insert(messageEntity);
                        ///新增充值记录
                        MessageContentEntity messageContentEntity=new MessageContentEntity();
                        messageContentEntity.setStatus(0);
                        messageContentEntity.setTradeId(tradeId);
                        messageContentEntity.setUserId(admin_userEntity.getUserId());
                        messageContentEntity.setRoleId(admin_userEntity.getRoleId());
                        messageContentEntity.setCreateBy(createBy);
                        messageContentEntity.setCreateDate(new Timestamp(System.currentTimeMillis()));
                        messageContentEntity.setUpdateDate(new Timestamp(System.currentTimeMillis()));
                        messageContentEntity.setIsDelete(0);
                        messageContentEntity.setContent(content);
                        messageContentService.insert(messageContentEntity);
                        if(admin_userEntity.getPhone() != null){
                            JSONObject json = new JSONObject();
                            json.put("type", type);
                            json.put("phone",admin_userEntity.getPhone());
                            json.put("userName",userEntity.getNickName() == null?userEntity.getPhone():userEntity.getNickName());
                            json.put("amount",addAmount);
                            json.put("tradeNo",tradeNo);
                            json.put("beUserName",beUserName);
                            //加入消息队列，等待业务逻辑处理
                            String messagekey=DateUtil.getDayshms();
                            json.put("messagekey",messagekey);
                            producerService.sendMessagePhone(messagekey,this.payDestination,json.toJSONString());
                        }
                    }catch (Exception e){
                        e.printStackTrace();
                    }

                }
            }

        }







    }

    /**
     * 查询充值状态
     * @param user
     * @param rechargeCode
     * @return
     * @throws ApiException
     */
    public UserAccountDetailEntity queryRechargeStatus(UserEntity user,String rechargeCode) throws ApiException{
        Map<String,Object> whereMap = new HashMap<>();
        whereMap.put("user_id",user.getUserId());
        whereMap.put("trade_no",rechargeCode);
        List<UserAccountDetailEntity> temp = accountDetailMapper.selectByMap(whereMap);
        if(temp.size()==0) throw new ApiException(ErrorCodeEnum.RechargeOrderNotFoundException);
        return temp.get(0);
    }

    /**
     * 购买金币IAP支付
     * @param user 用户
     * @param iapProduct 商品ID
     * @param iapReceipt 支付凭证
     * @return
     * @throws ApiException
     */
    public RechargeEntity rechargeByIap(UserEntity user,String iapProduct,String iapReceipt) throws ApiException{
        RechargeEntity entity;
        try {

            //充值活动商品
            Map<String,Object> map = new HashMap<>();
            map.put("item_code",iapProduct);
            ItemEntity item = itemMapper.selectByMap(map).get(0);
            if (item == null) throw new ApiException(ErrorCodeEnum.ItemNotFoundException);

            //保存充值记录
            entity = new RechargeEntity();
            entity.setUserId(user.getUserId());
            entity.setRechargeCode(CodeFactory.generateRechargeCode());
            entity.setRechargeAmount(item.getPrice());
            entity.setRechargeStatus(RechargeStatusEnum.RechargeSuccess);
            entity.setCreateBy(user.getUserId());
            entity.setCreateDate(new Timestamp(System.currentTimeMillis()));
            entity.setUpdateBy(user.getUserId());
            entity.setUpdateDate(new Timestamp(System.currentTimeMillis()));
            entity.setIsDelete(0);
            rechargeService.insert(entity);

            //保存支付记录
            PaymentRecordEntity record = new PaymentRecordEntity();
            record.setUserId(user.getUserId());
            record.setOrderode(entity.getRechargeCode());
            record.setPayAmount(item.getPrice());
            record.setPaymentTarget(PaymentTargetEnum.RechargePay);
            record.setPayStatus(PaymentStatusEnum.PaySuccessed);
            record.setCreateBy(user.getUserId());
            record.setCreateBy(user.getUserId());
            record.setCreateDate(new Timestamp(System.currentTimeMillis()));
            record.setUpdateBy(user.getUserId());
            record.setUpdateDate(new Timestamp(System.currentTimeMillis()));
            record.setIsDelete(0);
            paymentRecordMapper.insert(record);

            //支付明细
            PaymentEntity detail = new PaymentEntity();
            detail.setPayId(record.getRecordId());
            detail.setPaymentMode(PaymentModeEnum.IAP);
            detail.setAmountPaid(item.getPrice());
            detail.setPaymentStatus(PaymentStatusEnum.PaySuccessed);
            detail.setCreateBy(user.getUserId());
            detail.setCreateBy(user.getUserId());
            detail.setCreateDate(new Timestamp(System.currentTimeMillis()));
            detail.setUpdateBy(user.getUserId());
            detail.setUpdateDate(new Timestamp(System.currentTimeMillis()));
            detail.setIsDelete(0);
            paymentMapper.insert(detail);

            //支付后前端获取不到新宝的同步通知，不知道支付状态，因此充值申请的时候先生成支付中的交易记录，等充值成功后再更新交易状态为已完成
            this.insertBalance(user.getUserId(),item.getPrice(),RechargeStatusEnum.RechargeSuccess,entity.getRechargeCode(),TradeTypeEnum.Recharge,entity.getRechargeId(),"玩家充值","",false);

        }catch (ApiException e){
            e.printStackTrace();
            throw e;
        }catch (Exception e){
            e.printStackTrace();
            throw new ApiException(ErrorCodeEnum.IapRechargeError);
        }
        RECHARGE_LOGGER.info(String.format("苹果支付，用户【%s】成功充值【%s】元，充值单号：【%s】",user.getUserId(),entity.getRechargeAmount(),entity.getRechargeCode()));
        return entity;
    }

    /**
     * IAP支付凭证是否已验证过
     * @param receipt IAP支付凭证
     * @return
     * @throws ApiException
     */
    public boolean receiptExist(String receipt) throws ApiException{
        Map<String, Object> map = new HashMap<>();
        map.put("iap_receipt", receipt);
        List<RechargeEntity> list = rechargeService.selectByMap(map);

        return list !=null && list.size() >0;
    }

}
