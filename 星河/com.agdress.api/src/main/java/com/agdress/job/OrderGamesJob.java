package com.agdress.job;


import com.agdress.bgapi.GameRsp;
import com.agdress.bgapi.IGameConnector;
import com.agdress.bgapi.rsp.OrderQuery;
import com.agdress.bgapi.rsp.OrderQueryItem;
import com.agdress.bgapi.rsp.VideoRoundQuery;
import com.agdress.bgapi.rsp.VideoRoundQueryItem;
import com.agdress.commons.Exception.ApiException;
import com.agdress.commons.utils.*;
import com.agdress.enums.GamesIdEnum;
import com.agdress.enums.GamesStatusEnum;
import com.agdress.enums.GamesVideoStatusEnum;
import com.agdress.mongodb.DBOrderGamesDao;

import com.agdress.mongodb.model.DBOrderGames;
import com.agdress.service.Starship_IGamesService;
import com.agdress.service.Starship_IUserService;
import org.apache.log4j.LogManager;
import org.springframework.beans.factory.annotation.Autowired;
 import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.TimeZone;


/**
 * 获取游戏记录
 * Created by Administrator on 2017/9/22.
 */
@Component("orderGamesJob")
public class OrderGamesJob {
    private static final org.apache.log4j.Logger GAMES = LogManager.getLogger("games");


    @Autowired
    private Starship_IGamesService gamesService;


    /**
     * 每隔5分通知一次
     */
    @Scheduled(fixedRate = 300000)
    public void notifyJob2(){
        try {
            //获取三十分钟前的时间和二十分钟前的时间
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
            System.out.println("北京时间 :"+sdf.format(new Date().getTime()));
            Calendar calendar = Calendar.getInstance();
            sdf.setTimeZone(TimeZone.getTimeZone("UTC"));
            String utcTime=sdf.format(calendar.getTime()).replaceAll("/","-");
            System.out.println("国际标准时间 :"+utcTime);
            String starttime=DateUtil.getAfterMinuteDate(utcTime,-30);
            String endtime=DateUtil.getAfterMinuteDate(utcTime,-20);
            System.out.println("games-进来获取游戏数据开始时间="+starttime+"=至结束时间="+endtime);
            gamesService.getThreeGamesList(null, null, 0, null,
                    null, null, 0, 0, 0, null, 1, 15, null);
        } catch (Exception e) {
            e.printStackTrace();
            GAMES.error("games-获取游戏记录失败"+e.toString());
         }
    }
}
