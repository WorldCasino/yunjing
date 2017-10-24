package com.cicada.pojo.vo;

import java.io.Serializable;
import java.util.*;
import java.util.stream.Collectors;

/**
 * 开奖结果
 * Created by Administrator on 2017/7/11.
 */
public class LotteryResultVo implements Serializable {

    public class PlayerVo implements Serializable{
        /**
         * 玩家ID
         */
        private long userId;
        /**
         * 玩家竞猜盈亏情况
         */
        private List<BettingVo> bettingVoList;

        // <editor-fold desc="get set">

        public long getUserId() {
            return userId;
        }

        public List<BettingVo> getBettingVoList() {
            return bettingVoList;
        }

        // </editor-fold>
    }

    public class BettingVo implements Serializable{
        /**
         * 答案ID
         */
        private long answerId;
        /**
         * 答案序号ABC
         */
        private char abc;
        /**
         * 是否正确答案
         */
        private boolean right;
        /**
         * 答案赔率
         */
        private double odds;
        /**
         * 投注合计
         */
        private int qty;
        /**
         * 玩家盈亏合计
         */
        private double coins;

        // <editor-fold desc="get set">

        public long getAnswerId() {
            return answerId;
        }

        public void setAnswerId(long answerId) {
            this.answerId = answerId;
        }

        public char getAbc() {
            return abc;
        }

        public void setAbc(char abc) {
            this.abc = abc;
        }

        public boolean isRight() {
            return right;
        }

        public void setRight(boolean right) {
            this.right = right;
        }

        public double getOdds() {
            return odds;
        }

        public void setOdds(double odds) {
            this.odds = odds;
        }

        public int getQty() {
            return qty;
        }

        public void setQty(int qty) {
            this.qty = qty;
        }

        public double getCoins() {
            return coins;
        }

        public void setCoins(double coins) {
            this.coins = coins;
        }

        // </editor-fold>
    }

    public LotteryResultVo(long taskId,long userId,String taskContent,int salePrice,String answer){
        this.taskId = taskId;
        this.userId = userId;
        this.taskContent = taskContent;
        this.salePrice = salePrice;
        this.answer = answer;

        this.incomeTotal = 0;
        this.expendTotal = 0;
    }

    /**
     * 竞猜ID
     */
    private long taskId;
    /**
     * 庄家ID
     */
    private long userId;
    /**
     * 竞猜项目内容
     */
    private String taskContent;
    /**
     * 正确答案
     */
    private String answer;
    /**
     * 单注金币
     */
    private double salePrice;
    /**
     * 玩家每个答案的参与情况
     */
    private List<PlayerVo> playerVoList;
    /**
     * 累计收入
     */
    private double incomeTotal;
    /**
     * 累计打赏
     */
    private double expendTotal;

    /**
     *
     * @param userId
     * @param answerId
     * @param abc
     * @param right
     * @param odds
     * @param qty
     * @param coins
     */
    public void addPlayerResult(long userId,long answerId,char abc,boolean right,double odds,int qty,double coins){
        PlayerVo vo = new PlayerVo();
        vo.userId = userId;
        if(this.playerVoList ==null) this.playerVoList = new ArrayList<>();

        List<PlayerVo> temp = playerVoList.stream()
                .filter(x -> x.getUserId() == userId)
                .collect(Collectors.toList());
        if (temp == null || temp.size() == 0) {

            this.playerVoList.add(vo);
        }else {
            vo = temp.get(0);
        }

        BettingVo bettingVo = new BettingVo();
        bettingVo.setAnswerId(answerId);
        bettingVo.setAbc(abc);
        bettingVo.setRight(right);
        bettingVo.setCoins(coins);
        bettingVo.setQty(qty);
        bettingVo.setOdds(odds);
        if(null ==vo.bettingVoList || vo.bettingVoList.size() == 0) {
            vo.bettingVoList = new ArrayList<>();
        }
        vo.bettingVoList.add(bettingVo);

        if(right) {
            //玩家猜对了，庄家赔付(玩家赚的金币 + 下注时金币)
            expendTotal += coins + this.salePrice * qty;
            //同时庄家有一笔收入（玩家下注的金币）
            incomeTotal += this.salePrice * qty;
        }
        else {
            incomeTotal += coins;
        }
    }

    /**
     * 参与人数
     * @return
     */
    public int getPlayerCount(){
        if(null==playerVoList) return 0;

        return playerVoList.size();
    }

    public double getIncomeTotal() {
        return incomeTotal;
    }

    public double getExpendTotal() {
        return expendTotal;
    }

    // <editor-fold desc="get set">
    public long getTaskId() {
        return taskId;
    }

    public long getUserId() {
        return userId;
    }

    public String getTaskContent() {
        return taskContent;
    }

    public String getAnswer() {
        return answer;
    }

    public void setAnswer(String answer) {
        this.answer = answer;
    }

    public List<PlayerVo> getPlayerVoList() {
        return playerVoList;
    }
    // </editor-fold>
}
