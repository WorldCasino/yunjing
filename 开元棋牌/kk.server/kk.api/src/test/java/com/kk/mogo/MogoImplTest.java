package com.kk.mogo;

import com.kk.SpringTestBase;
import com.kk.commons.utils.PropertyConfigurer;
import org.apache.log4j.LogManager;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.io.InputStream;
import java.util.Properties;

import static org.junit.Assert.assertNotNull;

/**
 * Created by Administrator on 2017/8/3.
 * Description: *_*
 */
public class MogoImplTest extends SpringTestBase {
    private static final org.apache.log4j.Logger GAMES = LogManager.getLogger("kkgames");

    /**
     * 从mogo获取游戏记录
     * @throws Exception
     */
    @Test
    public void findList() throws Exception {
        try{


        }catch (Exception e){
            e.printStackTrace();
        }
    }


    /**
     * 获取配置文件的信息
     * @throws Exception
     */
    @Test
    public void props() throws Exception {
        try{

            InputStream in = PropertyConfigurer.class.getClassLoader().getResourceAsStream("environment/env-product.properties");
            Properties props=new Properties();
            props.load(in);

            System.out.println(props.getProperty("game.config.agent"));
            System.out.println(props.getProperty("game.config.deskey"));
            System.out.println(props.getProperty("game.config.md5key"));
            System.out.println(props.getProperty("game.config.api"));

        }catch (Exception e){
            e.printStackTrace();
        }
    }




}