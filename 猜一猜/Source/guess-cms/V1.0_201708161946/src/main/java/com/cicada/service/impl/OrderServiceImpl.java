package com.cicada.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.cicada.commons.Exception.ApiException;
import com.cicada.commons.utils.CicadaUtil;
import com.cicada.enums.ErrorCodeEnum;
import com.cicada.enums.OrderStatusEnum;
import com.cicada.mapper.OrderMapper;
import com.cicada.pojo.OrderEntity;
import com.cicada.pojo.vo.OrderVo;
import com.cicada.result.DatatablesResult;
import com.cicada.service.IOrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/7/18.
 */
@Service
@Transactional
public class OrderServiceImpl extends ServiceImpl<OrderMapper,OrderEntity> implements IOrderService {

    @Autowired
    private OrderMapper orderMapper;

    /**
     * 获取兑换列表
     * @param params 参数
     * @param page 页码
     * @param rows 每页行数
     * @param draw 不知道
     * @return
     * @throws ApiException
     */
    public DatatablesResult selectOrderByPage(JSONObject params, Integer page, Integer rows, Integer draw) throws ApiException{
        DatatablesResult pageResult = new DatatablesResult<OrderVo>();
        try {
            Map<String,Object> whereMap = CicadaUtil.toHashMap(params);
            whereMap.put("limit",rows);
            whereMap.put("offset",rows*(page - 1));
            List<OrderVo> list = this.orderMapper.selectOrderVoList(whereMap);

            pageResult.setData(list);
            pageResult.setDraw(draw);
            pageResult.setRecordsTotal((int) orderMapper.selectOrderTotal(whereMap));
            pageResult.setRecordsFiltered(pageResult.getRecordsTotal());

        }catch (Exception e){
            e.printStackTrace();
            throw new ApiException(ErrorCodeEnum.SystemError);
        }

        return pageResult;

    }

    /**
     * 审核处理
     * @param orderId 订单号
     * @param isOk 是否通过
     * @param shiroUser 审核用户
     * @return
     * @throws ApiException
     */
    public boolean auditProcess(long orderId,boolean isOk,long shiroUser) throws ApiException{

        try{

            Map<String,Object> params = new HashMap<>();
            params.put("orderId",orderId);
            params.put("orderStatus",isOk? OrderStatusEnum.Express:OrderStatusEnum.AuditFailed);
            params.put("updateBy",shiroUser);
            int rows = orderMapper.updateOrderStatus(params);
            if(rows ==0) throw new ApiException(ErrorCodeEnum.ArgumentException.getCode(),"审核处理失败！");

            return true;
        }catch (Exception e){
            throw new ApiException(ErrorCodeEnum.ArgumentException);
        }
    }
}
