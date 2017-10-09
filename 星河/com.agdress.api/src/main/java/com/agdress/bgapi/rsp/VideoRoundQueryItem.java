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
    private String gameName;
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

    public void setStatus(int status) {
        this.status = status;
    }

    public int getGameType() {
        return gameType;
    }

    public void setGameType(int gameType) {
        this.gameType = gameType;
    }

    public String getGameName() {
        return gameName;
    }

    public void setGameName(String gameName) {
        this.gameName = gameName;
    }

    public int getDealerId() {
        return dealerId;
    }

    public void setDealerId(int dealerId) {
        this.dealerId = dealerId;
    }

    public String getDealer() {
        return dealer;
    }

    public void setDealer(String dealer) {
        this.dealer = dealer;
    }

    public String getSerialNo() {
        return serialNo;
    }

    public void setSerialNo(String serialNo) {
        this.serialNo = serialNo;
    }

    public String getTableId() {
        return tableId;
    }

    public void setTableId(String tableId) {
        this.tableId = tableId;
    }

    public String getBaccarat() {
        return baccarat;
    }

    public void setBaccarat(String baccarat) {
        this.baccarat = baccarat;
    }

    public String getBaccarat64() {
        return baccarat64;
    }

    public void setBaccarat64(String baccarat64) {
        this.baccarat64 = baccarat64;
    }

    public String getBetResult() {
        return betResult;
    }

    public void setBetResult(String betResult) {
        this.betResult = betResult;
    }

    public String getResult() {
        return result;
    }

    public void setResult(String result) {
        this.result = result;
    }

    public int getBettings() {
        return bettings;
    }

    public void setBettings(int bettings) {
        this.bettings = bettings;
    }

    public float getBetAmount() {
        return betAmount;
    }

    public void setBetAmount(float betAmount) {
        this.betAmount = betAmount;
    }

    public float getPayoutAmount() {
        return payoutAmount;
    }

    public void setPayoutAmount(float payoutAmount) {
        this.payoutAmount = payoutAmount;
    }

    public Date getOpenTime() {
        return openTime;
    }

    public void setOpenTime(Date openTime) {
        this.openTime = openTime;
    }

    public Date getCalcTime() {
        return calcTime;
    }

    public void setCalcTime(Date calcTime) {
        this.calcTime = calcTime;
    }

    @Override
    public String toString() {
        return "VideoRoundQueryItem{" +
                "status=" + status +
                ", gameType=" + gameType +
                ", gameName='" + gameName + '\'' +
                ", dealerId=" + dealerId +
                ", dealer='" + dealer + '\'' +
                ", serialNo='" + serialNo + '\'' +
                ", tableId='" + tableId + '\'' +
                ", baccarat=" + String.valueOf(baccarat) +
                ", baccarat64='" + baccarat64 + '\'' +
                ", betResult=" + String.valueOf(betResult) +
                ", result=" +  String.valueOf(result) +
                ", bettings=" + bettings +
                ", betAmount=" + betAmount +
                ", payoutAmount=" + payoutAmount +
                ", openTime=" + openTime +
                ", calcTime=" + calcTime +
                '}';
    }
}
