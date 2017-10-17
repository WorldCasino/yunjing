package com.kk.kygame.dentity;

import com.kk.entity.GamesEntity;

import java.util.List;

/**
 * 请求数据
 * Created by Administrator on 2017/8/1.
 * Description: *_*
 */
public class DBack {

    private Integer code;
    private String url;//游戏url
    private Double money;//玩家余额
    private String  account;//玩家账号
    private String status;//状态码（-1、不存在，0、失败、 1、成功）订单查询
                        //状态码（-1、不存在，0、不在线、 1、在线）
    private Integer count;//返回列表数量
    private List<GamesEntity> list;
    private String serverStartTime;//数据拉取开始时间
    private String serverEndTime ;//数据拉去结束时间

    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public Double getMoney() {
        return money;
    }

    public void setMoney(Double money) {
        this.money = money;
    }

    public String getAccount() {
        return account;
    }

    public void setAccount(String account) {
        this.account = account;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Integer getCount() {
        return count;
    }

    public void setCount(Integer count) {
        this.count = count;
    }

    public List<GamesEntity> getList() {
        return list;
    }

    public void setList(List<GamesEntity> list) {
        this.list = list;
    }

    public String getServerStartTime() {
        return serverStartTime;
    }

    public void setServerStartTime(String serverStartTime) {
        this.serverStartTime = serverStartTime;
    }

    public String getServerEndTime() {
        return serverEndTime;
    }

    public void setServerEndTime(String serverEndTime) {
        this.serverEndTime = serverEndTime;
    }
}


/**
 0 成功     1 TOKEN 丢失    2 渠道不存在    3 验证时间超时    4 验证错误   5 渠道白名单错误   6 验证字段丢失   7 TOKEN 失效   8 不存在的请求  10 玩家同时在多款游戏中
 11 玩家帐号不存在      12 玩家帐号在渠道中不存在    13 玩家登录帐号不匹配    14 玩家正在游戏中    15 渠道验证错误    16 数据不存在    17 游戏返回码不存在
 18 取出游戏的钱和订单号的钱不匹配    19 设置游戏的钱和订单号的钱不匹配    20 账号禁用    21 账号踢出    22 AES 解密失败    23 URL 解码失败    24 渠道拉取数据超过时间范围
 25 游戏不存在     26 订单号不存在    27 数据库异常    28 ip 禁用    999 请求失败    1001 注册会员账号系统异常    1002 代理商金额不足    1003 玩家大厅上分/下分异常
 1004 代理商渠道不存在    1005 会员金额不足    1006 会员游戏上分/下分异常    1007 玩家登录游戏上分异常    1008 玩家登出游戏下分异常    1009 上下分出现负数(非法值)
 1010 会员退出大厅异常    1011 订单已存在    1012 订单号不符合规则    1013 后台上分/下分异常    1014 上级代理金额不足    1015 会员代理充值异常(不能跨代理给
 1016 玩家账户被锁    1017 更新会员、浏览器信息异常    1018 存储过程参数格式不正确或参数为    1019 更新会员玩过的游戏信息异常    1020 玩家大厅进(出)游戏上分(下分)生
 1021 会员订单失效或不存在    1022 会员订单已经处理过，不能重复处1023 玩家正在游戏中，不能上下分    1024 大厅会员账号不存在    1025 参数错误，子渠道标识不能
 **/