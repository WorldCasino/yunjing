package com.agdress.service.impl;


import com.agdress.bgapi.GameRsp;
import com.agdress.bgapi.IGameConnector;
import com.agdress.commons.Exception.ApiException;
import com.agdress.entity.*;
import com.agdress.entity.vo.Starship_AccountDetaillistVo;
import com.agdress.entity.vo.Starship_SumVo;
import com.agdress.enums.*;
import com.agdress.mapper.AgentMapper;
import com.agdress.mapper.Starship_AccountDetailMapper;
import com.agdress.mapper.UserAccountMapper;
import com.agdress.result.DatatablesResult;
import com.agdress.service.*;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
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
            if(examine.equals("false")){
                //审核不通过处理的逻辑---开始返还金额
                double amount=accountDetailEntity.getAmount();
                Starship_AccountDetaillistVo advo=accountDetailMapper.selectByTradeId(Long.parseLong(tradeId));
                AgentEntity agent = agentMapper.selectById(advo.getAgentId());
                GameRsp<Float> newBalance;
                try {
                    newBalance = gameConnector.openBalanceTransfer(agent.getBgPwd(),advo.getBgLoginId(),String.valueOf(amount),accountDetailEntity.getTradeId(),"1");
                } catch (IOException e) {
                    e.printStackTrace();
                    throw new ApiException(ErrorCodeEnum.BgBalanceTransferException);
                }
                Map<String,Object> whereMap = new HashMap<>();
                whereMap.put("user_id",advo.getUserId());
                UserAccountEntity accountEntity;
                List<UserAccountEntity> temp = accountMapper.selectByMap(whereMap);
                accountEntity=temp.get(0);//获取会员财富数据
                accountEntity.setBalance(newBalance.getResult());
                accountEntity.setTotalWithdraw(accountEntity.getTotalWithdraw() - amount);
                accountEntity.setUpdateBy(Long.parseLong(updateBy));
                accountEntity.setUpdateDate(new Timestamp(System.currentTimeMillis()));
                accountMapper.updateById(accountEntity);
                userAccountDetailEntity.setTradeStatusEnum(TradeStatusEnum.AuditDisagree);//添加不通过状态
            }else{
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
                }else{
                    userAccountDetailEntity.setTradeStatusEnum( TradeStatusEnum.ShippedIsOk);
                }
            }
            //==当前步骤添加audit_logs纪录
            auditLogsService.addAuditLogs(tradeId, AuditTemplateEnum.WithdrawAudit.getCode(), flowId,  message, updateBy);
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
