package com.agdress.bgapi;

import com.agdress.SpringTestBase;
import com.agdress.bgapi.rsp.OrderQuery;
import com.agdress.bgapi.rsp.OrderQueryItem;
import com.agdress.bgapi.rsp.VideoRoundQuery;
import com.agdress.bgapi.rsp.VideoRoundQueryItem;
import com.agdress.commons.Exception.ApiException;
import com.agdress.commons.utils.DateUtil;
import com.agdress.commons.utils.JacksonSerializer;
import com.agdress.mongodb.DBOrderGamesDao;
import com.agdress.mongodb.model.DBOrderGames;
import com.agdress.service.Starship_IGamesService;
import com.agdress.service.Starship_IUserService;
import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import static org.junit.Assert.*;

/**
 * Created by Administrator on 2017/8/3.
 * Description: *_*
 */
public class GameConnectorImplTest extends SpringTestBase {
    Logger logger = LoggerFactory.getLogger(GameConnectorImplTest.class);

    @Autowired
    private IGameConnector gameConnector;

    @Autowired
    private JacksonSerializer jacksonSerializer;

    @Autowired
    private Starship_IUserService userService;

    @Autowired
    private Starship_IGamesService gamesService;


    @Autowired
    private DBOrderGamesDao dbOrderGamesDao;

    @Test
    public void agentCreateTest() throws Exception {
        GameRsp rsp = gameConnector.openAgentCreate("bgdressagenttest101", "bgdressagentpwd");
        assertNotNull(rsp);
    }

    @Test
    public void userCreateTest() throws Exception {
        GameRsp rsp = gameConnector.openUserCreate("bgdressagenttest101", "bgdressagentpwd", "bgdresstest101", "test101");
        assertNotNull(rsp);
    }

    @Test
    public void videoGameUrlTest() throws Exception {
        GameRsp rsp = gameConnector.openVideoGameUrl("bgdressagentpwd", "bgdresstest101", 0, null);
        assertNotNull(rsp);
    }

    @Test
    public void videoRoundQuery() throws Exception {
//        jacksonSerializer.toJson("")
        GameRsp rsp = gameConnector.openVideoRoundQuery(7, "BGA07170925858" , 1, null, null, 0, 0, null);
        if (rsp.getError() == null) {
            VideoRoundQuery videoRoundQuery= (VideoRoundQuery) rsp.getResult();
            List<VideoRoundQueryItem> list2=videoRoundQuery.getItems();
            for (int j = 0; j < list2.size(); j++) {
                System.out.println(list2.get(j).toString());
            }
        } else {
            throw new ApiException(-1, "请求游戏失败!");
        }
    }

    @Test
    public void XHagentCreateTest() throws Exception {
        GameRsp rsp = gameConnector.openAgentCreate("bgagentlg4", "bgagentpw4");
        if (rsp.getError() == null) {
            System.out.println( rsp.getResult());
        } else {
            throw new ApiException(-1, "请求游戏失败!");
        }
    }


    @Test
    public void openOrderQuery() throws Exception {
        try {
            //获取三十分钟前的时间和二十分钟前的时间
            String nowtime= DateUtil.getAfterMinuteDate(DateUtil.getTime(),480);//时差相差8个小时
            String afterthree=DateUtil.getAfterMinuteDate(nowtime,-30);
            String aftertwo=DateUtil.getAfterMinuteDate(nowtime,-20);
            System.out.println("afterthree="+afterthree+"&&aftertwo="+aftertwo);
            GameRsp gameRsp = gameConnector.openOrderQuery(null, null, 0, null,
                    afterthree, aftertwo, 2, 0, 0, null, 1, 100, null);
            if (gameRsp.getError() == null) {
                OrderQuery orderQuery= (OrderQuery) gameRsp.getResult();
                List<OrderQueryItem> list=orderQuery.getItems();
                DBOrderGames dbOrderGames=null;
                for (int i = 0; i < list.size(); i++) {
                     OrderQueryItem orderQueryItem=list.get(i);
                    System.out.println(orderQueryItem.toString());
                    GameRsp rsp = gameConnector.openVideoRoundQuery(0, list.get(i).getIssueId(), 0, null, null, 0, 0, null);
                    if (rsp.getError() == null) {
                        VideoRoundQuery videoRoundQuery= (VideoRoundQuery) rsp.getResult();
                        List<VideoRoundQueryItem> list2=videoRoundQuery.getItems();
                        for (int j = 0; j < list2.size(); j++) {
                            VideoRoundQueryItem videoRoundQueryItem=list2.get(j);
                            System.out.println(videoRoundQuery.toString());
                         }
                    } else {
                        throw new ApiException(-1, "请求游戏失败!");
                    }
                    System.out.println(dbOrderGames.toString());
                    dbOrderGamesDao.save(dbOrderGames);
                }
             } else {
                // TODO: 2017/8/14 整理游戏错误
                throw new ApiException(-1, "请求游戏数据失败!");
            }
        } catch (IOException e) {
            e.printStackTrace();
            logger.error("request for openOrderQuery data exception");
            throw new ApiException(-1, "请求游戏数据失败!");
        }
    }

    @Test
    public void openOrderQuery2() throws Exception {
        try {
            //获取三十分钟前的时间和二十分钟前的时间
            String nowtime= DateUtil.getAfterMinuteDate(DateUtil.getTime(),480);//时差相差8个小时
            String afterthree=DateUtil.getAfterMinuteDate(nowtime,-30);
            String aftertwo=DateUtil.getAfterMinuteDate(nowtime,-20);
            System.out.println("afterthree="+afterthree+"&&aftertwo="+aftertwo);
            gamesService.getThreeGamesList(null, null, 0, null,
                    null, null, 0, 0, 0, null, 1, 15, null);
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("request for openOrderQuery data exception");
            throw new ApiException(-1, "请求游戏数据失败!");
        }
    }

}