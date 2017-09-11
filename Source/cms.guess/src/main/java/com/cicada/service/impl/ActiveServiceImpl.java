package com.cicada.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.cicada.commons.Exception.ApiException;
import com.cicada.commons.utils.JacksonSerializer;
import com.cicada.commons.utils.SpringContextUtil;
import com.cicada.mapper.ActiveMapper;
import com.cicada.mapper.OperateMapper;
import com.cicada.pojo.ActiveEntity;
import com.cicada.pojo.vo.ActiveVo;
import com.cicada.pojo.vo.OperateVo;
import com.cicada.redis.MessageQueueProducer;
import com.cicada.service.IActiveService;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.IOException;
import java.util.List;
import java.util.Map;

/**
 * 活动接口实现
 * Created by Administrator on 2017/5/25.
 */
@Service
@Transactional
public class ActiveServiceImpl extends ServiceImpl<ActiveMapper,ActiveEntity> implements IActiveService {

    private static final Logger ACTIVE_LOGGER = LogManager.getLogger("active");

    @Autowired
    private ActiveMapper activeMapper;
    @Autowired
    private OperateMapper operateMapper;

    @Autowired
    private JacksonSerializer jacksonSerializer;


    @Override
    public List<ActiveVo> selectActives(Map<String, Object> params) throws ApiException {

        List<ActiveVo> activeVo=activeMapper.selectActiveVo(params);

        return activeVo;
    }

    /**
     * 插入任务
     * @param params 任务详情
     * @return
     * @throws ApiException
     */
    public void insertDailyActive(Map<String, Object> params) throws ApiException{
        activeMapper.insertDailyActive(params);
    };

    /**
     * 更新任务进度
     * @param params 任务详情
     * @return
     * @throws ApiException
     */
    public void updateDailyActive(Map<String, Object> params) throws ApiException{
        activeMapper.updateDailyActive(params);
    };

    /**
     * 定时任务中，需要放入REDIS_QUEUE_OPERATE队列的操作列表
     * @param
     * @return ActiveVo
     * @throws ApiException
     */
    public List<OperateVo> selectWattingOperates() throws ApiException {
        List<OperateVo> activeVo=operateMapper.selectWattingOperates();
        return activeVo;
    };

    @Override
    public int selectBoxActive(Map<String,Object> params) throws ApiException {

        int boxActive=activeMapper.selectBoxActive(params);

        return boxActive;
    }

    /**
     * 插入任务
     * @param params 任务详情
     * @return
     * @throws ApiException
     */
    public void insertBoxActive(Map<String,Object> params) throws ApiException{
        activeMapper.insertBoxActive(params);
    };

    /**
     * 查看可领取的奖励
     * @param userId
     * @return
     * @throws ApiException
     */
    public void activeReward(long userId) throws ApiException{
        //有几个可领取奖励的任务
        int cnt=activeMapper.getActiveReward(userId);
        if(cnt==0){
            return;
        }else{
            JSONObject payload = new JSONObject();
            payload.put("type","reward");
            JSONObject msg = new JSONObject();
            msg.put("user_id",userId);
            msg.put("cnt",cnt);
            payload.put("reward",msg);
            MessageQueueProducer queueProducer = (MessageQueueProducer) SpringContextUtil.getBean("sendMessage");
            try {
                queueProducer.sendRewardMessage(jacksonSerializer.toJson(payload));
                ACTIVE_LOGGER.info(String.format("用户【%s】可领取奖励通知已发", userId));
            } catch (IOException e) {
                e.printStackTrace();
                ACTIVE_LOGGER.info(String.format("用户【%s】可领取奖励通知发送失败", userId),e);
            }
        }
    }

    /**
     * 用户是否参与过此竞猜
     * @param params
     * @return
     * @throws ApiException
     */
    public int isParticipationActive(Map<String, Object> params) throws ApiException {
        int cnt=activeMapper.isParticipationActive(params);
        return cnt;
    }

}
