package com.agdress.mogo;

import com.agdress.SpringTestBase;
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
import com.agdress.enums.SystemIdEnum;
import com.agdress.mongodb.DBOrderGamesDao;
import com.agdress.mongodb.model.DBOrderGames;
import com.agdress.service.Starship_IGamesService;
import com.agdress.service.Starship_IUserService;
import org.apache.log4j.LogManager;
import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.*;

import static org.junit.Assert.assertNotNull;

/**
 * Created by Administrator on 2017/8/3.
 * Description: *_*
 */
public class MogoImplTest extends SpringTestBase {
    Logger logger = LoggerFactory.getLogger(MogoImplTest.class);



    @Autowired
    private Starship_IGamesService gamesService;


    @Autowired
    private DBOrderGamesDao dbOrderGamesDao;

    private static final org.apache.log4j.Logger GAMES = LogManager.getLogger("games");

    /**
     * 从mogo获取游戏记录
     * @throws Exception
     */
    @Test
    public void findList() throws Exception {
        try{
            DBOrderGames dbOrderGames=new DBOrderGames();
//            dbOrderGames.setLoginId("ETEE5SS");
//            dbOrderGames.setFromIp("122.53.134.66");
//            dbOrderGames.setOrderStatus(GamesStatusEnum.SettleTransfer);
            dbOrderGames.setStarttime(DateUtil.fomatDate1("2017-09-30 10:00:00"));
            dbOrderGames.setEndtime(DateUtil.fomatDate1("2017-09-30 12:00:00"));
//            dbOrderGames.setShowGameId(1);
            List<DBOrderGames> list=dbOrderGamesDao.findList(dbOrderGames,0,1000);
            for (DBOrderGames db:list ) {
                System.out.println("db="+db.toString());
             }
            //统计数据
            Map<String,String> map=dbOrderGamesDao.countSum(dbOrderGames);
            int total=Integer.parseInt(map.get("countAll"));
            double allcome_onmoney=Double.parseDouble(map.get("allcome_onmoney"));
            double allexpendmoney=Double.parseDouble(map.get("allexpendmoney"));
            System.out.println("total="+total+"%%%%allcome_onmoney="+allcome_onmoney+"%%%%allexpendmoney="+allexpendmoney);
        }catch (Exception e){
            e.printStackTrace();
        }
    }


    /**
     * 获取游戏记录
     * @throws Exception
     */
    @Test
    public void openOrderQuery() throws Exception {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        String nowtime=sdf.format(new Date().getTime());
        System.out.println("北京时间 :"+nowtime);
        Calendar calendar = Calendar.getInstance();
        sdf.setTimeZone(TimeZone.getTimeZone("UTC"));
        String utcTime=sdf.format(calendar.getTime());
        System.out.println("UTC :"+utcTime);

        String starttime="2017-09-29 2:00:00";
        String endtime="2017-09-29 4:00:00";

//        gamesService.getThreeGamesList(null, null, 0, null, starttime, endtime, 2, 0, 0, null, 1, 300, null);
    }



}