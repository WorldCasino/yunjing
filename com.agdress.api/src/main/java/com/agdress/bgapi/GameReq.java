package com.agdress.bgapi;

/**
 * Created by Administrator on 2017/8/1.
 * Description: *_*
 */
public class GameReq<T> {

    private String id;
    private String method;
    private T params;
    private String jsonrpc;

    public GameReq(String id, String method, T params, String jsonrpc) {
        this.id = id;
        this.method = method;
        this.params = params;
        this.jsonrpc = jsonrpc;
    }

    public void setId(String id) {
        this.id = id;
    }

    public void setMethod(String method) {
        this.method = method;
    }

    public void setParams(T params) {
        this.params = params;
    }

    public void setJsonrpc(String jsonrpc) {
        this.jsonrpc = jsonrpc;
    }
}
