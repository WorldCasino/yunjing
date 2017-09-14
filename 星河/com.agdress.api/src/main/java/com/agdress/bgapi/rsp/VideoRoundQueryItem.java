package com.agdress.bgapi.rsp;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import java.util.Date;

/**
 * Created by Administrator on 2017/8/2.
 * Description: *_*
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class VideoRoundQueryItem {
    private int status;
    private int gameType;
    private int gameName;
    private int dealerId;
    private String dealer;
    private String serialNo;
    private String tableId;
    private String baccarat;
    private String baccarat64;
    private String betResult;
    private String result;
    private int bettings;
    private float betAmount;
    private float payoutAmount;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date openTime;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date calcTime;

    public int getStatus() {
        return status;
    }

    public int getGameType() {
        return gameType;
    }

    public int getGameName() {
        return gameName;
    }

    public int getDealerId() {
        return dealerId;
    }

    public String getDealer() {
        return dealer;
    }

    public String getSerialNo() {
        return serialNo;
    }

    public String getTableId() {
        return tableId;
    }

    public String getBaccarat() {
        return baccarat;
    }

    public String getBaccarat64() {
        return baccarat64;
    }

    public String getBetResult() {
        return betResult;
    }

    public String getResult() {
        return result;
    }

    public int getBettings() {
        return bettings;
    }

    public float getBetAmount() {
        return betAmount;
    }

    public float getPayoutAmount() {
        return payoutAmount;
    }

    public Date getOpenTime() {
        return openTime;
    }

    public Date getCalcTime() {
        return calcTime;
    }
}
