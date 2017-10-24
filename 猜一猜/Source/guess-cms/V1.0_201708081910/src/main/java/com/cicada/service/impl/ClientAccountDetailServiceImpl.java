package com.cicada.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.cicada.commons.Exception.ApiException;
import com.cicada.commons.utils.CicadaUtil;
import com.cicada.enums.ErrorCodeEnum;
import com.cicada.mapper.ClientAccountDetailMapper;
import com.cicada.pojo.ClientAccountDetailEntity;
import com.cicada.pojo.vo.ClientVo;
import com.cicada.pojo.vo.TaskVo;
import com.cicada.pojo.vo.TradeVo;
import com.cicada.result.DatatablesResult;
import com.cicada.service.IClientAccountDetailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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

}
