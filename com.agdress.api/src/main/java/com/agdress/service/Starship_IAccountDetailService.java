package com.agdress.service;


import com.agdress.entity.Starship_UserAccountDetailEntity;
import com.agdress.entity.vo.Starship_AccountDetaillistVo;
import com.agdress.result.DatatablesResult;
import com.baomidou.mybatisplus.service.IService;

import java.util.Map;


/**
 * Created by Administrator on 2017/8/17.
 *
 */

public interface Starship_IAccountDetailService extends IService<Starship_UserAccountDetailEntity> {

     Starship_AccountDetaillistVo selectByTradeId(Long trade_id);

     void UpdateAccountDetail(String tradeId,String examine,String playMoney,String updateBy,String remarks);

     DatatablesResult<Starship_AccountDetaillistVo> selectAccountDetailListVoPage(Map<String, String> whereMap, Integer page, Integer rows, Integer draw);

}
