package com.agdress.redis;

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

    private JedisPool jedisPool;

    @Autowired
    public RedisHelper(JedisPool jedisPool){
        this.jedisPool = jedisPool;
    }

    public JedisPool getJedisPool(){
        return this.jedisPool;
    }

    public Jedis getResource(){
        return this.jedisPool.getResource();
    }

}
