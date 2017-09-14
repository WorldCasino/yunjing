package com.agdress.mapper;

import com.agdress.entity.Starship_UserAccountDetailEntity;
import com.agdress.entity.vo.Starship_AccountDetaillistVo;
import com.agdress.entity.vo.Starship_SumVo;
import com.baomidou.mybatisplus.mapper.BaseMapper;

import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/4/28.
 */
public interface Starship_AccountDetailMapper extends BaseMapper<Starship_UserAccountDetailEntity> {

    List<Starship_AccountDetaillistVo> selectAccountDetailListVoPage(Map<String, String> params);

    Starship_AccountDetaillistVo selectByTradeId(Long trade_id);

    List<Starship_SumVo> sumMoneyForType(Map<String, String> params);

}
