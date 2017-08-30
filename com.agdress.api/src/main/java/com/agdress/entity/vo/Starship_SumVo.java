package com.agdress.entity.vo;




import java.io.Serializable;

/**
 * 统计实体类
 */
public class Starship_SumVo implements Serializable{

    private Double summoney;
    private Long type;//1-入金，2-出金

    public Double getSummoney() {
        return summoney;
    }

    public void setSummoney(Double summoney) {
        this.summoney = summoney;
    }

    public Long getType() {
        return type;
    }

    public void setType(Long type) {
        this.type = type;
    }
}
