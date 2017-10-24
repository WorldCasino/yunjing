package com.kk.entity;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;

import java.sql.Timestamp;

/**
 * 系统配置项
 * Created by Administrator on 2017/7/18.
 */
@TableName(value = "sys_config")
public class SysConfigEntity extends BaseEntity {

    @TableId(type = IdType.AUTO, value = "id")
    private Long id;

    @TableField(value = "data_kind")
    private int dataKind;

    @TableField(value = "data_value")
    private String dataValue;

    @TableField(value = "str_col1")
    private String strCol1;

    @TableField(value = "str_col2")
    private String strCol2;

    @TableField(value = "int_col1")
    private int intCol1;

    @TableField(value = "int_col2")
    private int intCol2;

    @TableField(value = "start_time")
    private Timestamp startTime;

    @TableField(value = "end_time")
    private Timestamp endTime;

    @TableField(value = "remarks")
    private String remarks;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public int getDataKind() {
        return dataKind;
    }

    public void setDataKind(int dataKind) {
        this.dataKind = dataKind;
    }

    public String getDataValue() {
        return dataValue;
    }

    public void setDataValue(String dataValue) {
        this.dataValue = dataValue;
    }

    public String getStrCol1() {
        return strCol1;
    }

    public void setStrCol1(String strCol1) {
        this.strCol1 = strCol1;
    }

    public String getStrCol2() {
        return strCol2;
    }

    public void setStrCol2(String strCol2) {
        this.strCol2 = strCol2;
    }

    public int getIntCol1() {
        return intCol1;
    }

    public void setIntCol1(int intCol1) {
        this.intCol1 = intCol1;
    }

    public int getIntCol2() {
        return intCol2;
    }

    public void setIntCol2(int intCol2) {
        this.intCol2 = intCol2;
    }

    public Timestamp getStartTime() {
        return startTime;
    }

    public void setStartTime(Timestamp startTime) {
        this.startTime = startTime;
    }

    public Timestamp getEndTime() {
        return endTime;
    }

    public void setEndTime(Timestamp endTime) {
        this.endTime = endTime;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }
}
