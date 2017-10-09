package com.agdress.service.impl;


import com.agdress.bgapi.GameRsp;
import com.agdress.bgapi.IGameConnector;
import com.agdress.commons.Exception.ApiException;
import com.agdress.commons.utils.DateUtil;
import com.agdress.entity.*;
import com.agdress.entity.vo.Starship_AccountDetaillistVo;
import com.agdress.entity.vo.Starship_SumVo;
import com.agdress.enums.*;
import com.agdress.mapper.AgentMapper;
import com.agdress.mapper.Starship_AccountDetailMapper;
import com.agdress.mapper.UserAccountMapper;
import com.agdress.message.SmsAdapter;
import com.agdress.result.DatatablesResult;
import com.agdress.service.*;
import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
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
public class Starship_AccountDetailService extends ServiceImpl<Starship_AccountDetailMapper,Starship_UserAccountDetailEntity> implements Starship_IAccountDetailService {

    @Autowired
    private Starship_AccountDetailMapper accountDetailMapper;

    @Autowired
    private IGameConnector gameConnector;

    @Autowired
    private UserAccountMapper accountMapper;

    @Autowired
    private AgentMapper agentMapper;

    @Autowired
    private IAuditLogsService auditLogsService;

    @Autowired
    private IAuditTemplateStepService auditTemplateStepService;

    @Autowired
    private Starship_IUserService starship_iUserService;


    @Autowired
    private IMessageService messageService;

    @Autowired
    private IMessageContentService  messageContentService;

    @Autowired
    private SmsAdapter smsAdapter;

    @Autowired
    private IMessageProducerService producerService;
    @Autowired
    @Qualifier("payNotifyQueueDestination")
    private Destination payDestination;


    @Override
    public Starship_AccountDetaillistVo selectByTradeId(Long trade_id) {
        Starship_AccountDetaillistVo advo=accountDetailMapper.selectByTradeId(trade_id);
        AgentEntity agent = agentMapper.selectById(advo.getAgentId());
        double bgBalance=0;
        try {
            GameRsp<Float> resp = gameConnector.openBalanceGet(agent.getBgPwd(),advo.getBgLoginId());
            bgBalance = new Double(resp.getResult());
        } catch (IOException e) {
            e.printStackTrace();
            throw new ApiException(ErrorCodeEnum.NetWorkError);
        }
        advo.setActionTotle(bgBalance);
         return advo;
    }


    /**
     * 获取流水列表
     * @param whereMap
     * @param page
     * @param rows
     * @param draw
     * @return
     */
    @Override
    public DatatablesResult<Starship_AccountDetaillistVo> selectAccountDetailListVoPage(Map<String,String> whereMap, Integer page, Integer rows, Integer draw) {
        PageHelper.startPage(page, rows);
        //统计数据
        List<Starship_AccountDetaillistVo> adlistVos = this.accountDetailMapper.selectAccountDetailListVoPage(whereMap);
        PageInfo<Starship_AccountDetaillistVo> pageInfo = new PageInfo<Starship_AccountDetaillistVo>(adlistVos);
        DatatablesResult pageResult = new DatatablesResult<Starship_AccountDetaillistVo>();
        pageResult.setData(adlistVos);
        pageResult.setDraw(draw);
        pageResult.setRecordsTotal((int)pageInfo.getTotal());
        pageResult.setRecordsFiltered(pageResult.getRecordsTotal());
        ///统计金额
        try{

               List<Starship_SumVo> sumVoList=accountDetailMapper.sumMoneyForType(whereMap);
               for(Starship_SumVo sumVo : sumVoList){
                   if(sumVo.getTradeKindEnum() == null){
                       continue;
                   }
                   if(sumVo.getTradeKindEnum().getCode() == 1){
                       pageResult.setAllcome_onmoney(sumVo.getSumMoney());
                   }else if(sumVo.getTradeKindEnum().getCode() == -1){
                       pageResult.setAllexpendmoney(sumVo.getSumMoney());
                   }
               }
           }catch (Exception e){
               e.printStackTrace();
           }
        //==============================
         return pageResult;
    }


    /**
     * 更新当前记录状态
     * @param tradeId
     * @param examine 不等空表示---审核
     * @param playMoeny 不等于空表示---打款
      * @param updateBy
     */
    @Override
    public void UpdateAccountDetail(String tradeId, String  examine, String playMoeny,  String updateBy,String remarks) {
        Starship_UserAccountDetailEntity userAccountDetailEntity=new Starship_UserAccountDetailEntity();
        userAccountDetailEntity.setRemarks(remarks);
        if(updateBy == null){
            updateBy= String.valueOf(RoleTypeEnum.admin.getCode());
        }
        userAccountDetailEntity.setUpdateDate(new Timestamp(System.currentTimeMillis()));
        userAccountDetailEntity.setUpdateBy(Long.parseLong(updateBy));
        userAccountDetailEntity.setTradeId(Long.parseLong(tradeId));
        if(examine != null){
            Starship_UserAccountDetailEntity accountDetailEntity=accountDetailMapper.selectById(tradeId);
            if(accountDetailEntity == null){
                throw new ApiException(ErrorCodeEnum.InvalidOrderException);
            }
            long flowId=accountDetailEntity.getFlowId();
            AuditTemplateStepEntity auditTemplateStepEntity=auditTemplateStepService.selectById(flowId);//步骤详情
            Starship_UserEntity starship_userEntity=starship_iUserService.selectById(updateBy);//操作员详情
            //如果角色不一致则return
            if(auditTemplateStepEntity == null || starship_userEntity ==null || auditTemplateStepEntity.getRoleId() != starship_userEntity.getRoleId() ){
                throw new ApiException(ErrorCodeEnum.InvalidRoleException);
            }
            String message=remarks.equals("")?"出金审核通过":remarks;
            double amount=accountDetailEntity.getAmount();
            //判断余额是否充足
            Starship_UserEntity userEntity=starship_iUserService.selectById(accountDetailEntity.getUserId());
            if(examine.equals("false")){
                //审核不通过处理的逻辑---开始返还金额
                userAccountDetailEntity.setTradeStatusEnum(TradeStatusEnum.AuditDisagree);//添加不通过状态
            }else{
                //判断余额是否充足
                AgentEntity agent = agentMapper.selectById(userEntity.getAgentId());
                double bgBalance=0;
                try {
                    GameRsp<Float> resp = gameConnector.openBalanceGet(agent.getBgPwd(),userEntity.getBgLoginId());
                    bgBalance = new Double(resp.getResult());
                } catch (IOException e) {
                    e.printStackTrace();
                    throw new ApiException(ErrorCodeEnum.NetWorkError);
                }
                 //余额不足
                if(bgBalance < amount){
                    throw new ApiException(ErrorCodeEnum.BalanceNoneException);
                }
                //判断是否还有下一个步骤
                Integer step=auditTemplateStepEntity.getStep()+1;
                auditTemplateStepEntity=new AuditTemplateStepEntity();
                auditTemplateStepEntity.setTempId((long)AuditTemplateEnum.WithdrawAudit.getCode());
                auditTemplateStepEntity.setStep(step);
                EntityWrapper<AuditTemplateStepEntity> wrapper = new EntityWrapper<AuditTemplateStepEntity>(auditTemplateStepEntity);
                List<AuditTemplateStepEntity> selectList = auditTemplateStepService.selectList(wrapper);
                if(selectList.size() > 0){
                    long flowId_next=selectList.get(0).getFlowId();
                    userAccountDetailEntity.setFlowId(flowId_next);
                    //新增消息通知
                    MessageContentEntity messageContentEntity=new MessageContentEntity();
                    //判断是否是客服还是财务
                    Starship_UserEntity message_userEntity=starship_iUserService.selectById(updateBy);
                    if(message_userEntity != null && selectList.get(0).getRoleId() == RoleTypeEnum.Salesman.getCode()){
                        messageContentEntity.setUserId(message_userEntity.getUserId());
                    }
                    messageContentEntity.setStatus(0);
                    messageContentEntity.setTradeId(Long.parseLong(tradeId));
                    messageContentEntity.setRoleId(selectList.get(0).getRoleId());
                    messageContentEntity.setCreateBy(Long.parseLong(updateBy));
                    messageContentEntity.setCreateDate(new Timestamp(System.currentTimeMillis()));
                    messageContentEntity.setUpdateBy(Long.parseLong(updateBy));
                    messageContentEntity.setUpdateDate(new Timestamp(System.currentTimeMillis()));
                    messageContentEntity.setIsDelete(0);
                    String content="你有一笔新的提现审核，编号："+accountDetailEntity.getTradeNo()+"。";
                    messageContentEntity.setContent(content);
                    messageContentService.insert(messageContentEntity);
                 }else{
                    userAccountDetailEntity.setTradeStatusEnum( TradeStatusEnum.ShippedIsOk);
                    //更新余额
                    Map<String,Object> whereMap = new HashMap<>();
                    whereMap.put("user_id",userEntity.getUserId());
                    UserAccountEntity accountEntity;
                    List<UserAccountEntity> temp = accountMapper.selectByMap(whereMap);
                    accountEntity = temp.get(0);
                    GameRsp<Float> newBalance;
                    try {
                        newBalance = gameConnector.openBalanceTransfer(agent.getBgPwd(),userEntity.getBgLoginId(),String.valueOf(-1 * amount),Long.parseLong(tradeId),"1");
                    } catch (IOException e) {
                        e.printStackTrace();
                        throw new ApiException(ErrorCodeEnum.BgBalanceTransferException);
                    }
                    accountEntity.setBalance(newBalance.getResult());
                    accountEntity.setTotalWithdraw(accountEntity.getTotalWithdraw() + amount);
                    accountEntity.setUpdateBy(userEntity.getUserId());
                    accountEntity.setUpdateDate(new Timestamp(System.currentTimeMillis()));
                    accountMapper.updateById(accountEntity);
                }
            }
            //==当前步骤添加audit_logs纪录
            auditLogsService.addAuditLogs(tradeId, AuditTemplateEnum.WithdrawAudit.getCode(), flowId,  message, updateBy);
            //修改消息通知状态
            MessageContentEntity messageContentEntity=new MessageContentEntity();
            //判断是否是客服还是财务
            Starship_UserEntity message_userEntity=starship_iUserService.selectById(updateBy);
            if(message_userEntity != null){
                if(message_userEntity.getRoleId() == RoleTypeEnum.Salesman.getCode()){
                    messageContentEntity.setUserId(Long.parseLong(updateBy));
                }
                messageContentEntity.setRoleId(message_userEntity.getRoleId());
            }
            messageContentEntity.setTradeId(Long.parseLong(tradeId));
            EntityWrapper<MessageContentEntity> wrapper = new EntityWrapper<MessageContentEntity>(messageContentEntity);
            List<MessageContentEntity> selectList = messageContentService.selectList(wrapper);
            if(selectList.size() >0){
                messageContentEntity=selectList.get(0);
                messageContentEntity.setStatus(1);
                messageContentEntity.setUpdateBy(Long.parseLong(updateBy));
                messageContentEntity.setUpdateDate(new Timestamp(System.currentTimeMillis()));
                messageContentService.updateById(messageContentEntity);
            }
        }else{
            if(playMoeny != null ){
                if(playMoeny.equals("true")){
                     //是否打款
                    userAccountDetailEntity.setTradeStatusEnum(TradeStatusEnum.Complete);
                    //发送消息到提现人

                }
             }
        }
        int n=accountDetailMapper.updateById(userAccountDetailEntity);
        if(n == 0){
            throw new ApiException(ErrorCodeEnum.SystemBusy);
        }
    }


}
