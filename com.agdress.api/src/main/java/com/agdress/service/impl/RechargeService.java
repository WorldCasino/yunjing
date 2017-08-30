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
//        entity.setItemId(item.getItemId());
        entity.setRechargeAmount(payAmount);
        entity.setRechargeStatus(RechargeStatusEnum.Paying);
//        entity.setSummery(item.getItemName());
        entity.setCreateBy(user.getUserId());
        entity.setCreateDate(new Timestamp(System.currentTimeMillis()));
        entity.setUpdateBy(user.getUserId());
        entity.setUpdateDate(new Timestamp(System.currentTimeMillis()));
        entity.setIsDelete(0);
        super.insert(entity);

        //保存支付记录
        PaymentRecordEntity record = new PaymentRecordEntity();
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
        //if(card != null) detail.setCardId(card.getCardId());
        detail.setAmountPaid(payAmount);
        detail.setPaymentStatus(PaymentStatusEnum.Paying);
        detail.setCreateBy(user.getUserId());
        detail.setCreateBy(user.getUserId());
        detail.setCreateDate(new Timestamp(System.currentTimeMillis()));
        detail.setUpdateBy(user.getUserId());
        detail.setUpdateDate(new Timestamp(System.currentTimeMillis()));
        detail.setIsDelete(0);
        paymentMapper.insert(detail);

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
        if(StringUtils.isEmpty(code)) throw new ApiException(ErrorCodeEnum.ArgumentError);
        String orderCode = params.getString("order_no");
        if(StringUtils.isEmpty(orderCode)) throw new ApiException(ErrorCodeEnum.ArgumentError);
        String tradeCode = params.getString("trade_no");
        if(StringUtils.isEmpty(tradeCode)) throw new ApiException(ErrorCodeEnum.ArgumentError);

        Map<String,Object> whereMap = new HashMap<>();
        whereMap.put("recharge_code",orderCode);
        List<RechargeEntity> list = super.selectByMap(whereMap);
        if(list.size()==0){
            throw new ApiException(ErrorCodeEnum.ArgumentError.getCode(),String.format("订单%s不存在！",orderCode));
        }
        RechargeEntity rechargeEntity = list.get(0);
        if(rechargeEntity.getRechargeStatus().getCode() != RechargeStatusEnum.Paying.getCode()){
            throw new ApiException(ErrorCodeEnum.ArgumentError.getCode(),String.format("订单%s已通知，不能重复通知！",orderCode));
        }
        whereMap = new HashMap<>();
        whereMap.put("order_code",orderCode);
        List<PaymentRecordEntity> tempRecord = paymentRecordMapper.selectByMap(whereMap);
        if(tempRecord.size()==0 ){
            throw new ApiException(ErrorCodeEnum.ArgumentError.getCode(),String.format("订单%s不存在！",orderCode));
        }
        PaymentRecordEntity recordEntity = tempRecord.get(0);
        if(recordEntity.getPayStatus().getCode()!=PaymentStatusEnum.Paying.getCode()){
            throw new ApiException(ErrorCodeEnum.ArgumentError.getCode(),String.format("订单%s已通知，不能重复通知！",orderCode));
        }


        whereMap = new HashMap<>();
        whereMap.put("pay_id",recordEntity.getRecordId());
        List<PaymentEntity> tempPayment = paymentMapper.selectByMap(whereMap);
        if(tempPayment.size()==0 ){
            throw new ApiException(ErrorCodeEnum.ArgumentError.getCode(),String.format("订单%s不存在！",orderCode));
        }

        if(code.equals("00")){
            //交易成功
            rechargeEntity.setRechargeStatus(RechargeStatusEnum.RechargeSuccess);
            boolean result = super.updateById(rechargeEntity);
            if(!result) throw new ApiException(ErrorCodeEnum.ExpiredDataException);
            for (PaymentEntity payment:tempPayment) {
                if(payment.getPaymentStatus().getCode()!=PaymentStatusEnum.Paying.getCode()) continue;

                payment.setPaymentStatus(PaymentStatusEnum.PaySuccessed);
                payment.setPaymentCode(tradeCode);
                Integer rows = paymentMapper.updateById(payment);
                if(rows.intValue()<1) throw new ApiException(ErrorCodeEnum.ExpiredDataException);
            }

            UserAccountEntity account;
            whereMap = new HashMap<>();
            whereMap.put("user_id",recordEntity.getUserId());
            whereMap.put("actype",1);
            List<UserAccountEntity> tempAccount = accountMapper.selectByMap(whereMap);
            if(tempAccount.size()==0){
                account = new UserAccountEntity();
                account.setActype(1);
                account.setBalance(rechargeEntity.getRechargeAmount());
                account.setCurrency(CurrencyEnum.CNY);
                account.setTotalExpend(0);
                account.setTotalIncome(0);
                account.setTotalLottery(0);
                account.setCreateBy(rechargeEntity.getUserId());
                account.setCreateDate(new Timestamp(System.currentTimeMillis()));
                account.setUpdateBy(rechargeEntity.getUserId());
                account.setUpdateDate(new Timestamp(System.currentTimeMillis()));
                account.setIsDelete(0);
                accountMapper.insert(account);
            }else{
                account = tempAccount.get(0);
                account.setBalance(account.getBalance() + rechargeEntity.getRechargeAmount());
                account.setTotalRecharge(account.getTotalRecharge() + rechargeEntity.getRechargeAmount());
                account.setUpdateBy(rechargeEntity.getUserId());
                account.setUpdateDate(new Timestamp(System.currentTimeMillis()));
                account.setIsDelete(0);
                Integer acrow = accountMapper.updateById(account);
                if(acrow.intValue()< 1) throw new ApiException(ErrorCodeEnum.ExpiredDataException);
            }

            UserAccountDetailEntity adEntity = new UserAccountDetailEntity();
            adEntity.setAccountId(account.getAccountId());
            adEntity.setAmount(rechargeEntity.getRechargeAmount());
            adEntity.setNewBalance(account.getBalance());
            adEntity.setTradeId(rechargeEntity.getRechargeId());
            adEntity.setTradeKind(TradeKindEnum.Income);
            adEntity.setTradeType(TradeTypeEnum.Recharge);
            adEntity.setTradeNo(rechargeEntity.getRechargeCode());
            adEntity.setTradeStatus(TradeStatusEnum.Complete);
            adEntity.setUserId(rechargeEntity.getUserId());
            adEntity.setCreateBy(rechargeEntity.getUserId());
            adEntity.setCreateDate(new Timestamp(System.currentTimeMillis()));
            adEntity.setUpdateBy(rechargeEntity.getUserId());
            adEntity.setUpdateDate(new Timestamp(System.currentTimeMillis()));
            adEntity.setIsDelete(0);
            accountDetailMapper.insert(adEntity);

            try {
                UserEntity userEntity = userMapper.selectById(rechargeEntity.getUserId());
                AgentEntity agentEntity = agentMapper.selectById(userEntity.getAgentId());
                GameRsp<Float> bgBalance = gameConnector.openBalanceTransfer(agentEntity.getBgPwd(),
                        userEntity.getBgLoginId(),
                        String.valueOf(rechargeEntity.getRechargeAmount()),
                        rechargeEntity.getRechargeId(), "1");

                System.out.println("BG账户余额：" + bgBalance.getResult());
            }catch (IOException e){
                e.printStackTrace();
                //TODO 处理失败的机制
            }
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
}
