package com.cicada.mapper;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.cicada.pojo.ClientAccountDetailEntity;
import com.cicada.pojo.vo.TradeVo;

import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/4/28.
 */
public interface ClientAccountDetailMapper extends BaseMapper<ClientAccountDetailEntity> {

    List<TradeVo> selectTradeList(Map<String,Object> params);
    long selectTradeRecordsTotal(Map<String,Object> params);
}
