package com.kk.kygame;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.fasterxml.jackson.core.type.TypeReference;
import com.kk.SpringTestBase;
import com.kk.commons.utils.*;
import com.kk.enums.KindIdEnum;
import com.kk.kygame.dentity.DBack;
import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import static org.junit.Assert.*;

public class GameConnectorImplTest  extends SpringTestBase {

    Logger logger = LoggerFactory.getLogger(GameConnectorImplTest.class);

    @Autowired
    private IGameConnector gameConnector;


    @Autowired
    private JacksonSerializer serializer;
    @Autowired
    private SystemConfig systemConfig;


    /**
     * 测试正式的地址
     * @throws Exception
     */
    @Test
    public void loginByVisitor() throws Exception {
        InputStream in = PropertyConfigurer.class.getClassLoader().getResourceAsStream("environment/env-product.properties");
        Properties props=new Properties();
        props.load(in);
        String agent=props.getProperty("game.config.agent");
        long timestamp=System.currentTimeMillis();
//        System.out.println("生成key的参数："+agent+"+"+timestamp+"+"+ props.getProperty("game.config.md5key"));
        String key=Encrypt.MD5(agent+timestamp+ props.getProperty("game.config.md5key"));
//        System.out.println("Encrypt.MD5后的key："+key);
        //获取param
        String orderid=agent+ DateUtil.getDayshms();
        String  params=String.format( "s=0&account=%s&money=%s&orderid=%s&ip=%s&lineCode=%s&KindID=%s","huhuhu","0",orderid,"192.168.1.48","test",0);//登录
//        String  params=String.format( "s=2&account=%s&money=%s&orderid=%s","小魏","10",orderid);//上分
//        String  params=String.format( "s=3&account=%s&money=%s&orderid=%s","小魏","10",orderid);//下分
//        String  params=String.format( "s=1&account=%s","huhuhu");//余额
//        String  params=String.format( "s=7&account=%s","huhuhu");//游戏总余额
//        System.out.println( "参数："+params);
        String param=Encrypt.AESEncrypt(params,props.getProperty("game.config.deskey"));
//        System.out.println("Encrypt.AESEncrypt加密后："+param);



        String url =String.format( props.getProperty("game.config.api"), agent,timestamp,param ,key);

        System.out.println("链接地址："+url);

        GameRsp<Object> gameRsp= gameRequest(url,  new TypeReference<GameRsp<Object>>() {});
        System.out.println("返回结果"+gameRsp.toString());
        String dsr=JSONObject.toJSONString(gameRsp.getD());
        DBack dBack= JSON.parseObject(dsr, DBack.class);
        if(dBack.getCode() == 0){
            url=dBack.getUrl();
            System.out.println(url);
//            String ps=HttpClientUtil.get(url);//调用地址
//            System.out.println("返回=="+ps);
        }
    }

    private <R> GameRsp<R> gameRequest(String url,  TypeReference<GameRsp<R>> valueTypeRef) throws IOException {
//        System.out.println("url="+url);
        String response = HttpClientUtil.get(url);
        return serializer.fromJson(response, valueTypeRef);
    }




    @Test
    public void login() throws Exception {
        GameRsp<Object> gameRsp= gameConnector.login("阳光大佬2","0", "192.168.1.48","test",0);
        System.out.println(gameRsp.toString());
        String dsr=JSONObject.toJSONString(gameRsp.getD());
        System.out.println(dsr);
        DBack dBack= JSON.parseObject(dsr, DBack.class);
        if(dBack.getCode() == 0){
            String url=dBack.getUrl();
            System.out.println(dBack.getCode()+"====="+url);
//            String ps=HttpClientUtil.get(url);//调用地址
//            System.out.println("返回=="+ps);
        }
    }

    @Test
    public void searchBalance() throws Exception {
//        GameRsp<Object> gameRsp= gameConnector.searchBalance("阳光大佬2");
//        System.out.println(gameRsp.toString());
//        String dsr=JSONObject.toJSONString(gameRsp.getD());
//        System.out.println(dsr);
//        DBack dBack= JSON.parseObject(dsr, DBack.class);
//        if(dBack.getCode() == 0){
//            System.out.println(dBack.getCode()+"====="+dBack.getMoney());
//        }
    }

    @Test
    public void upScore() throws Exception {
        GameRsp<Object> gameRsp= gameConnector.upScore("123456","100",systemConfig.getGAME_AGENT()+ DateUtil.getDayshms());
        System.out.println(gameRsp.toString());
        String dsr=JSONObject.toJSONString(gameRsp.getD());
        System.out.println(dsr);
        DBack dBack= JSON.parseObject(dsr, DBack.class);
        if(dBack.getCode() == 0){
            System.out.println(dBack.getCode());
        }
    }

    @Test
    public void downScore() throws Exception {
        GameRsp<Object> gameRsp= gameConnector.downScore("阳光大佬2","50",systemConfig.getGAME_AGENT()+ DateUtil.getDayshms());
        System.out.println(gameRsp.toString());
        String dsr=JSONObject.toJSONString(gameRsp.getD());
        System.out.println(dsr);
        DBack dBack= JSON.parseObject(dsr, DBack.class);
        if(dBack.getCode() == 0){
            System.out.println(dBack.getCode());
        }
    }

    @Test
    public void searchOrder() throws Exception {

    }

//    @Test
//    public void isLogin() throws Exception {
//        GameRsp<Object> gameRsp= gameConnector.isLogin("我是测试8");
//        System.out.println(gameRsp.toString());
//        String dsr=JSONObject.toJSONString(gameRsp.getD());
//        System.out.println(dsr);
//        DBack dBack= JSON.parseObject(dsr, DBack.class);
//        if(dBack.getCode() == 0){
//            System.out.println(dBack.getCode()+"===="+dBack.getStatus());
//        }
//    }


    @Test
    public void getGameList() throws Exception {

        GameRsp<Object> gameRsp= gameConnector.getGameList(DateUtil.fomatDate1("2017-10-23 13:47:00").getTime(),DateUtil.fomatDate1("2017-10-23 13:48:00").getTime());
        System.out.println(gameRsp.toString());
    }


}