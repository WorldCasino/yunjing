package com.agdress.service.impl;

import com.agdress.bgapi.GameRsp;
import com.agdress.bgapi.IGameConnector;
import com.agdress.commons.Exception.ApiException;
import com.agdress.commons.utils.*;
import com.agdress.entity.*;
import com.agdress.enums.*;
import com.agdress.mapper.*;
import com.agdress.message.SmsAdapter;
import com.agdress.service.*;
import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.jms.Destination;
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

    @Autowired
    private IMessageService messageService;
    @Autowired
    private IMessageContentService  messageContentService;

    @Autowired
    private IMessageProducerService producerService;
    @Autowired
    @Qualifier("payNotifyQueueDestination")
    private Destination payDestination;
    @Autowired
    private Starship_IUserService starship_iUserService;
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
                .andNew("user_id = {0}",user.getUserId())
                .andNew("trade_status <> {0}",TradeStatusEnum.Paying.getCode());
        if(tradeKind.getCode() != TradeKindEnum.ALL.getCode()){
            ew.andNew("trade_kind <> {0}",tradeKind.getCode());
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
        long roleId=1;
        AuditTemplateStepEntity auditTemplateStepEntity=new AuditTemplateStepEntity();
        auditTemplateStepEntity.setTempId((long)AuditTemplateEnum.WithdrawAudit.getCode());
        auditTemplateStepEntity.setStep(1);
        EntityWrapper<AuditTemplateStepEntity> wrapper = new EntityWrapper<AuditTemplateStepEntity>(auditTemplateStepEntity);
        List<AuditTemplateStepEntity> selectList = auditTemplateStepService.selectList(wrapper);
        if(selectList.size() >0){
            auditTemplateStepEntity=selectList.get(0);
            flowId=auditTemplateStepEntity.getFlowId();
            roleId=auditTemplateStepEntity.getRoleId();
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

//        更新余额
        GameRsp<Float> newBalance;
        try {
//            newBalance = gameConnector.openBalanceTransfer(agent.getBgPwd(),user.getBgLoginId(),String.valueOf(-1 * amount),withdraw.getTradeId(),"1");
            newBalance = gameConnector.openBalanceTransfer(agent.getBgPwd(),user.getBgLoginId(),"0",withdraw.getTradeId(),"1");
        } catch (IOException e) {
            e.printStackTrace();
            throw new ApiException(ErrorCodeEnum.BgBalanceTransferException);
        }

        accountEntity.setBalance(newBalance.getResult());
//      accountEntity.setTotalWithdraw(accountEntity.getTotalWithdraw() + amount);
        accountEntity.setUpdateBy(user.getUserId());
        accountEntity.setUpdateDate(new Timestamp(System.currentTimeMillis()));
        accountMapper.updateById(accountEntity);
        try{
            //添加提现提醒
            int maxWithdraw=SystemConfig.getInstance().getWITHDRAW_MONEY_MAX();
            //新增提现提醒记录
            MessageEntity messageEntity=new MessageEntity();
            messageEntity.setIcon("fa fa-user text-red");
            messageEntity.setMessageType(TradeTypeEnum.Withdraw);
            messageEntity.setTradeId(withdraw.getTradeId());
            messageEntity.setCreateBy(user.getUserId());
            messageEntity.setCreateDate(new Timestamp(System.currentTimeMillis()));
            messageEntity.setUpdateBy(user.getUserId());
            messageEntity.setUpdateDate(new Timestamp(System.currentTimeMillis()));
            messageEntity.setIsDelete(0);
            messageService.insert(messageEntity);
            //新增提现内容
            MessageContentEntity messageContentEntity=new MessageContentEntity();
            messageContentEntity.setStatus(0);
            messageContentEntity.setTradeId(withdraw.getTradeId());
            messageContentEntity.setRoleId(roleId);
            messageContentEntity.setCreateBy(user.getUserId());
            messageContentEntity.setCreateDate(new Timestamp(System.currentTimeMillis()));
            messageContentEntity.setUpdateBy(user.getUserId());
            messageContentEntity.setUpdateDate(new Timestamp(System.currentTimeMillis()));
            messageContentEntity.setIsDelete(0);
            String content="你有一笔新的提现审核，编号："+withdraw.getTradeNo()+"。";
            messageContentEntity.setContent(content);
            //判断是否是客服还是财务
            if(roleId == RoleTypeEnum.Salesman.getCode()){
                Starship_UserEntity message_userEntity=starship_iUserService.selectById(user.getBeUserId());
                if(message_userEntity != null){
                    if(message_userEntity.getRoleId() == RoleTypeEnum.Salesman.getCode()){
                        messageContentEntity.setUserId(user.getBeUserId());
                    }
                    if(message_userEntity.getPhone() != null){
                        JSONObject json = new JSONObject();
                        json.put("type", QueueMessageTypeEnum.Examine.getCode());
                        json.put("phone",message_userEntity.getPhone());
                        json.put("userName",user.getNickname()== null?user.getPhone():user.getNickname());
                        json.put("amount",amount);
                        json.put("tradeNo",withdraw.getTradeNo());
                        String messagekey=DateUtil.getDayshms();
                        json.put("messagekey",messagekey);
                        producerService.sendMessagePhone(messagekey,this.payDestination,json.toJSONString());
                    }
                }
            }
            messageContentService.insert(messageContentEntity);
            if(amount >= maxWithdraw){
                MessageContentEntity messageContentEntity2=new MessageContentEntity();
                messageContentEntity2.setStatus(0);
                messageContentEntity2.setTradeId(withdraw.getTradeId());
                messageContentEntity2.setUserId((long) SystemIdEnum.admin.getCode());
                messageContentEntity.setRoleId((long) RoleTypeEnum.admin.getCode());
                messageContentEntity2.setCreateBy(user.getUserId());
                messageContentEntity2.setCreateDate(new Timestamp(System.currentTimeMillis()));
                messageContentEntity2.setUpdateBy(user.getUserId());
                messageContentEntity2.setUpdateDate(new Timestamp(System.currentTimeMillis()));
                messageContentEntity2.setIsDelete(0);
                String content1=user.getNickname() == null?user.getPhone():user.getNickname()+" 发起了一笔大额提现申请，金额："+amount+"，订单编号："+withdraw.getTradeNo()+"。";
                messageContentEntity2.setContent(content1);
                messageContentService.insert(messageContentEntity2);
                Starship_UserEntity admin_userEntity=starship_iUserService.selectById( SystemIdEnum.admin.getCode());
                if(admin_userEntity != null && admin_userEntity.getPhone() != null){
                    JSONObject json = new JSONObject();
                    json.put("type", QueueMessageTypeEnum.WithdrawMax.getCode());
                    json.put("phone",admin_userEntity.getPhone());
                    json.put("userName",user.getNickname() == null?user.getPhone():user.getNickname());
                    json.put("amount",amount);
                    json.put("tradeNo",withdraw.getTradeNo());
                    String messagekey=DateUtil.getDayshms();
                    json.put("messagekey",messagekey);
                    producerService.sendMessagePhone(messagekey,this.payDestination,json.toJSONString());
                }
            }
        }catch (Exception e){
            e.printStackTrace();
        }

        return true;
    }
}
