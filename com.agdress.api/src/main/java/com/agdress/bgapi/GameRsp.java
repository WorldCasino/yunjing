package com.agdress.bgapi;

import com.agdress.bgapi.rsp.Request;
import com.agdress.bgapi.rsp.Error;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * Created by Administrator on 2017/8/1.
 * Description: *_*
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class GameRsp<T> {

    private String id;
    private T result;
    private Error error;
    private Request request;
    private String jsonrpc;

    public String getId() {
        return id;
    }

    public T getResult() {
        return result;
    }

    public Error getError() {
        return error;
    }

    public Request getDetail() {
        return request;
    }

    public String getJsonrpc() {
        return jsonrpc;
    }
}
