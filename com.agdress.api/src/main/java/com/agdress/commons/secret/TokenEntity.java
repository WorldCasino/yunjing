package com.agdress.commons.secret;

import io.jsonwebtoken.Claims;
import org.apache.commons.net.ntp.TimeStamp;

import java.io.Serializable;
import java.util.Date;

/**
 * Created by Administrator on 2017/8/11.
 */
public class TokenEntity implements Serializable {
    private long userId;
    private long bgUserId;
    private String bgLoginId;
    private long expiration;

    private String token;

    public TokenEntity(String token,Claims claims){
        this.token = token;

        this.userId = Long.parseLong(claims.getId());
        this.bgUserId = Long.parseLong(claims.getAudience());
        this.bgLoginId = claims.getSubject();
        this.expiration = claims.getExpiration().getTime();
    }

    public long getUserId() {
        return userId;
    }

    public void setUserId(long userId) {
        this.userId = userId;
    }

    public long getBgUserId() {
        return bgUserId;
    }

    public void setBgUserId(long bgUserId) {
        this.bgUserId = bgUserId;
    }

    public String getBgLoginId() {
        return bgLoginId;
    }

    public void setBgLoginId(String bgLoginId) {
        this.bgLoginId = bgLoginId;
    }

    public long getExpiration() {
        return expiration;
    }

    public void setExpiration(long expiration) {
        this.expiration = expiration;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }
}
