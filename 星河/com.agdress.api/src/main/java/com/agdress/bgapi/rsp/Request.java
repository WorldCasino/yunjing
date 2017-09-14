package com.agdress.bgapi.rsp;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * Created by Administrator on 2017/8/1.
 * Description: *_*
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class Request {

    private String cxt;
    private String method;
    private Object params;
    private String uri;
    private String redirectUri;
    private int elapsed;
    private String from;
    private String server;
    private String result;

    public void setCxt(String cxt) {
        this.cxt = cxt;
    }

    public void setMethod(String method) {
        this.method = method;
    }

    public void setParams(Object params) {
        this.params = params;
    }

    public void setUri(String uri) {
        this.uri = uri;
    }

    public void setRedirectUri(String redirectUri) {
        this.redirectUri = redirectUri;
    }

    public void setElapsed(int elapsed) {
        this.elapsed = elapsed;
    }

    public void setFrom(String from) {
        this.from = from;
    }

    public void setServer(String server) {
        this.server = server;
    }

    public void setResult(String result) {
        this.result = result;
    }
}
