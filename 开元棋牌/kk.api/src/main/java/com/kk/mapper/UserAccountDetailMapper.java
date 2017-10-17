package com.kk.mapper;

import com.kk.entity.UserAccountDetailEntity;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.kk.entity.vo.SumVo;
import com.kk.entity.vo.UserAccountDetaillistVo;

import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/4/28.
 *
 */
public interface UserAccountDetailMapper extends BaseMapper<UserAccountDetailEntity> {

    List<UserAccountDetaillistVo> selectAccountDetailListVoPage(Map<String, String> params);

    UserAccountDetaillistVo selectByTradeId(Long trade_id);

    List<SumVo> sumMoneyForType(Map<String, String> params);

}
