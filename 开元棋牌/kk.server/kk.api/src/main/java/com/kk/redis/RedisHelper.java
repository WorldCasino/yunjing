package com.kk.redis;

import com.kk.commons.utils.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;

/**
 * Redis帮助类
 * Created by Administrator on 2017/8/17.
 */
@Component
public class RedisHelper {
    protected static Logger logger = Logger.getLogger(RedisHelper.class);

    private static JedisPool jedisPool;

    @Autowired
    public RedisHelper(JedisPool jedisPool){
        RedisHelper.jedisPool = jedisPool;
    }
    public static JedisPool getJedisPool(){
        return jedisPool;
    }

    /**
     * 同步获取Jedis实例
     * @return
     */
    public synchronized static Jedis getJedis(){
        Jedis jedis = null;
        try {
            if (jedisPool != null) {
                jedis = jedisPool.getResource();
            }
        } catch (Exception e) {
            logger.error("Get jedis error : "+e);
            returnBrokenResource(jedis);
        }
        return jedis;
    }

    /**
     * 释放jedis资源
     * @param jedis
     */
    public static void returnResource(final Jedis jedis) {
        if (jedis != null && jedisPool !=null) {
            jedisPool.returnResource(jedis);
        }
    }

    /**
     * 释放jedis资源(销毁)
     * @param jedis
     */
    public static void returnBrokenResource(final Jedis jedis) {
        if (jedis != null && jedisPool !=null) {
            jedisPool.returnBrokenResource(jedis);
        }
    }

    /**
     * 设置 String
     * @param key
     * @param value
     */
    public static void setString(String key ,String value){
        Jedis jedis = null;
        try {
            value = StringUtils.isEmpty(value) ? "" : value;
            jedis = getJedis();
            jedis.set(key,value);

        } catch (Exception e) {
            returnBrokenResource(jedis);
            e.printStackTrace();
        } finally {
            returnResource(jedis);
        }
    }

    /**
     * 设置 过期时间
     * @param key
     * @param seconds 以秒为单位
     * @param value
     */
    public static void setString(String key ,int seconds,String value){
        Jedis jedis = null;
        try {
            value = StringUtils.isEmpty(value) ? "" : value;
            jedis = getJedis();
            jedis.setex(key, seconds, value);

        } catch (Exception e) {
            returnBrokenResource(jedis);
            e.printStackTrace();
        } finally {
            returnResource(jedis);
        }
    }

    /**
     * 获取String值
     * @param key
     * @return value
     */
    public static String getString(String key){
        Jedis jedis = null;

        try {
            jedis = getJedis();
            if (jedis == null || !jedis.exists(key)) {
                return null;
            }
            return jedis.get(key);
        }catch (Exception e){
            returnBrokenResource(jedis);
            e.printStackTrace();
        }finally {
            returnResource(jedis);
        }

        return null;
    }

    /**
     * 删除key
     * @param key
     */
    public static void delKey(String key){
        Jedis jedis = null;

        try {
            jedis = getJedis();
            if (jedis == null || !jedis.exists(key)) {
                return;
            }
            jedis.del(key);
        }catch (Exception e){
            returnBrokenResource(jedis);
            e.printStackTrace();
        }finally {
            returnResource(jedis);
        }
    }
}
