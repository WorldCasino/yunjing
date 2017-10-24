package com.kk.commons.secret;

import io.jsonwebtoken.Claims;
import org.apache.commons.net.ntp.TimeStamp;

import java.io.Serializable;
import java.util.Date;

/**
 * Created by Administrator on 2017/8/11.
 */
public class TokenEntity implements Serializable {
    private long userId;
    private long kyAccount;
    private long expiration;

    private String token;

    public TokenEntity(String token,Claims claims){
        this.token = token;

        this.userId = Long.parseLong(claims.getId());
        this.kyAccount = Long.parseLong(claims.getAudience());
        this.expiration = claims.getExpiration().getTime();
    }

    public long getUserId() {
        return userId;
    }

    public void setUserId(long userId) {
        this.userId = userId;
    }

    public long getKyAccount() {
        return kyAccount;
    }

    public void setKyAccount(long kyAccount) {
        this.kyAccount = kyAccount;
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
