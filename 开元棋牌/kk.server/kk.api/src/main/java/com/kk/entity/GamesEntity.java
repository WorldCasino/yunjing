package com.kk.entity;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;

import java.util.Date;
import java.util.List;


/**
 * 开元的游戏记录数据实体
 * Created by Administrator on 2017/8/1.
 * Description: *_*
 */
@TableName("t_games")
public class GamesEntity extends BaseEntity {

    @TableId(type = IdType.AUTO, value = "only_id")
    private Long onlyId;

    @TableField(value = "game_id")
    private String gameID; // 游戏局号列表

    @TableField(value = "accounts")
    private String accounts ; // 玩家帐号列表

    @TableField(value = "server_id")
    private String serverID ; // 房间 ID 列表

    @TableField(value = "kind_id")
    private String  kindID ; // 游戏 ID 列表

    @TableField(value = "table_id")
    private String tableID ; // 桌子号列表

    @TableField(value = "chair_id")
    private String chairID ; // 椅子号列表

    @TableField(value = "user_count")
    private String userCount ; // 玩家数量列表

    @TableField(value = "card_value")
    private String cardValue ; // 手牌公共牌

    @TableField(value = "cell_score")
    private String  cellScore ; // 有效下注

    @TableField(value = "all_bet")
    private String allBet ; // 总下注列表

    @TableField(value = "profit")
    private String profit ; // 盈利列表

    @TableField(value = "revenue")
    private String  revenue ; // 抽水列表

    @TableField(value = "game_start_time")
    private Date gameStartTime ; // 游戏开始时间列表

    @TableField(value = "game_end_time")
    private Date gameEndTime ; // 游戏结束时间列表

    @TableField(value = "channel_id")
    private String  channelID ; // 渠道 ID 列表


    public Long getOnlyId() {
        return onlyId;
    }

    public void setOnlyId(Long onlyId) {
        this.onlyId = onlyId;
    }

    public String getGameID() {
        return gameID;
    }

    public void setGameID(String gameID) {
        this.gameID = gameID;
    }

    public String getAccounts() {
        return accounts;
    }

    public void setAccounts(String accounts) {
        this.accounts = accounts;
    }

    public String getServerID() {
        return serverID;
    }

    public void setServerID(String serverID) {
        this.serverID = serverID;
    }

    public String getKindID() {
        return kindID;
    }

    public void setKindID(String kindID) {
        this.kindID = kindID;
    }

    public String getTableID() {
        return tableID;
    }

    public void setTableID(String tableID) {
        this.tableID = tableID;
    }

    public String getChairID() {
        return chairID;
    }

    public void setChairID(String chairID) {
        this.chairID = chairID;
    }

    public String getUserCount() {
        return userCount;
    }

    public void setUserCount(String userCount) {
        this.userCount = userCount;
    }

    public String getCardValue() {
        return cardValue;
    }

    public void setCardValue(String cardValue) {
        this.cardValue = cardValue;
    }

    public String getCellScore() {
        return cellScore;
    }

    public void setCellScore(String cellScore) {
        this.cellScore = cellScore;
    }

    public String getAllBet() {
        return allBet;
    }

    public void setAllBet(String allBet) {
        this.allBet = allBet;
    }

    public String getProfit() {
        return profit;
    }

    public void setProfit(String profit) {
        this.profit = profit;
    }

    public String getRevenue() {
        return revenue;
    }

    public void setRevenue(String revenue) {
        this.revenue = revenue;
    }

    public Date getGameStartTime() {
        return gameStartTime;
    }

    public void setGameStartTime(Date gameStartTime) {
        this.gameStartTime = gameStartTime;
    }

    public Date getGameEndTime() {
        return gameEndTime;
    }

    public void setGameEndTime(Date gameEndTime) {
        this.gameEndTime = gameEndTime;
    }

    public String getChannelID() {
        return channelID;
    }

    public void setChannelID(String channelID) {
        this.channelID = channelID;
    }

    @Override
    public String toString() {
        return "GamesEntity{" +
                "onlyId=" + onlyId +
                ", gameID='" + gameID + '\'' +
                ", accounts='" + accounts + '\'' +
                ", serverID='" + serverID + '\'' +
                ", kindID='" + kindID + '\'' +
                ", tableID='" + tableID + '\'' +
                ", chairID='" + chairID + '\'' +
                ", userCount='" + userCount + '\'' +
                ", cardValue='" + cardValue + '\'' +
                ", cellScore='" + cellScore + '\'' +
                ", allBet='" + allBet + '\'' +
                ", profit='" + profit + '\'' +
                ", revenue='" + revenue + '\'' +
                ", gameStartTime=" + gameStartTime +
                ", gameEndTime=" + gameEndTime +
                ", channelID='" + channelID + '\'' +
                '}';
    }
}

