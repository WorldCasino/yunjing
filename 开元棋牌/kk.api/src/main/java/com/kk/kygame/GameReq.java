package com.kk.kygame;

/**
 * 请求数据
 * Created by Administrator on 2017/8/1.
 * Description: *_*
 */
public class GameReq<T> {

    private String  agent ;//代理编号（平台提供）
    private String  timestamp ;//时间戳,获取当前时间
    private String params;
    private String key;//Encrypt.MD5(agent+timestamp+ MD5Key);

    public GameReq(String agent, String timestamp, String params, String key) {
        this.agent = agent;
        this.timestamp = timestamp;
        this.params = params;
        this.key = key;
    }

    public String getAgent() {
        return agent;
    }

    public void setAgent(String agent) {
        this.agent = agent;
    }

    public String getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(String timestamp) {
        this.timestamp = timestamp;
    }

    public String getParams() {
        return params;
    }

    public void setParams(String params) {
        this.params = params;
    }

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }
}
