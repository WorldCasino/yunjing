package com.agdress.bgapi.rsp;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * Created by Administrator on 2017/8/1.
 * Description: *_*
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class Error {

    private String code;
    private String sn;
    private String message;
    private String reason;
    private String action;

    public String getCode() {
        return code;
    }

    public String getSn() {
        return sn;
    }

    public String getMessage() {
        return message;
    }

    public String getReason() {
        return reason;
    }

    public String getAction() {
        return action;
    }
}
