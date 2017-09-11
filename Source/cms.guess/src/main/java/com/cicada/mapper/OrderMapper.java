package com.cicada.mapper;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.cicada.pojo.OrderEntity;
import com.cicada.pojo.vo.OrderVo;

import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/4/28.
 */
public interface OrderMapper extends BaseMapper<OrderEntity> {

    /**
     * 获取兑换列表 分页
     * @param whereMap
     * @return
     */
    List<OrderVo> selectOrderVoList(Map<String,Object> whereMap);

    /**
     * 获取兑换记录总数
     * @param whereMap
     * @return
     */
    long selectOrderTotal(Map<String,Object> whereMap);

    /**
     * 审核处理
     * @param params 参数包含{ orderId 订单号 orderStatus 订单状态 }
     * @return 更新影响行数
     */
    int updateOrderStatus(Map<String,Object> params);


}
