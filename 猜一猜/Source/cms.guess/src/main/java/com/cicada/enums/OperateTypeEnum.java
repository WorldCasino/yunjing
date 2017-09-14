package com.cicada.enums;

/**
 * 活动类型
 * Created by Administrator on 2017/4/20.
 */
public enum OperateTypeEnum implements CodeBaseEnum {
    Login(1,"每日登录"),
    Publish(2,"发布猜一猜"),
    ParticipateByCoin(3,"参与猜一猜（使用金币）"),
    ParticipateByBean(4,"参与猜一猜（使用金豆）"),
    ParticipateInQUIZ(5,"参与猜一猜（图文）"),
    ParticipateInComing(6,"参与猜一猜（未知事件）"),
    ParticipateInFootball(7,"参与猜一猜（足球竞猜）"),
    ParticipateInNba(8,"参与猜一猜（篮球竞猜）"),
    Participate(9,"参与猜一猜"),
    ParticipateQuantity(10,"参与猜一猜（下注数）"),
    Transmit(11,"转发猜一猜"),
    ShareFriendInQUIZ(12,"分享图文竞猜给微信好友"),
    ShareFriendInComing(13,"分享未知事件竞猜给微信好友"),
    ShareFriendInFootball(14,"分享足球竞猜给微信好友"),
    ShareFriendInNba(15,"分享篮球竞猜给微信好友"),
    ShareFriend(16,"分享竞猜给微信好友"),
    ShareFriendCircle(17,"分享任意1个竞猜到朋友圈"),
    InviteFriend(18,"邀请好友到猜一猜");

    private final int code;
    private final String desc;

    OperateTypeEnum(int code, String desc) {
        this.code = code;
        this.desc = desc;
    }

    @Override
    public int getCode() {
        return code;
    }

    public String getDesc() {
        return desc;
    }
}
