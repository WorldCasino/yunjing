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
        private int coinsQty;
        private int beansQty;
        /**
         * 玩家盈亏合计
         */
        private double coins;
        private double beans;

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

        public int getCoinsQty() {
            return coinsQty;
        }

        public void setCoinsQty(int coinsQty) {
            this.coinsQty = coinsQty;
        }

        public int getBeansQty() {
            return beansQty;
        }

        public void setBeansQty(int beansQty) {
            this.beansQty = beansQty;
        }

        public double getCoins() {
            return coins;
        }

        public void setCoins(double coins) {
            this.coins = coins;
        }

        public double getBeans() {
            return beans;
        }

        public void setBeans(double beans) {
            this.beans = beans;
        }

        // </editor-fold>
    }

    public LotteryResultVo(long taskId,long userId,String taskContent,int lotteryType,int salePrice,String answer){
        this.taskId = taskId;
        this.userId = userId;
        this.taskContent = taskContent;
        this.lotteryType = lotteryType;
        this.salePrice = salePrice;
        this.answer = answer;

        this.coinIncomeTotal = 0;
        this.coinExpendTotal = 0;
        this.beanIncomeTotal = 0;
        this.beanExpendTotal = 0;
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
     * 开奖方式（1：正常开奖 2：超时开奖 平分庄家的冻结金币）
     */
    private int lotteryType;
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
    private double coinIncomeTotal;
    private double beanIncomeTotal;
    /**
     * 累计打赏
     */
    private double coinExpendTotal;
    private double beanExpendTotal;

    /**
     *
     * @param userId
     * @param answerId
     * @param abc
     * @param right
     * @param odds
     * @param beanQty
     * @param coinQty
     * @param coins
     * @param beans
     */
    public void addPlayerResult(long userId,long answerId,char abc,boolean right,double odds,int coinQty,double coins,int beanQty,double beans){
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
        bettingVo.setCoinsQty(coinQty);
        bettingVo.setBeans(beans);
        bettingVo.setBeansQty(beanQty);
        bettingVo.setOdds(odds);
        if(null ==vo.bettingVoList || vo.bettingVoList.size() == 0) {
            vo.bettingVoList = new ArrayList<>();
        }
        vo.bettingVoList.add(bettingVo);

        if(right) {
            //玩家猜对了，庄家赔付(玩家赚的金币 + 下注时金币)
            if (lotteryType == 2){
                coinExpendTotal += coins;
                beanExpendTotal += beans;

                coinIncomeTotal += this.salePrice * coinQty;
                beanIncomeTotal += this.salePrice * beanQty;
            }else{
                coinExpendTotal += coins + this.salePrice * coinQty;
                beanExpendTotal += beans + this.salePrice * beanQty;
                //同时庄家有一笔收入（玩家下注的金币）
                coinIncomeTotal += this.salePrice * coinQty;
                beanIncomeTotal += this.salePrice * beanQty;
            }
        }
        else {
            coinIncomeTotal += coins;
            beanIncomeTotal += beans;
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

    public int getLotteryType() {
        return lotteryType;
    }

    public double getCoinIncomeTotal() {
        return coinIncomeTotal;
    }

    public double getBeanIncomeTotal() {
        return beanIncomeTotal;
    }

    public double getCoinExpendTotal() {
        return coinExpendTotal;
    }

    public double getBeanExpendTotal() {
        return beanExpendTotal;
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
