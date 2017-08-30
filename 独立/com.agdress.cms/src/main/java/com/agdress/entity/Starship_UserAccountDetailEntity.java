package com.agdress.entity;


import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.annotations.Version;
import com.baomidou.mybatisplus.enums.IdType;

import java.sql.Timestamp;


/**
 * 用户财富实体
 */
@TableName(value = "t_user_account_detail")
public class Starship_UserAccountDetailEntity {

    @TableId(type = IdType.AUTO,value = "trade_id")
    private Long trade_id;

    private Long user_id;

    private Long trade_status;

    private Long is_notification;

    @Version
    private Long version_no;

    private Long create_by;

    private Timestamp create_date;

    private Long update_by;

    private Timestamp update_date;

    private Integer is_delete;


    public Long getIs_notification() {
        return is_notification;
    }

    public void setIs_notification(Long is_notification) {
        this.is_notification = is_notification;
    }
    public Long getUser_id() {
        return user_id;
    }

    public void setUser_id(Long user_id) {
        this.user_id = user_id;
    }

    public Long getTrade_id() {
        return trade_id;
    }

    public void setTrade_id(Long trade_id) {
        this.trade_id = trade_id;
    }

    public Long getTrade_status() {
        return trade_status;
    }

    public void setTrade_status(Long trade_status) {
        this.trade_status = trade_status;
    }

    public Long getVersion_no() {
        return version_no;
    }

    public void setVersion_no(Long version_no) {
        this.version_no = version_no;
    }

    public Long getCreate_by() {
        return create_by;
    }

    public void setCreate_by(Long create_by) {
        this.create_by = create_by;
    }

    public Timestamp getCreate_date() {
        return create_date;
    }

    public void setCreate_date(Timestamp create_date) {
        this.create_date = create_date;
    }

    public Long getUpdate_by() {
        return update_by;
    }

    public void setUpdate_by(Long update_by) {
        this.update_by = update_by;
    }

    public Timestamp getUpdate_date() {
        return update_date;
    }

    public void setUpdate_date(Timestamp update_date) {
        this.update_date = update_date;
    }

    public Integer getIs_delete() {
        return is_delete;
    }

    public void setIs_delete(Integer is_delete) {
        this.is_delete = is_delete;
    }
}
