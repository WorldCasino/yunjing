package com.agdress.service.impl;

import com.agdress.bgapi.GameRsp;
import com.agdress.bgapi.IGameConnector;
import com.agdress.commons.Exception.ApiException;
import com.agdress.commons.secret.Authorization;
import com.agdress.commons.utils.*;
import com.agdress.entity.*;
import com.agdress.entity.vo.UserResultVo;
import com.agdress.enums.*;
import com.agdress.mapper.*;
import com.agdress.payapi.IPaymentConnector;
import com.agdress.payapi.PaymentReq;
import com.agdress.payapi.PaymentRsp;
import com.agdress.service.IRechargeService;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.*;

/**
 * Created by Administrator on 2017/8/22.
 */

@Service
@Transactional
public class RechargeService extends ServiceImpl<RechargeMapper,RechargeEntity> implements IRechargeService{
    @Autowired
    private SystemConfig systemConfig;
    @Autowired
    private IGameConnector gameConnector;
    @Autowired
    private ItemMapper itemMapper;
    @Autowired
    private PaymentRecordMapper paymentRecordMapper;
    @Autowired
    private PaymentMapper paymentMapper;
    @Autowired
    private CardMapper cardMapper;
    @Autowired
    private BankMapper bankMapper;
    @Autowired
    private UserAccountDetailMapper accountDetailMapper;
    @Autowired
    private UserAccountMapper accountMapper;
    @Autowired
    private UserMapper userMapper;
    @Autowired
    private AgentMapper agentMapper;


    /**
     * 请求支付
     * @param params 支付参数
     * @return
     * @throws ApiException
     */
    public PaymentReq requestPay(UserEntity user, JSONObject params) throws ApiException{
        //支付金额
        Double payAmount = params.getDouble("pay_amount");

        //前端有手动输入充值金额的需求，那就不能从后台设定了~ 坑爹
        if(params.containsKey("item_id")) {
            ItemEntity item = itemMapper.selectById(params.getLong("item_id"));
            if (item == null) throw new ApiException(ErrorCodeEnum.ArgumentError);
            if (payAmount.doubleValue() != item.getPrice())
                throw new ApiException(ErrorCodeEnum.PaymentAmountErrorException);
        }
        //支付类型
        PaymentModeEnum paymentMode;
        if(params.get("payment_mode")==null || params.get("payment_mode").equals("")) throw new ApiException(ErrorCodeEnum.ArgumentError.getCode(),"参数payment_mode不能为空！");
        else paymentMode = CodeEnumUtil.codeOf(PaymentModeEnum.class,params.getIntValue("payment_mode"));
        String bankCode = params.getString("bank_code");
        if(StringUtils.isEmpty(bankCode) && paymentMode.getCode() == PaymentModeEnum.OnlinePay.getCode()){
            throw new ApiException(ErrorCodeEnum.ArgumentError);
        }

        //保存充值记录
        RechargeEntity entity = new RechargeEntity();
        entity.setUserId(user.getUserId());
        entity.setRechargeCode(CodeFactory.generateRechargeCode());
        entity.setRechargeAmount(payAmount);
        entity.setRechargeStatus(RechargeStatusEnum.Paying);
        entity.setCreateBy(user.getUserId());
        entity.setCreateDate(new Timestamp(System.currentTimeMillis()));
        entity.setUpdateBy(user.getUserId());
        entity.setUpdateDate(new Timestamp(System.currentTimeMillis()));
        entity.setIsDelete(0);
        super.insert(entity);

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
        this.insertBalance(user.getUserId(),payAmount,RechargeStatusEnum.Paying,entity.getRechargeCode(),TradeTypeEnum.Recharge,entity.getRechargeId(),"玩家充值");

        //新宝请求参数
        PaymentReq req = JSONObject.toJavaObject(params,PaymentReq.class);
        req.setVersion(systemConfig.getPAYMENT_API_VERSION());
        req.setPayType(paymentMode.getXinBaoCode());
        req.setPartnerId(systemConfig.getPAYMENT_PARTNER_ID());
        req.setOrderNo(record.getOrderode());
        req.setAmount(String.valueOf(payAmount));
        req.setSummary(entity.getSummery());
        req.setNotifyUrl(systemConfig.getPAYMENT_NOTIFY_URL());
        req.setReturnUrl(systemConfig.getPAYMENT_RETURN_URL());
        req.setBankCode(bankCode);
        req.setAttach(String.valueOf(record.getRecordId()));
        if(paymentMode.getCode() == PaymentModeEnum.OnlinePay.getCode()) {
            req.setBankCode(bankCode);
        }

        JSONObject json = (JSONObject) JSON.toJSON(req);
        Map<String, String> map = (Map) json;
        //这里将map.entrySet()转换成list
        List<Map.Entry<String, String>> list = new ArrayList<Map.Entry<String, String>>(map.entrySet());
        //然后通过比较器来实现排序
        //升序排序
        Collections.sort(list, Comparator.comparing(Map.Entry::getKey));
        String str = "";
        for (Map.Entry<String, String> pair : list) {
            if(StringUtils.isEmpty(pair.getValue())) continue;

            str += pair.getKey() + "=" + pair.getValue() + "&";
            params.put(pair.getKey(), pair.getValue());
        }
        str += systemConfig.getPAYMENT_SECRET_KEY();
        String sign = MD5Util.getMD5Str(str).toLowerCase();
        req.setSign(sign);
        return req;
    }

    /**
     * 支付回调
     * @param params 回调参数
     * @return
     * @throws ApiException
     */
    public String notifyProccess(JSONObject params) throws ApiException{
        String code = params.getString("code");
        if(StringUtils.isEmpty(code)){
            //throw new ApiException(ErrorCodeEnum.ArgumentError);
            return "ArgumentError";
        }
        String orderCode = params.getString("order_no");
        if(StringUtils.isEmpty(orderCode)) {
            //throw new ApiException(ErrorCodeEnum.ArgumentError);
            return "ArgumentError";
        }
        String tradeCode = params.getString("trade_no");
        if(StringUtils.isEmpty(tradeCode)) {
            //throw new ApiException(ErrorCodeEnum.ArgumentError);
            return "ArgumentError";
        }

        Map<String,Object> whereMap = new HashMap<>();
        whereMap.put("recharge_code",orderCode);
        List<RechargeEntity> list = super.selectByMap(whereMap);
        if(list.size()==0){
//            throw new ApiException(ErrorCodeEnum.ArgumentError.getCode(),String.format("订单%s不存在！",orderCode));
            return "ArgumentError";
        }
        RechargeEntity rechargeEntity = list.get(0);
        if(rechargeEntity.getRechargeStatus().getCode() != RechargeStatusEnum.Paying.getCode()){
//            throw new ApiException(ErrorCodeEnum.ArgumentError.getCode(),String.format("订单%s已通知，不能重复通知！",orderCode));
            return "ok";
        }
        whereMap = new HashMap<>();
        whereMap.put("order_code",orderCode);
        List<PaymentRecordEntity> tempRecord = paymentRecordMapper.selectByMap(whereMap);
        if(tempRecord.size()==0 ){
            //throw new ApiException(ErrorCodeEnum.ArgumentError.getCode(),String.format("订单%s不存在！",orderCode));
            return "ArgumentError";
        }
        PaymentRecordEntity recordEntity = tempRecord.get(0);
        if(recordEntity.getPayStatus().getCode()!=PaymentStatusEnum.Paying.getCode()){
//            throw new ApiException(ErrorCodeEnum.ArgumentError.getCode(),String.format("订单%s已通知，不能重复通知！",orderCode));
            return "ok";
        }

        whereMap = new HashMap<>();
        whereMap.put("pay_id",recordEntity.getRecordId());
        List<PaymentEntity> tempPayment = paymentMapper.selectByMap(whereMap);
        if(tempPayment.size()==0 ){
//            throw new ApiException(ErrorCodeEnum.ArgumentError.getCode(),String.format("订单%s不存在！",orderCode));
            return "ArgumentError";
        }

        if(code.equals("00")){
            //交易成功
            rechargeEntity.setRechargeStatus(RechargeStatusEnum.RechargeSuccess);
            rechargeEntity.setSummery(params.toJSONString());
            boolean result = super.updateById(rechargeEntity);
            if(!result) throw new ApiException(ErrorCodeEnum.ExpiredDataException);
            for (PaymentEntity payment:tempPayment) {
                if(payment.getPaymentStatus().getCode()!=PaymentStatusEnum.Paying.getCode()) continue;

                payment.setPaymentStatus(PaymentStatusEnum.PaySuccessed);
                payment.setPaymentCode(tradeCode);
                Integer rows = paymentMapper.updateById(payment);
                if(rows.intValue()<1) throw new ApiException(ErrorCodeEnum.ExpiredDataException);
            }

            //开始充值
            insertBalance(rechargeEntity.getUserId(),rechargeEntity.getRechargeAmount(),rechargeEntity.getRechargeStatus(),rechargeEntity.getRechargeCode(),TradeTypeEnum.Recharge,rechargeEntity.getRechargeId(),"玩家充值");

        }else{
            //交易失败
            rechargeEntity.setRechargeStatus(RechargeStatusEnum.RechargeFailed);
            rechargeEntity.setUpdateDate(new Timestamp(System.currentTimeMillis()));
            boolean result = super.updateById(rechargeEntity);
            if(!result) throw new ApiException(ErrorCodeEnum.ExpiredDataException);

            recordEntity.setPayStatus(PaymentStatusEnum.PayFailed);
            recordEntity.setUpdateDate(new Timestamp(System.currentTimeMillis()));
            Integer acrow = paymentRecordMapper.updateById(recordEntity);
            if(acrow==null || acrow.intValue()<1) throw new ApiException(ErrorCodeEnum.ExpiredDataException);

            for (PaymentEntity payment:tempPayment) {
                if(payment.getPaymentStatus().getCode()!=PaymentStatusEnum.Paying.getCode()) continue;

                payment.setPaymentStatus(PaymentStatusEnum.PayFailed);
                acrow = paymentMapper.updateById(payment);
                if(acrow==null || acrow.intValue()<1) throw new ApiException(ErrorCodeEnum.ExpiredDataException);
            }
        }

        return "ok";
    }

    //充值通用接口
    @Override
    public void saveMoneyForUser(long userId,double addAmount,RechargeStatusEnum recharge_status,String recharge_code,long recharge_id,String remarks) {
        insertBalance(  userId,  addAmount,  recharge_status,  recharge_code, TradeTypeEnum.SystemRecharge,  recharge_id,  remarks);
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
     */
    public void insertBalance(long userId,double addAmount,RechargeStatusEnum recharge_status,String recharge_code,TradeTypeEnum tradeType,long rechargeId,String remarks){
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
                account.setBalance(0);
                account.setTotalRecharge(0);
            }
            account.setTotalExpend(0);
            account.setTotalIncome(0);
            account.setTotalLottery(0);
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
        if(tempDetail.size()==0) {
            UserAccountDetailEntity adEntity = new UserAccountDetailEntity();
            adEntity.setAccountId(account.getAccountId());
            adEntity.setAmount(addAmount);
            adEntity.setNewBalance(account.getBalance());
            adEntity.setTradeKind(TradeKindEnum.Income);
            adEntity.setTradeType(tradeType);
            adEntity.setTradeNo(recharge_code);
            adEntity.setTradeStatus(recharge_status == RechargeStatusEnum.Paying ? TradeStatusEnum.Paying : TradeStatusEnum.Complete);
            adEntity.setUserId(userId);
            adEntity.setCreateBy(userId);
            adEntity.setCreateDate(new Timestamp(System.currentTimeMillis()));
            adEntity.setUpdateBy(userId);
            adEntity.setUpdateDate(new Timestamp(System.currentTimeMillis()));
            adEntity.setRemarks(remarks);
            adEntity.setIsDelete(0);
            accountDetailMapper.insert(adEntity);
        }else {
            UserAccountDetailEntity adEntity = tempDetail.get(0);
            adEntity.setNewBalance(account.getBalance());
            if(adEntity.getTradeStatus()==TradeStatusEnum.Complete){
                //不能重复支付
                throw new ApiException(ErrorCodeEnum.RepetitivePaymentException);
            }
            adEntity.setTradeStatus(TradeStatusEnum.Complete);
            adEntity.setUpdateDate(new Timestamp(System.currentTimeMillis()));
            adEntity.setUpdateBy(userId);
            accountDetailMapper.updateById(adEntity);
        }

        //充值成功后需要更新BG
        if(recharge_status.getCode() == RechargeStatusEnum.RechargeSuccess.getCode()) {
            try {
                UserEntity userEntity = userMapper.selectById(userId);
                AgentEntity agentEntity = agentMapper.selectById(userEntity.getAgentId());
                GameRsp<Float> bgBalance = gameConnector.openBalanceTransfer(agentEntity.getBgPwd(),
                        userEntity.getBgLoginId(),
                        String.valueOf(addAmount),
                        rechargeId, "1");

                System.out.println("BG账户余额：" + bgBalance.getResult());
            } catch (IOException e) {
                throw new ApiException(ErrorCodeEnum.BgBalanceTransferException);
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
            super.insert(entity);

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
            this.insertBalance(user.getUserId(),item.getPrice(),RechargeStatusEnum.RechargeSuccess,entity.getRechargeCode(),TradeTypeEnum.Recharge,entity.getRechargeId(),"玩家充值");
        }catch (ApiException e){
            e.printStackTrace();
            throw e;
        }catch (Exception e){
            e.printStackTrace();
            throw new ApiException(ErrorCodeEnum.IapRechargeError);
        }
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
        List<RechargeEntity> list = super.selectByMap(map);

        return list !=null && list.size() >0;
    }
}
