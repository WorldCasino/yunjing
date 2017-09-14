package com.agdress;

/**
 * Created by Administrator on 2017/8/14.
 * Description: *_*
 */
public class Human {

    // 姓名
    private String name;
    // 性别
    private String gender;

    public Human(String name, String  gender) {
        this.name = name;
        this.gender = gender;
    }

    // 介绍自己
    public void introduceMyself() {
        System.out.print("我的名字叫" + this.name + ", 我是" + gender);
    }
}
