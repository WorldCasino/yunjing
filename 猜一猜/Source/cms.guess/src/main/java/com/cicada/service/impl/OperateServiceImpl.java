package com.cicada.service.impl;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.cicada.commons.Exception.ApiException;
import com.cicada.mapper.OperateMapper;
import com.cicada.pojo.OperateEntity;
import com.cicada.pojo.vo.ActiveVo;
import com.cicada.pojo.vo.OperateVo;
import com.cicada.service.IActiveService;
import com.cicada.service.IOperateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 活动接口实现
 * Created by Administrator on 2017/8/23.
 */
@Service
@Transactional
public class OperateServiceImpl extends ServiceImpl<OperateMapper,OperateEntity> implements IOperateService {

    @Autowired
    private IActiveService activeService;

    @Autowired
    private OperateMapper operateMapper;


    @Override
    public void cleanOperateLogJob() throws ApiException {
        operateMapper.deleteOperateLog();
    }

    @Override
    public void deleteDailyActivesJob() throws ApiException {
        operateMapper.deleteDailyActives();
    }

    @Override
    public int isParticipationActive(OperateVo operateVo) throws ApiException {
        Map<String,Object> Params=new HashMap<String,Object>();
        long userId = operateVo.getUserId();
        long taskId = operateVo.getTaskId();
        Params.put("userId",userId);
        Params.put("taskId",taskId);

        int cnt=activeService.isParticipationActive(Params);
        return cnt;
    }

    @Override
    public void deleteOperateLog(OperateVo operateVo) throws ApiException {
        operateMapper.deleteOperateLogById(operateVo.getOperateId());
    }

    @Override
    public void operateProccess(OperateVo operateVo) throws ApiException {
        Map<String,Object> operateParams=new HashMap<String,Object>();
        long userId = operateVo.getUserId();
        int operateType = operateVo.getOperateType();
        int quantity = operateVo.getQuantity();
        Timestamp operate_time=operateVo.getOperateTime();

        operateParams.put("userId",userId);
        operateParams.put("operateType",operateType);
        operateParams.put("quantity",quantity);
        operateParams.put("operate_time",operate_time);

        //查看是否有此操作状态是否已完成
        int cnt=operateMapper.selectOperateStatus(operateParams);
        if(cnt==0){
            return;
        }
        /*
                根据任务类型，相应的操作
                任务配置表：t_actives
                active_type：0-每日任务，1-成长任务
:
                operate_type：1-登录，2-发布，3-下注
         */
        /*
            流程处理：
            先根据任务类型active_type，将用户任务存进t_actives_daily
              每日任务：无数据--insert，有数据--update
              成长任务：update
         */
        Map<String,Object> params=new HashMap<String,Object>();
        params.put("userId",userId);
        params.put("operateType",operateType);
        Timestamp updateDate=operate_time;

        SimpleDateFormat formatter;
        formatter = new SimpleDateFormat ("yyyyMMdd");
        String schDate = formatter.format(operate_time);

        List<ActiveVo> activeVos = activeService.selectActives(params);
        if (null == activeVos) {
            return;
        }
        for(ActiveVo activeVo:activeVos){
            long schId=activeVo.getSchId();
            long activeId=activeVo.getActiveId();
            int active_type=activeVo.getActiveType();
            int total=activeVo.getTotal();
            int coinType=activeVo.getCoinType();
            int rewardCoins=activeVo.getRewardCoins();
            int rewardLiveness=activeVo.getRewardLiveness();

            String schDateOld=activeVo.getSchDate();
            /*
                total=0,说明任务在t_actives_daily无记录，做插入操作
                total！=0，则total+=quantity，
             */
            if(total==0){
                params.put("schId",schId);
                params.put("activeId",activeId);
                params.put("total",quantity);
                params.put("coinType",coinType);
                params.put("rewardCoins",rewardCoins);
                params.put("rewardLiveness",rewardLiveness);
                params.put("updateDate",updateDate);
                params.put("schDate",schDate);
                params.put("operateType",operateType);
                params.put("active_type",active_type);
                activeService.insertDailyActive(params);
            }else{
                if(operateType==1 && schDateOld.equals(schDate)){
                    //登录任务，当天多次登录不累加
                }else{
                    total+=quantity;
                }

                params.put("schId",schId);
                params.put("total",total);
                params.put("schDate",schDate);
                params.put("updateDate",updateDate);
                activeService.updateDailyActive(params);
            }
        }

        //登录时，将每日宝箱任务更新
        if(operateType==1){
            //宝箱任务
            params=new HashMap<String,Object>();
            params.put("userId",userId);
            params.put("schDate",schDate);
            params.put("schDate",schDate);
            params.put("updateDate",operate_time);
            params.put("userId",userId);
            params.put("total",1);
            params.put("operateType",0);
            params.put("active_type",2);

            int boxActive=activeService.selectBoxActive(params);
            if (boxActive==0){
                params.put("activeId",181);
                params.put("coinType",1);
                params.put("receiveCoins",60);
                activeService.insertBoxActive(params);

                params.put("activeId",182);
                params.put("coinType",1);
                params.put("receiveCoins",90);
                activeService.insertBoxActive(params);

                params.put("activeId",183);
                params.put("coinType",0);
                params.put("receiveCoins",30);
                activeService.insertBoxActive(params);
            }
        }



        //操作完成后更新日志状态，0：未完成  -->  1：已完成操作
        operateMapper.updateOperateStatus(operateParams);

        //判断是否有可领取的奖励
        activeService.activeReward(userId);
    }
}
