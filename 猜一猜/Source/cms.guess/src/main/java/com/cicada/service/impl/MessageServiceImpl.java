package com.cicada.service.impl;

import com.cicada.commons.Exception.ApiException;
import com.cicada.commons.utils.StringUtils;
import com.cicada.commons.utils.SystemConfig;
import com.cicada.commons.utils.XingeUtil;
import com.cicada.enums.DeviceTypeEnum;
import com.cicada.enums.ErrorCodeEnum;
import com.cicada.mapper.ClientMapper;
import com.cicada.pojo.ClientEntity;
import com.cicada.pojo.vo.LotteryResultVo;
import com.cicada.service.IMessageService;
import com.cicada.service.IWechatService;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.awt.*;
import java.util.List;

/**
 * 消息通知服务
 * Created by Administrator on 2017/7/11.
 */
@Service
@Transactional
public class MessageServiceImpl implements IMessageService {
    private static final Logger LOTTERY_LOGGER = LogManager.getLogger("lottery");

    @Autowired
    private ClientMapper clientMapper;
    @Autowired
    private IWechatService wechatService;

    /**
     * 开奖结果消息通知（微信消息模板）
     * @param resultVo 开奖结果
     * @return
     * @throws ApiException
     */
    public boolean sendLotteryMessage(LotteryResultVo resultVo) throws ApiException{
        if(null == resultVo) return false;

        try {
            //庄家
            ClientEntity dealer = clientMapper.selectById(resultVo.getUserId());
            //String dealerName = StringUtils.isEmpty(dealer.getNickname())?dealer.getPhonenumber():dealer.getNickname();
            //给庄家发微信模板消息
            if(!StringUtils.isEmpty(dealer.getWxOpenId())) {
                StringBuilder param = new StringBuilder();
                param.append("累计收入：" + new Double(resultVo.getCoinIncomeTotal()).intValue() + "金币  " + new Double(resultVo.getBeanIncomeTotal()).intValue() + "金豆\r\n" )
                        .append("累计打赏：" + new Double(resultVo.getCoinExpendTotal()).intValue() + "金币" + new Double(resultVo.getBeanExpendTotal()).intValue() + "金豆\r\n")
                        .append("累计盈亏：" + new Double(resultVo.getCoinIncomeTotal() - resultVo.getCoinExpendTotal()).intValue()
                                + "金币" + new Double(resultVo.getBeanIncomeTotal() - resultVo.getBeanExpendTotal()).intValue() + "金豆\r\n")
                        .append("参与人数：" + resultVo.getPlayerCount() + "人\r\n")
                        .append("项目详情：" + resultVo.getTaskContent()+"\r\n")
                        .append(resultVo.getAnswer());
                wechatService.sendLotteryMessage(dealer.getWxOpenId(),true,resultVo.getTaskId(),param.toString());
                LOTTERY_LOGGER.info(String.format("竞猜项目【%s】开奖结果已通知庄家【%s】，OPEN ID【%s】,内容：%s",
                        resultVo.getTaskId(),resultVo.getUserId(),dealer.getWxOpenId(),param.toString()));
            }

            //给庄家APP推送
            if(!StringUtils.isEmpty(dealer.getDeviceToken())){
                String content = "你发布的竞猜开奖了，点我查看有多少人猜对了》";
                XingeUtil.pushSignl(dealer.getDeviceType(),dealer.getDeviceToken(),content,resultVo.getTaskId());
            }

            //给玩家发模板消息
            if (null != resultVo.getPlayerVoList()){
                List<LotteryResultVo.PlayerVo> list = resultVo.getPlayerVoList();
                for (LotteryResultVo.PlayerVo playerVo:list) {
                    ClientEntity client = clientMapper.selectById(playerVo.getUserId());
                    if(!StringUtils.isEmpty(client.getWxOpenId())){
                        StringBuilder param = new StringBuilder();
                        double totalCoins = 0;
                        double totalBeans = 0;
                        for (LotteryResultVo.BettingVo bet:playerVo.getBettingVoList()) {
                            param.append(String.format("参与答案%s：%s注【%s倍】%s金币 %s金豆\r\n",
                                    bet.getAbc(),bet.getCoinsQty(),bet.getOdds(),new Double(bet.getCoins()).intValue(),new Double(bet.getBeans()).intValue()));
                            if(bet.isRight()) {
                                totalCoins += bet.getCoins();
                                totalBeans += bet.getBeans();
                            }
                            else {
                                totalCoins -= bet.getCoins();
                                totalBeans -= bet.getBeans();
                            }
                        }
                        param.append("累计盈亏：" + new Double(totalCoins).intValue() + "金币  " + new Double(totalBeans).intValue() + "金豆\r\n");
                        param.append(String.format("项目详情：%s \r\n", resultVo.getTaskContent()))
                                .append(resultVo.getAnswer());

                        wechatService.sendLotteryMessage(client.getWxOpenId(),false,resultVo.getTaskId(),param.toString());

                        LOTTERY_LOGGER.info(String.format("竞猜项目【%s】开奖结果已通知玩家【%s】，OPEN ID【%s】，内容：%s",
                                resultVo.getTaskId(),client.getUserId(),client.getWxOpenId(),param.toString()));
                    }

                    //给玩家APP推送
                    if(!StringUtils.isEmpty(client.getDeviceToken())){
                        String content = "你发布的竞猜开奖了，点我查看有多少人猜对了》";
                        XingeUtil.pushSignl(client.getDeviceType(),client.getDeviceToken(),content,resultVo.getTaskId());
                    }
                }
            }
        }
        catch (ApiException e){
            LOTTERY_LOGGER.error(String.format("竞猜项目【%s】开奖结果通知失败！",resultVo.getTaskId()),e);
            throw e;
        }
        catch (Exception e){
            LOTTERY_LOGGER.error(String.format("竞猜项目【%s】开奖结果通知失败！",resultVo.getTaskId()),e);
            throw new ApiException(ErrorCodeEnum.LotteryResultNotifyError);
        }
        return true;
    }
}
