package com.cicada.service.impl;

import com.cicada.commons.utils.EscapeUnescape;
import com.cicada.commons.utils.StringUtils;
import com.cicada.mapper.ClientMapper;
import com.cicada.mapper.TaskMapper;
import com.cicada.pojo.ClientEntity;
import com.cicada.pojo.Task;
import com.cicada.pojo.vo.LotteryResultVo;
import com.cicada.service.ITaskService;
import org.apache.http.entity.ContentType;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.List;

import static org.junit.Assert.*;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:spring/*.xml")
public class TaskServiceImplTest {

    @Autowired
    private ITaskService taskService;

    @Autowired
    private TaskMapper taskMapper;

    @Autowired
    private ClientMapper clientMapper;

    @Test
    public void Test1() throws Exception {
        LotteryResultVo resultVo = taskService.runLotteryProcess(725,true);

        ClientEntity dealer = clientMapper.selectById(resultVo.getUserId());

        StringBuilder param = new StringBuilder();
        int totalCoinShares = 0;
        int totalBeanShares = 0;
        if (resultVo.getLotteryType() == 2){
            totalCoinShares = new Double(0 - resultVo.getCoinExpendTotal()).intValue();
            totalBeanShares = new Double(0 - resultVo.getBeanExpendTotal()).intValue();
        }else{
            totalCoinShares = new Double(resultVo.getCoinIncomeTotal() - resultVo.getCoinExpendTotal()).intValue();
            totalBeanShares = new Double(resultVo.getBeanIncomeTotal() - resultVo.getBeanExpendTotal()).intValue();
        }
        param.append("累计收入：" + new Double(resultVo.getCoinIncomeTotal()).intValue() + "金币  " + new Double(resultVo.getBeanIncomeTotal()).intValue() + "金豆\r\n")
                .append("累计打赏：" + new Double(resultVo.getCoinExpendTotal()).intValue() + "金币" + new Double(resultVo.getBeanExpendTotal()).intValue() + "金豆\r\n")
                .append("累计盈亏：" + totalCoinShares + "金币" + totalBeanShares + "金豆\r\n")
                .append("参与人数：" + resultVo.getPlayerCount() + "人\r\n")
                .append("项目详情：" + resultVo.getTaskContent() + "\r\n")
                .append(resultVo.getAnswer());
        System.out.println(param);

        List<LotteryResultVo.PlayerVo> list = resultVo.getPlayerVoList();
        StringBuilder param2 = new StringBuilder();
        for (LotteryResultVo.PlayerVo playerVo:list) {
            ClientEntity client = clientMapper.selectById(playerVo.getUserId());
            double totalCoins = 0;
            double totalBeans = 0;
            for (LotteryResultVo.BettingVo bet:playerVo.getBettingVoList()) {
                param2.append(String.format("参与答案%s：%s注【%s倍】%s金币 %s金豆\r\n",
                        bet.getAbc(),bet.getCoinsQty()+bet.getBeansQty(),bet.getOdds(),
                        new Double(bet.getCoinsQty() * resultVo.getSalePrice()).intValue(),
                        new Double(bet.getBeansQty() * resultVo.getSalePrice()).intValue()));
                if(bet.isRight()) {
                    if (resultVo.getLotteryType() == 2){
                        totalCoins += bet.getCoins();
                        totalBeans += bet.getBeans();
                    }else {
                        totalCoins += (bet.getCoins() - bet.getCoinsQty() * resultVo.getSalePrice());
                        totalBeans += (bet.getBeans() - bet.getBeansQty() * resultVo.getSalePrice());
                    }
                }
                else {
                    totalCoins -= bet.getCoins();
                    totalBeans -= bet.getBeans();
                }
            }
            param2.append("累计盈亏：" + new Double(totalCoins).intValue() + "金币  " + new Double(totalBeans).intValue() + "金豆\r\n");
            param2.append(String.format("项目详情：%s \r\n", resultVo.getTaskContent()))
                    .append(resultVo.getAnswer());
        }
        System.out.println(param2);
    }

    @Test
    public void Test2() throws UnsupportedEncodingException {
        Task task = taskMapper.selectById(559);
        String orgContent = task.getTaskContent();
        orgContent = EscapeUnescape.unescape(orgContent);
        System.out.println(orgContent);
    }

}