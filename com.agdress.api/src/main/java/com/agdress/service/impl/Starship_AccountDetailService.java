package com.agdress.service.impl;


import com.agdress.entity.Starship_UserAccountDetailEntity;
import com.agdress.entity.vo.Starship_AccountDetaillistVo;
import com.agdress.entity.vo.Starship_SumVo;
import com.agdress.mapper.Starship_AccountDetailMapper;
import com.agdress.result.DatatablesResult;
import com.agdress.service.Starship_IAccountDetailService;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;


/**
 * Created by Administrator on 2017/8/17.
 *
 */

@Service
@Transactional
public class Starship_AccountDetailService extends ServiceImpl<Starship_AccountDetailMapper,Starship_UserAccountDetailEntity> implements Starship_IAccountDetailService {

    @Autowired
    private Starship_AccountDetailMapper accountDetailMapper;


    @Override
    public Starship_AccountDetaillistVo selectByTradeId(Long trade_id) {
        Starship_AccountDetaillistVo advo=accountDetailMapper.selectByTradeId(trade_id);
         return advo;
    }



    /**
     * 获取用户列表
     * @param whereMap
     * @param page
     * @param rows
     * @param draw
     * @return
     */
    @Override
    public DatatablesResult<Starship_AccountDetaillistVo> selectAccountDetailListVoPage(Map<String,String> whereMap, Integer page, Integer rows, Integer draw) {
        PageHelper.startPage(page, rows);
        //统计数据
        List<Starship_AccountDetaillistVo> adlistVos = this.accountDetailMapper.selectAccountDetailListVoPage(whereMap);
        PageInfo<Starship_AccountDetaillistVo> pageInfo = new PageInfo<Starship_AccountDetaillistVo>(adlistVos);
        DatatablesResult pageResult = new DatatablesResult<Starship_AccountDetaillistVo>();
        pageResult.setData(adlistVos);
        pageResult.setDraw(draw);
        pageResult.setRecordsTotal((int)pageInfo.getTotal());
        pageResult.setRecordsFiltered(pageResult.getRecordsTotal());
        ///统计金额
        List<Starship_SumVo> sumVoList=accountDetailMapper.sumMoneyForType(whereMap);
        for(Starship_SumVo sumVo : sumVoList){
            if(sumVo.getType() == 1){
                pageResult.setAllcome_onmoney(sumVo.getSummoney());
            }else if(sumVo.getType() == 2){
                pageResult.setAllexpendmoney(sumVo.getSummoney());
            }
        }
        //==============================
         return pageResult;
    }



}
