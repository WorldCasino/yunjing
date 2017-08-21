package com.agdress.entity;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;

import java.util.Date;

/**
 * Created by Administrator on 2017/8/14.
 * Description: *_*
 */
@TableName(value = "t_game_data")
public class GameDataEntity extends BaseEntity {
    @TableId(type = IdType.AUTO, value = "id")
    private long id;

    @TableField(value = "user_id")
    private long userId;

    @TableField(value = "bg_order_id")
    private long orderId;

    @TableField(value = "bg_tran_id")
    private long tranId;

    @TableField(value = "bg_uid")
    private long uid;

    @TableField(value = "bg_login_id")
    private String loginId;

    @TableField(value = "bg_module_id")
    private long moduleId;

    @TableField(value = "bg_module_name")
    private String moduleName;

    @TableField(value = "bg_game_id")
    private long gameId;

    @TableField(value = "bg_game_name")
    private String gameName;

    @TableField(value = "bg_order_status")
    private int orderStatus;

    @TableField(value = "bg_a_amount")
    private long aAmount;

    @TableField(value = "bg_b_amount")
    private long bAmount;

    @TableField(value = "bg_order_time")
    private Date orderTime;

    @TableField(value = "bg_last_update_time")
    private Date lastUpdateTime;

    @TableField(value = "bg_from_ip")
    private String fromIp;

    @TableField(value = "bg_from_ip_addr")
    private String fromIpAddr;

    @TableField(value = "bg_issue_id")
    private String issueId;

    @TableField(value = "bg_play_id")
    private String playId;

    public long getId() {
        return id;
    }

    public long getUserId() {
        return userId;
    }

    public long getOrderId() {
        return orderId;
    }

    public long getTranId() {
        return tranId;
    }

    public long getUid() {
        return uid;
    }

    public String getLoginId() {
        return loginId;
    }

    public long getModuleId() {
        return moduleId;
    }

    public String getModuleName() {
        return moduleName;
    }

    public long getGameId() {
        return gameId;
    }

    public String getGameName() {
        return gameName;
    }

    public int getOrderStatus() {
        return orderStatus;
    }

    public long getaAmount() {
        return aAmount;
    }

    public long getbAmount() {
        return bAmount;
    }

    public Date getOrderTime() {
        return orderTime;
    }

    public Date getLastUpdateTime() {
        return lastUpdateTime;
    }

    public String getFromIp() {
        return fromIp;
    }

    public String getFromIpAddr() {
        return fromIpAddr;
    }

    public String getIssueId() {
        return issueId;
    }

    public String getPlayId() {
        return playId;
    }
}
