package com.cicada.pojo;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;
import com.cicada.enums.MatchesStatusEnum;
import com.cicada.enums.MatchesTypeEnum;

import java.sql.Timestamp;

/**
 * 球队信息
 * Created by Administrator on 2017/5/25.
 */

@TableName(value = "t_team")
public class TeamEntity  {

    @TableId(type = IdType.AUTO, value = "team_id")
    private Integer teamId;

    @TableField(value = "team_name")
    private String teamName;
    @TableField(value = "team_logo")
    private String teamLogo;
    @TableField(value = "team_infor")
    private String teamInfor;


    public Integer getTeamId() {
        return teamId;
    }

    public void setTeamId(Integer teamId) {
        this.teamId = teamId;
    }

    public String getTeamName() {
        return teamName;
    }

    public void setTeamName(String teamName) {
        this.teamName = teamName;
    }

    public String getTeamLogo() {
        return teamLogo;
    }

    public void setTeamLogo(String teamLogo) {
        this.teamLogo = teamLogo;
    }

    public String getTeamInfor() {
        return teamInfor;
    }

    public void setTeamInfor(String teamInfor) {
        this.teamInfor = teamInfor;
    }
}
