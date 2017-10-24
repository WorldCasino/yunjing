package com.kk.entity;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;

/**
 * Created by Administrator on 2017/8/18.
 * Description: *_*
 */
@TableName("t_pay_type")
public class PayTypeEntity extends BaseEntity {

    @TableId(type = IdType.AUTO, value = "pay_type")
    private Long payType;

    @TableField(value = "pay_name")
    private String payName;

    @TableField(value = "pay_alias")
    private String payAlias;

    @TableField(value = "icon")
    private String icon;

    @TableField(value = "sort")
    private String sort;

    @TableField(value = "is_recommend")
    private Integer isRecommend;

    public String getSort() {
        return sort;
    }

    public void setSort(String sort) {
        this.sort = sort;
    }

    public Integer getIsRecommend() {
        return isRecommend;
    }

    public void setIsRecommend(Integer isRecommend) {
        this.isRecommend = isRecommend;
    }

    public Long getPayType() {
        return payType;
    }
    public void setPayType(Long payType) {
        this.payType = payType;
    }

    public String getPayName() {
        return payName;
    }

    public void setPayName(String payName) {
        this.payName = payName;
    }

    public String getPayAlias() {
        return payAlias;
    }

    public void setPayAlias(String payAlias) {
        this.payAlias = payAlias;
    }

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
    }
}
