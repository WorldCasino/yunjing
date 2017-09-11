package com.cicada.job.Ball;


import com.cicada.commons.utils.SpringContextUtil;
import com.cicada.enums.MatchesStatusEnum;
import com.cicada.pojo.MatchesEntity;
import com.cicada.service.impl.MatchesServiceImpl;

import java.util.TimerTask;

/**
 *
 * 类名称：BallMatchOpenTask
 * 类描述：球赛事开始定时器
 * 创建人：魏汉文
 * 创建时间：2016年4月7日 上午9:50:10
 */
public class BallMatchOpenTask extends TimerTask {

    private long matchId;//赛事ID

    public BallMatchOpenTask(){

    }

    public BallMatchOpenTask(long matchId  ) {
        super();
        this.matchId = matchId;
    }


    @Override
    public void run() {
        try {
            System.out.println("进来开始定时器====开始时间");
            MatchesEntity matchesEntity=((MatchesServiceImpl) SpringContextUtil.getBean("matchesServiceImpl")).selectById(matchId);
            matchesEntity.setMatchesStatusEnum(MatchesStatusEnum.Underway);
            ((MatchesServiceImpl) SpringContextUtil.getBean("matchesServiceImpl")).updateById(matchesEntity);
         } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }
    }


}
