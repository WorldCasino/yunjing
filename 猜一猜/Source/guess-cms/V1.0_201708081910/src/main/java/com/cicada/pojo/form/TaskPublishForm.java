package com.cicada.pojo.form;

import java.io.Serializable;

/**
 * 发布竞猜项目表单数据
 * 用于接收前台提交过来的表单数据
 * 注意：1、字段名需与前台name属性一致
 *      2、枚举类型暂时不支持
 *      3、混合表单提交的时候才用，一般普通的POST过来只需用 @RequestBody JSONObject接收就可以了
 *
 * TODO 查查有没有其他字段对应方法 比如jackson的注解
 * Created by Administrator on 2017/7/8.
 */
public class TaskPublishForm implements Serializable{
    private int task_id;
    private int user_id;
    private int task_type;
    private String task_content;
    private int answer_right_id;
    private String answer_right;
    private double answer_right_odds;
    private int answer_err_id;
    private String answer_err;
    private double answer_err_odds;
    private int sale_price;
    private int quantity;
    private String lock_time;
    private String settle_time;
    private int hot;
    private String team_name_a;
    private String team_name_b;
    private double odds_a_win;
    private double odds_dogfall;
    private double odds_b_win;

    public int getTask_id() {
        return task_id;
    }

    public void setTask_id(int task_id) {
        this.task_id = task_id;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public int getTask_type() {
        return task_type;
    }

    public void setTask_type(int task_type) {
        this.task_type = task_type;
    }

    public String getTask_content() {
        return task_content;
    }

    public void setTask_content(String task_content) {
        this.task_content = task_content;
    }

    public int getAnswer_right_id() {
        return answer_right_id;
    }

    public void setAnswer_right_id(int answer_right_id) {
        this.answer_right_id = answer_right_id;
    }

    public String getAnswer_right() {
        return answer_right;
    }

    public void setAnswer_right(String answer_right) {
        this.answer_right = answer_right;
    }

    public double getAnswer_right_odds() {
        return answer_right_odds;
    }

    public void setAnswer_right_odds(double answer_right_odds) {
        this.answer_right_odds = answer_right_odds;
    }

    public int getAnswer_err_id() {
        return answer_err_id;
    }

    public void setAnswer_err_id(int answer_err_id) {
        this.answer_err_id = answer_err_id;
    }

    public String getAnswer_err() {
        return answer_err;
    }

    public void setAnswer_err(String answer_err) {
        this.answer_err = answer_err;
    }

    public double getAnswer_err_odds() {
        return answer_err_odds;
    }

    public void setAnswer_err_odds(double answer_err_odds) {
        this.answer_err_odds = answer_err_odds;
    }

    public int getSale_price() {
        return sale_price;
    }

    public void setSale_price(int sale_price) {
        this.sale_price = sale_price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getLock_time() {
        return lock_time;
    }

    public void setLock_time(String lock_time) {
        this.lock_time = lock_time;
    }

    public String getSettle_time() {
        return settle_time;
    }

    public void setSettle_time(String settle_time) {
        this.settle_time = settle_time;
    }

    public int getHot() {
        return hot;
    }

    public void setHot(int hot) {
        this.hot = hot;
    }

    public String getTeam_name_a() {
        return team_name_a;
    }

    public void setTeam_name_a(String team_name_a) {
        this.team_name_a = team_name_a;
    }

    public String getTeam_name_b() {
        return team_name_b;
    }

    public void setTeam_name_b(String team_name_b) {
        this.team_name_b = team_name_b;
    }

    public double getOdds_a_win() {
        return odds_a_win;
    }

    public void setOdds_a_win(double odds_a_win) {
        this.odds_a_win = odds_a_win;
    }

    public double getOdds_dogfall() {
        return odds_dogfall;
    }

    public void setOdds_dogfall(double odds_dogfall) {
        this.odds_dogfall = odds_dogfall;
    }

    public double getOdds_b_win() {
        return odds_b_win;
    }

    public void setOdds_b_win(double odds_b_win) {
        this.odds_b_win = odds_b_win;
    }
}
