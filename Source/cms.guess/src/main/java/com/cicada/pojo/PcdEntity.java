package com.cicada.pojo;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;
import com.cicada.enums.ActiveTypeEnum;

import java.sql.Timestamp;

/**
 * 省市区数据
 * Created by Administrator on 2017/5/25.
 */

@TableName(value = "t_pcd")
public class PcdEntity{

    @TableId(type = IdType.AUTO, value = "code")
    private Long code;

    @TableField(value = "name")
    private String name;

    @TableField(value = "parent_code")
    private Long parentCode;

    @TableField(value = "is_delete")
    private Integer is_delete;

    @TableField(value = "regiondivision_id")
    private String regiondivision_id;

    public Long getCode() {
        return code;
    }

    public void setCode(Long code) {
        this.code = code;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Long getParentCode() {
        return parentCode;
    }

    public void setParentCode(Long parentCode) {
        this.parentCode = parentCode;
    }

    public Integer getIs_delete() {
        return is_delete;
    }

    public void setIs_delete(Integer is_delete) {
        this.is_delete = is_delete;
    }

    public String getRegiondivision_id() {
        return regiondivision_id;
    }

    public void setRegiondivision_id(String regiondivision_id) {
        this.regiondivision_id = regiondivision_id;
    }
}
