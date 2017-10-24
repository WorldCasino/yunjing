package com.cicada.service;

import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.service.IService;
import com.cicada.commons.Exception.ApiException;
import com.cicada.pojo.OrderEntity;
import com.cicada.result.DatatablesResult;

/**
 * Created by Administrator on 2017/7/18.
 */
public interface IOrderService extends IService<OrderEntity>{
    /**
     * 获取兑换列表
     * @param params 参数
     * @param page 页码
     * @param rows 每页行数
     * @param draw 不知道
     * @return
     * @throws ApiException
     */
    DatatablesResult<OrderEntity> selectOrderByPage(JSONObject params, Integer page, Integer rows, Integer draw) throws ApiException;

    /**
     * 审核处理
     * @param orderId 订单号
     * @param isOk 是否通过
     * @param shiroUser 审核用户
     * @return
     * @throws ApiException
     */
    boolean auditProcess(long orderId,boolean isOk,long shiroUser) throws ApiException;
}
