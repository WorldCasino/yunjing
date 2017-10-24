package com.kk.kygame;

import com.fasterxml.jackson.core.type.TypeReference;
import com.kk.commons.utils.DateUtil;
import com.kk.commons.utils.JacksonSerializer;
import com.kk.commons.utils.PropertyConfigurer;
import com.kk.commons.utils.SystemConfig;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.io.InputStream;
import java.util.Date;
import java.util.List;
import java.util.Properties;
import java.util.UUID;

/**
 * Created by Administrator on 2017/8/2.
 * Description: *_*
 */
@Component
public class GameConnectorImpl implements IGameConnector {

    private final static String JSON_RPC = "2.0";



    private JacksonSerializer serializer;
    private SystemConfig systemConfig;


    @Autowired
    public GameConnectorImpl(JacksonSerializer serializer, SystemConfig config) {
        this.serializer = serializer;
        this.systemConfig = config;
    }

    //orderid=systemConfig.getGAME_AGENT()+ DateUtil.getDayshms(); 流水号（格式：代理编 号+yyyyMMddHHmmssSSS）
    //param=Encrypt.AESEncrypt(params,DES Key);
    // key Encrypt.MD5(systemConfig.getGAME_AGENT()+timestamp+ systemConfig.getGAME_MD5KEY());

    /**
     * 登录游戏
      * @param account 会员账号
     * @param money 上分的金额
     * @param ip
     * @param lineCode
     * @return
     * @throws IOException
     */
    @SuppressWarnings("unchecked")
    @Override
    public GameRsp<Object> login(String account, String money, String ip, String lineCode,int KindID ) throws Exception {
        long timestamp=System.currentTimeMillis();
        String key=Encrypt.MD5(systemConfig.getGAME_AGENT()+timestamp+ systemConfig.getGAME_MD5KEY());
        //获取param
        String orderid=systemConfig.getGAME_AGENT()+ DateUtil.getDayshms();
        String  params=String.format( "s=0&account=%s&money=%s&orderid=%s&ip=%s&lineCode=%s&KindID=%s",account,money,orderid,ip,lineCode,KindID);
        String param=Encrypt.AESEncrypt(params,systemConfig.getGAME_DESKEY());
        String url =String.format( systemConfig.getGAME_API(), systemConfig.getGAME_AGENT(),timestamp,param ,key);
        return gameRequest(url,  new TypeReference<GameRsp<Object>>() {});
    }


    /**
     * 游戏试玩的登录地址
     * @param account
     * @param money
     * @param ip
     * @param lineCode
     * @param KindID
     * @return
     * @throws Exception
     */
    @Override
    public GameRsp<Object> loginByVisitor(String account, String money, String ip, String lineCode, int KindID) throws Exception {

        InputStream in = PropertyConfigurer.class.getClassLoader().getResourceAsStream("environment/env-dev.properties");
        Properties props=new Properties();
        props.load(in);
        String agent=props.getProperty("game.config.agent");
        long timestamp=System.currentTimeMillis();
        String key=Encrypt.MD5(agent+timestamp+ props.getProperty("game.config.md5key"));
        //获取param
        String orderid=agent+ DateUtil.getDayshms();
        String  params=String.format( "s=0&account=%s&money=%s&orderid=%s&ip=%s&lineCode=%s&KindID=%s",account,money,orderid,ip,lineCode,KindID);
        String param=Encrypt.AESEncrypt(params,props.getProperty("game.config.deskey"));
        String url =String.format( props.getProperty("game.config.api"), agent,timestamp,param ,key);
        return gameRequest(url,  new TypeReference<GameRsp<Object>>() {});

    }


    @SuppressWarnings("unchecked")
    @Override
    public GameRsp<Object> gamesAllBalanceVisitor(String account) throws Exception {
        InputStream in = PropertyConfigurer.class.getClassLoader().getResourceAsStream("environment/env-dev.properties");
        Properties props=new Properties();
        props.load(in);
        String agent=props.getProperty("game.config.agent");
        long timestamp=System.currentTimeMillis();
        String key=Encrypt.MD5(agent+timestamp+ props.getProperty("game.config.md5key"));
        //获取param
        String orderid=agent+ DateUtil.getDayshms();
        String  params=String.format( "s=7&account=%s",account);
        String param=Encrypt.AESEncrypt(params,props.getProperty("game.config.deskey"));
        String url =String.format( props.getProperty("game.config.api"), agent,timestamp,param ,key);
        return gameRequest(url,  new TypeReference<GameRsp<Object>>() {});
    }




//    @SuppressWarnings("unchecked")
//    @Override
//    public GameRsp<Object> searchBalance(String account) throws Exception {
//         long timestamp=System.currentTimeMillis();
//        String key=Encrypt.MD5(systemConfig.getGAME_AGENT()+timestamp+ systemConfig.getGAME_MD5KEY());
//        //获取param
//        String  params=String.format( "s=1&account=%s",account);
//        String param=Encrypt.AESEncrypt(params,systemConfig.getGAME_DESKEY());
//        String url =String.format( systemConfig.getGAME_API(), systemConfig.getGAME_AGENT(),timestamp,param ,key);
//        return gameRequest(url,  new TypeReference<GameRsp<Object>>() {});
//    }

    @SuppressWarnings("unchecked")
    @Override
    public GameRsp<Object> gamesAllBalance(String account) throws Exception {
        long timestamp=System.currentTimeMillis();
        String key=Encrypt.MD5(systemConfig.getGAME_AGENT()+timestamp+ systemConfig.getGAME_MD5KEY());
        //获取param
        String  params=String.format( "s=7&account=%s",account);
        String param=Encrypt.AESEncrypt(params,systemConfig.getGAME_DESKEY());
        String url =String.format( systemConfig.getGAME_API(), systemConfig.getGAME_AGENT(),timestamp,param ,key);
        return gameRequest(url,  new TypeReference<GameRsp<Object>>() {});
    }

    @SuppressWarnings("unchecked")
    @Override
    public GameRsp<Object> upScore(String account, String money,String orderid) throws Exception {
        long timestamp=System.currentTimeMillis();
        String key=Encrypt.MD5(systemConfig.getGAME_AGENT()+timestamp+ systemConfig.getGAME_MD5KEY());
        //获取param
        String  params=String.format( "s=2&account=%s&money=%s&orderid=%s",account,money,orderid);
        String param=Encrypt.AESEncrypt(params,systemConfig.getGAME_DESKEY());
        String url =String.format( systemConfig.getGAME_API(), systemConfig.getGAME_AGENT(),timestamp,param ,key);
        return gameRequest(url,  new TypeReference<GameRsp<Object>>() {});
    }

    @SuppressWarnings("unchecked")
    @Override
    public GameRsp<Object> downScore(String account, String money,String orderid) throws Exception {
        long timestamp=System.currentTimeMillis();
        String key=Encrypt.MD5(systemConfig.getGAME_AGENT()+timestamp+ systemConfig.getGAME_MD5KEY());
        //获取param
        String  params=String.format( "s=3&account=%s&money=%s&orderid=%s",account,money,orderid);
        String param=Encrypt.AESEncrypt(params,systemConfig.getGAME_DESKEY());
        String url =String.format( systemConfig.getGAME_API(), systemConfig.getGAME_AGENT(),timestamp,param ,key);
        return gameRequest(url,  new TypeReference<GameRsp<Object>>() {});
    }

    @SuppressWarnings("unchecked")
    @Override
    public GameRsp<Object> searchOrder(String orderid) throws Exception {
        long timestamp=System.currentTimeMillis();
        String key=Encrypt.MD5(systemConfig.getGAME_AGENT()+timestamp+ systemConfig.getGAME_MD5KEY());
        //获取param
        String  params=String.format( "s=4&orderid=%s", orderid );
        String param=Encrypt.AESEncrypt(params,systemConfig.getGAME_DESKEY());
        String url =String.format( systemConfig.getGAME_API(), systemConfig.getGAME_AGENT(),timestamp,param ,key);
        return gameRequest(url,  new TypeReference<GameRsp<Object>>() {});
    }



//    @SuppressWarnings("unchecked")
//    @Override
//    public GameRsp<Object> isLogin(String account) throws Exception {
//        String agent=systemConfig.getGAME_AGENT();
//        long timestamp=System.currentTimeMillis();
//        String key=Encrypt.MD5(systemConfig.getGAME_AGENT()+timestamp+ systemConfig.getGAME_MD5KEY());
//        //获取param
//        String  params=String.format( "s=5&account=%s",account);
//        String param=Encrypt.AESEncrypt(params,systemConfig.getGAME_DESKEY());
//        String url =String.format( systemConfig.getGAME_API(), agent,timestamp,param ,key);
//        return gameRequest(url,  new TypeReference<GameRsp<Object>>() {});
//    }

    @Override
    public GameRsp<Object> getGameList(long starttime, long endtime) throws Exception {
//        String api_url="https://exp.ky508.com:190/getRecordHandle?agent=%s&timestamp=%s&param=%s&key=%s";
        String api_url= systemConfig.getGAME_API();
        String agent=systemConfig.getGAME_AGENT();
        long timestamp=System.currentTimeMillis();
        String key=Encrypt.MD5(systemConfig.getGAME_AGENT()+timestamp+ systemConfig.getGAME_MD5KEY());
        //获取param
        String  params=String.format( "s=6&startTime=%s&endTime=",starttime,endtime);
        String param=Encrypt.AESEncrypt(params,systemConfig.getGAME_DESKEY());
        String url =String.format( api_url , agent,timestamp,param ,key);
        return gameRequest(url,  new TypeReference<GameRsp<Object>>() {});
    }




    private <R> GameRsp<R> gameRequest(String url,  TypeReference<GameRsp<R>> valueTypeRef) throws IOException {
//        System.out.println("url="+url);
        String response = HttpClientUtil.get(url);
        return serializer.fromJson(response, valueTypeRef);
    }



}
