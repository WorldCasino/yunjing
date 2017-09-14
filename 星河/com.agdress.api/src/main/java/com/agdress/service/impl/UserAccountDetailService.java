package com.agdress.service.impl;

import com.agdress.bgapi.GameRsp;
import com.agdress.bgapi.IGameConnector;
import com.agdress.commons.Exception.ApiException;
import com.agdress.commons.utils.*;
import com.agdress.entity.*;
import com.agdress.enums.*;
import com.agdress.mapper.*;
import com.agdress.message.SmsAdapter;
import com.agdress.service.IAuditTemplateStepService;
import com.agdress.service.IUserAccountDetailService;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/8/17.
 *
 */

@Service
@Transactional
public class UserAccountDetailService extends ServiceImpl<UserAccountDetailMapper,UserAccountDetailEntity> implements IUserAccountDetailService{
    @Autowired
    private SmsAdapter smsAdapter;
    @Autowired
    private IGameConnector gameConnector;
    @Autowired
    private AgentMapper agentMapper;
    @Autowired
    private CardMapper cardMapper;
    @Autowired
    private UserAccountMapper accountMapper;
    @Autowired
    private UserAccountDetailMapper accountDetailMapper;
    @Autowired
    private IAuditTemplateStepService auditTemplateStepService;

    /**
     * 查询交易记录
     * @param user 用户
     * @param tradeKind 交易区分
     * @return
     * @throws ApiException
     */
    public List<UserAccountDetailEntity> getTradeList(UserEntity user,TradeKindEnum tradeKind) throws ApiException{
        EntityWrapper ew = new EntityWrapper();
        //ew.setEntity(new ActivityEntity());
        ew.where("is_delete = {0}",0)
                .andNew("user_id = {0}",user.getUserId());
        if(tradeKind.getCode() != TradeKindEnum.ALL.getCode()){
            ew.andNew("trade_kind = {0}",tradeKind.getCode());
        }

        List<UserAccountDetailEntity> list = super.selectList(ew);
        return list;
    }

    /**
     * 提现申请
     * @param user 用户
     * @param amount 金额
     * @param cardId 卡片ID
     * @param captcha 验证码
     * @return
     * @throws ApiException
     */
    public boolean applyWithdraw(UserEntity user,double amount,long cardId ,String captcha) throws ApiException{
        double bgBalance = 0;

        boolean ok = smsAdapter.validateCaptcha(user.getPhone(),captcha);
        CardEntity card = cardMapper.selectById(cardId);
        if(card==null || card.getUserId() != user.getUserId()) throw new ApiException(ErrorCodeEnum.ArgumentError.getCode(),"请选择正确的银行卡");

        AgentEntity agent = agentMapper.selectById(user.getAgentId());

        try {
            GameRsp<Float> resp = gameConnector.openBalanceGet(agent.getBgPwd(),user.getBgLoginId());
            bgBalance = new Double(resp.getResult());
        } catch (IOException e) {
            e.printStackTrace();
            throw new ApiException(ErrorCodeEnum.NetWorkError);
        }

        //余额不足
        if(bgBalance < amount){
            throw new ApiException(ErrorCodeEnum.BalanceNoneException);
        }

        Map<String,Object> whereMap = new HashMap<>();
        whereMap.put("user_id",user.getUserId());
        UserAccountEntity accountEntity;
        List<UserAccountEntity> temp = accountMapper.selectByMap(whereMap);
        if(temp.size() < 1){
            accountEntity = new UserAccountEntity();
            accountEntity.setUserId(user.getUserId());
            accountEntity.setCreateBy(user.getUserId());
            accountEntity.setCreateDate(new Timestamp(System.currentTimeMillis()));
            accountEntity.setUpdateBy(user.getUserId());
            accountEntity.setUpdateDate(new Timestamp(System.currentTimeMillis()));
            accountEntity.setIsDelete(0);
            accountMapper.insert(accountEntity);
        }else {
            accountEntity = temp.get(0);
        }
        //获取审核步骤的flowid
        long flowId=0;
        AuditTemplateStepEntity auditTemplateStepEntity=new AuditTemplateStepEntity();
        auditTemplateStepEntity.setTempId((long)AuditTemplateEnum.WithdrawAudit.getCode());
        auditTemplateStepEntity.setStep(1);
        EntityWrapper<AuditTemplateStepEntity> wrapper = new EntityWrapper<AuditTemplateStepEntity>(auditTemplateStepEntity);
        List<AuditTemplateStepEntity> selectList = auditTemplateStepService.selectList(wrapper);
        if(selectList.size() >0){
            auditTemplateStepEntity=selectList.get(0);
            flowId=auditTemplateStepEntity.getFlowId();
        }

        //新增记录
        UserAccountDetailEntity withdraw = new UserAccountDetailEntity();
        withdraw.setUserId(user.getUserId());
        withdraw.setTradeStatus(TradeStatusEnum.Auditing);
        withdraw.setTradeKind(TradeKindEnum.Expend);
        withdraw.setTradeType(TradeTypeEnum.Withdraw);
        withdraw.setAmount(amount);
        withdraw.setTradeNo(CodeFactory.generateWithdrawCode());
        withdraw.setAccountId(accountEntity.getAccountId());
        withdraw.setCreateBy(user.getUserId());
        withdraw.setCreateDate(new Timestamp(System.currentTimeMillis()));
        withdraw.setUpdateBy(user.getUserId());
        withdraw.setUpdateDate(new Timestamp(System.currentTimeMillis()));
        withdraw.setIsDelete(0);
        withdraw.setFlowId(flowId);
        accountDetailMapper.insert(withdraw);

        GameRsp<Float> newBalance;
        try {
            newBalance = gameConnector.openBalanceTransfer(agent.getBgPwd(),user.getBgLoginId(),String.valueOf(-1 * amount),withdraw.getTradeId(),"1");
        } catch (IOException e) {
            e.printStackTrace();
            throw new ApiException(ErrorCodeEnum.BgBalanceTransferException);
        }

        accountEntity.setBalance(newBalance.getResult());
        accountEntity.setTotalWithdraw(accountEntity.getTotalWithdraw() + amount);
        accountEntity.setUpdateBy(user.getUserId());
        accountEntity.setUpdateDate(new Timestamp(System.currentTimeMillis()));
        accountMapper.updateById(accountEntity);



        return true;
    }
}
