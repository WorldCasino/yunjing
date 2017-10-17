package com.kk.kygame;



import java.io.IOException;
import java.util.Date;
import java.util.List;

/**
 * Created by Administrator on 2017/8/1.
 * Description: *_*
 */
public interface IGameConnector {


    GameRsp<Object> login(String account,String money,String ip,String  lineCode ,int KindID) throws Exception;

    GameRsp<Object> searchBalance( String account ) throws Exception;

    GameRsp<Object> upScore(String account,String money,String orderid) throws Exception;

    GameRsp<Object> downScore(String account,String money,String orderid) throws Exception;

    GameRsp<Object> searchOrder(String orderid) throws Exception;

//    GameRsp<Object> isLogin( String account ) throws Exception;

//    GameRsp<Object> getGameList( long starttime,long endtime ) throws Exception;

}
