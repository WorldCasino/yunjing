package com.cicada.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.cicada.commons.Exception.ApiException;
import com.cicada.commons.utils.CicadaUtil;
import com.cicada.commons.utils.StringUtils;
import com.cicada.enums.CurrencyTypeEnum;
import com.cicada.enums.ErrorCodeEnum;
import com.cicada.enums.TradeTypeEnum;
import com.cicada.mapper.ClientAccountDetailMapper;
import com.cicada.mapper.ClientAccountMapper;
import com.cicada.pojo.ClientAccountDetailEntity;
import com.cicada.pojo.ClientAccountEntity;
import com.cicada.pojo.ClientEntity;
import com.cicada.pojo.vo.ClientVo;
import com.cicada.pojo.vo.TaskVo;
import com.cicada.pojo.vo.TradeVo;
import com.cicada.result.DatatablesResult;
import com.cicada.service.IClientAccountDetailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/6/17.
 */
@Service
@Transactional
public class ClientAccountDetailServiceImpl extends ServiceImpl<ClientAccountDetailMapper,ClientAccountDetailEntity> implements IClientAccountDetailService {
    @Autowired
    private ClientAccountDetailMapper clientAccountDetailMapper;
    @Autowired
    private ClientAccountMapper accountMapper;

    /**
     * 获取玩家交易明细列表
     * @param params
     * @param page
     * @param rows
     * @param draw
     * @return
     * @throws ApiException
     */
    public DatatablesResult selectTradeList(JSONObject params, int page, int rows, int draw ) throws ApiException{
        DatatablesResult pageResult = new DatatablesResult<TaskVo>();
        try {

            Map<String,Object> whereMap = CicadaUtil.toHashMap(params);
            whereMap.put("limit",rows);
            whereMap.put("offset",rows*(page - 1));
            String idsStr = params.getString("tradeTypeIds");
            if(!StringUtils.isEmpty(idsStr)){
                String[] temp = idsStr.split(",");
                List<Integer> idList = new ArrayList<>();
                for (String x:temp) {
                    idList.add(Integer.valueOf(x));
                }
                whereMap.put("idsList",idList);
            }else {
                whereMap.put("idsList",new ArrayList<Integer>());
            }

            List<TradeVo> list = clientAccountDetailMapper.selectTradeList(whereMap);

            pageResult.setData(list);
            pageResult.setDraw(draw);
            pageResult.setRecordsTotal((int) clientAccountDetailMapper.selectTradeRecordsTotal(whereMap));
            pageResult.setRecordsFiltered(pageResult.getRecordsTotal());

        }catch (Exception e){
            throw new ApiException(ErrorCodeEnum.SystemError.getCode(),e.getMessage());
        }

        return pageResult;
    }

    /**
     * 系统赠送
     * @param userId 用户
     * @param giftCoins 赠送金币数
     * @param remark 赠送原因、备注
     * @return
     * @throws ApiException
     */
    public boolean rechargeBySystem(long userId,int giftCoins,String remark) throws ApiException{
        boolean result;
        try {
            Map<String,Object> whereMap = new HashMap<>();
            whereMap.put("user_id",userId);
            whereMap.put("coin_type", CurrencyTypeEnum.Coin);
            ClientAccountEntity account = accountMapper.selectByMap(whereMap).get(0);

            ClientAccountDetailEntity entity = new ClientAccountDetailEntity();
            entity.setUserId(userId);
            entity.setAccountId(account.getAccountId());
            entity.setFromType(TradeTypeEnum.RechargeReward);
            entity.setCoins(new Double(giftCoins));
            entity.setCreateBy(1);//平台用户
            entity.setCreateDate(new Timestamp(System.currentTimeMillis()));
            entity.setUpdateBy(1);
            entity.setIsDelete(0);
            entity.setRemark(remark);
            result = super.insert(entity);
            if(result){
                account.setCoinIncome(account.getCoinIncome() + new Double(giftCoins));
                account.setCoinBalance(account.getCoinBalance() + new Double(giftCoins));

                accountMapper.updateAccountCoins(account);
            }
        }catch (Exception e){
            throw new ApiException(ErrorCodeEnum.IapRechargeError);
        }
        return result;
    }
}
