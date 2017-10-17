package com.kk.kygame;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * 返回数据
 * Created by Administrator on 2017/8/1.
 * Description: *_*
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class GameRsp<T> {

    private Integer s;
    private String m;
    private T d;

//    //使用JacksonSerializer不能使用构造方法
//    public GameRsp(Integer s, String m, T d) {
//        this.s = s;
//        this.m = m;
//        this.d = d;
//    }

    public Integer getS() {
        return s;
    }

    public void setS(Integer s) {
        this.s = s;
    }

    public String getM() {
        return m;
    }

    public void setM(String m) {
        this.m = m;
    }

    public T getD() {
        return d;
    }

    public void setD(T d) {
        this.d = d;
    }

    @Override
    public String toString() {
        return "GameRsp{" +
                "s=" + s +
                ", m='" + m + '\'' +
                ", d=" + d +
                '}';
    }
}
