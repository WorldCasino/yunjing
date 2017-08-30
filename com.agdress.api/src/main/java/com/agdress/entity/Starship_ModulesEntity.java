package com.agdress.entity;


import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;

/**
 * 角色关联菜单
 */
@TableName(value = "m_modules")
public class Starship_ModulesEntity  {

    @TableId(type = IdType.AUTO, value = "id")
    private Long id;

    @TableField(value = "name")
    private String name;

    @TableField(value = "url")
    private String url;

    @TableField(value = "module_type")
    private Long module_type;

    @TableField(value = "open_mode")
    private String open_mode;

    @TableField(value = "description")
    private String description;

    @TableField(value = "pid")
    private Long pid;

    @TableField(value = "icon")
    private String icon;


    @TableField(value = "seq")
    private Long seq;

    @TableField(value = "opened")
    private Long opened;


    @TableField(value = "status")
    private Long status;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public Long getModule_type() {
        return module_type;
    }

    public void setModule_type(Long module_type) {
        this.module_type = module_type;
    }

    public String getOpen_mode() {
        return open_mode;
    }

    public void setOpen_mode(String open_mode) {
        this.open_mode = open_mode;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Long getPid() {
        return pid;
    }

    public void setPid(Long pid) {
        this.pid = pid;
    }

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
    }

    public Long getSeq() {
        return seq;
    }

    public void setSeq(Long seq) {
        this.seq = seq;
    }

    public Long getOpened() {
        return opened;
    }

    public void setOpened(Long opened) {
        this.opened = opened;
    }

    public Long getStatus() {
        return status;
    }

    public void setStatus(Long status) {
        this.status = status;
    }
}
