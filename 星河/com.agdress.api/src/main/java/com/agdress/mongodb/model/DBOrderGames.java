package com.agdress.mongodb.model;

import com.agdress.enums.GamesIdEnum;
import com.agdress.enums.GamesStatusEnum;
import com.agdress.enums.GamesVideoStatusEnum;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonUnwrapped;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.io.Serializable;
import java.util.Date;

/**
 * Created by Administrator on 2017/8/2.
 * Description: *_*
 */
@Document(collection = "games")
@JsonIgnoreProperties(ignoreUnknown = true)
public class DBOrderGames implements Serializable {

    @Id
    private Long orderId;//订单ID

    private Long tranId;
    private String sn;
    private Long uid;//用户ID
    private String loginId;//用户登录ID-查代理商ID
    private String agentId;//代理商ID
    private String agentNumber;
    private String agentName;
    private String bgAgentId;
    private Integer moduleId;
    private String moduleName;

    private GamesIdEnum gameId;
    private Integer showGameId;

    private String gameName;//游戏类型

    private GamesStatusEnum orderStatus;//订单状态
    private Integer showOrderStatus;

    private Float bAmount;//有效投注
    private Float aAmount;//有效输赢
    private Float zmAmount;//转码统计

    private Integer orderForm;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date orderTime;//下单时间
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date lastUpdateTime;
    private String fromIp;//下单用户Ip
    private String fromIpAddr;
    private String issueId;//游戏局号
    private String playId;

    private Date starttime;//开始时间
    private Date endtime;//结束时间

    //游戏数据
    private GamesVideoStatusEnum gamesVideoStatusEnum;
    private GamesIdEnum gameType;
    private Integer dealerId;
    private String dealer;
    private String serialNo;
    private String tableId;//桌号
    private String baccarat;
    private String baccarat64;
    private String baccarat64_back;
    private String betResult;
    private String result;//发牌结果

    private String resultContent;//游戏结果用来展示
    private String licensingInfor;//发牌资料

    private Integer bettings;
    private Float betAmount;
    private Float payoutAmount;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date openTime;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date calcTime;

    private Double atotal;//赢输统计

    private Double btotal;//下注额

    private Double zmtotal;//转码总量

    public String getAgentName() {
        return agentName;
    }

    public void setAgentName(String agentName) {
        this.agentName = agentName;
    }

    public String getBgAgentId() {
        return bgAgentId;
    }

    public void setBgAgentId(String bgAgentId) {
        this.bgAgentId = bgAgentId;
    }

    public String getAgentNumber() {
        return agentNumber;
    }

    public void setAgentNumber(String agentNumber) {
        this.agentNumber = agentNumber;
    }

    public String getResultContent() {
        return resultContent;
    }

    public void setResultContent(String resultContent) {
        this.resultContent = resultContent;
    }

    public String getLicensingInfor() {
        return licensingInfor;
    }

    public void setLicensingInfor(String licensingInfor) {
        this.licensingInfor = licensingInfor;
    }

    public String getBaccarat64_back() {
        return baccarat64_back;
    }

    public void setBaccarat64_back(String baccarat64_back) {
        this.baccarat64_back = baccarat64_back;
    }

    public Float getZmAmount() {
        return zmAmount;
    }

    public void setZmAmount(Float zmAmount) {
        this.zmAmount = zmAmount;
    }

    public Double getZmtotal() {
        return zmtotal;
    }

    public void setZmtotal(Double zmtotal) {
        this.zmtotal = zmtotal;
    }

    public Integer getShowGameId() {
        return showGameId;
    }

    public void setShowGameId(Integer showGameId) {
        this.showGameId = showGameId;
    }

    public Integer getShowOrderStatus() {
        return showOrderStatus;
    }

    public void setShowOrderStatus(Integer showOrderStatus) {
        this.showOrderStatus = showOrderStatus;
    }

    public Double getAtotal() {
        return atotal;
    }

    public void setAtotal(Double atotal) {
        this.atotal = atotal;
    }

    public Double getBtotal() {
        return btotal;
    }

    public void setBtotal(Double btotal) {
        this.btotal = btotal;
    }

    public Date getStarttime() {
        return starttime;
    }

    public void setStarttime(Date starttime) {
        this.starttime = starttime;
    }

    public Date getEndtime() {
        return endtime;
    }

    public void setEndtime(Date endtime) {
        this.endtime = endtime;
    }

    public Long getOrderId() {
        return orderId;
    }

    public void setOrderId(Long orderId) {
        this.orderId = orderId;
    }

    public Long getTranId() {
        return tranId;
    }

    public void setTranId(Long tranId) {
        this.tranId = tranId;
    }

    public String getSn() {
        return sn;
    }

    public void setSn(String sn) {
        this.sn = sn;
    }

    public Long getUid() {
        return uid;
    }

    public void setUid(Long uid) {
        this.uid = uid;
    }

    public String getLoginId() {
        return loginId;
    }

    public void setLoginId(String loginId) {
        this.loginId = loginId;
    }

    public String getAgentId() {
        return agentId;
    }

    public void setAgentId(String agentId) {
        this.agentId = agentId;
    }

    public Integer getModuleId() {
        return moduleId;
    }

    public void setModuleId(Integer moduleId) {
        this.moduleId = moduleId;
    }

    public String getModuleName() {
        return moduleName;
    }

    public void setModuleName(String moduleName) {
        this.moduleName = moduleName;
    }

    public GamesIdEnum getGameId() {
        return gameId;
    }

    public void setGameId(GamesIdEnum gameId) {
        this.gameId = gameId;
    }

    public String getGameName() {
        return gameName;
    }

    public void setGameName(String gameName) {
        this.gameName = gameName;
    }

    public GamesStatusEnum getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(GamesStatusEnum orderStatus) {
        this.orderStatus = orderStatus;
    }

    public Float getbAmount() {
        return bAmount;
    }

    public void setbAmount(Float bAmount) {
        this.bAmount = bAmount;
    }

    public Float getaAmount() {
        return aAmount;
    }

    public void setaAmount(Float aAmount) {
        this.aAmount = aAmount;
    }

    public Integer getOrderForm() {
        return orderForm;
    }

    public void setOrderForm(Integer orderForm) {
        this.orderForm = orderForm;
    }

    public Date getOrderTime() {
        return orderTime;
    }

    public void setOrderTime(Date orderTime) {
        this.orderTime = orderTime;
    }

    public Date getLastUpdateTime() {
        return lastUpdateTime;
    }

    public void setLastUpdateTime(Date lastUpdateTime) {
        this.lastUpdateTime = lastUpdateTime;
    }

    public String getFromIp() {
        return fromIp;
    }

    public void setFromIp(String fromIp) {
        this.fromIp = fromIp;
    }

    public String getFromIpAddr() {
        return fromIpAddr;
    }

    public void setFromIpAddr(String fromIpAddr) {
        this.fromIpAddr = fromIpAddr;
    }

    public String getIssueId() {
        return issueId;
    }

    public void setIssueId(String issueId) {
        this.issueId = issueId;
    }

    public String getPlayId() {
        return playId;
    }

    public void setPlayId(String playId) {
        this.playId = playId;
    }

    public GamesVideoStatusEnum getGamesVideoStatusEnum() {
        return gamesVideoStatusEnum;
    }

    public void setGamesVideoStatusEnum(GamesVideoStatusEnum gamesVideoStatusEnum) {
        this.gamesVideoStatusEnum = gamesVideoStatusEnum;
    }

    public GamesIdEnum getGameType() {
        return gameType;
    }

    public void setGameType(GamesIdEnum gameType) {
        this.gameType = gameType;
    }

    public Integer getDealerId() {
        return dealerId;
    }

    public void setDealerId(Integer dealerId) {
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

    public Integer getBettings() {
        return bettings;
    }

    public void setBettings(Integer bettings) {
        this.bettings = bettings;
    }

    public Float getBetAmount() {
        return betAmount;
    }

    public void setBetAmount(Float betAmount) {
        this.betAmount = betAmount;
    }

    public Float getPayoutAmount() {
        return payoutAmount;
    }

    public void setPayoutAmount(Float payoutAmount) {
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
        return "DBOrderGames{" +
                "orderId=" + orderId +
                ", tranId=" + tranId +
                ", sn='" + sn + '\'' +
                ", uid=" + uid +
                ", loginId='" + loginId + '\'' +
                ", agentId='" + agentId + '\'' +
                ", moduleId=" + moduleId +
                ", moduleName='" + moduleName + '\'' +
                ", gameId=" + gameId +
                ", gameName='" + gameName + '\'' +
                ", orderStatus=" + orderStatus +
                ", bAmount=" + bAmount +
                ", aAmount=" + aAmount +
                ", orderForm=" + orderForm +
                ", orderTime=" + orderTime +
                ", lastUpdateTime=" + lastUpdateTime +
                ", fromIp='" + fromIp + '\'' +
                ", fromIpAddr='" + fromIpAddr + '\'' +
                ", issueId='" + issueId + '\'' +
                ", playId='" + playId + '\'' +
                ", gamesVideoStatusEnum=" + gamesVideoStatusEnum +
                ", gameType=" + gameType +
                ", dealerId=" + dealerId +
                ", dealer='" + dealer + '\'' +
                ", serialNo='" + serialNo + '\'' +
                ", tableId='" + tableId + '\'' +
                ", baccarat='" + baccarat + '\'' +
                ", baccarat64='" + baccarat64 + '\'' +
                ", betResult='" + betResult + '\'' +
                ", result='" + result + '\'' +
                ", bettings=" + bettings +
                ", betAmount=" + betAmount +
                ", payoutAmount=" + payoutAmount +
                ", openTime=" + openTime +
                ", calcTime=" + calcTime +
                '}';
    }
}
