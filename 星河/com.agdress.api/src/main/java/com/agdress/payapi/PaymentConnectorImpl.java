package com.agdress.payapi;

import com.agdress.commons.Exception.ApiException;
import com.agdress.commons.utils.HttpClientUtil;
import com.agdress.commons.utils.MD5Util;
import com.agdress.commons.utils.StringUtils;
import com.agdress.commons.utils.SystemConfig;
import com.agdress.enums.ErrorCodeEnum;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import org.apache.http.HttpEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.*;

/**
 * Created by Administrator on 2017/8/22.
 */
@Component
public class PaymentConnectorImpl implements IPaymentConnector {

    @Autowired
    private SystemConfig systemConfig;

    @Override
    public boolean requestPay(PaymentReq req) throws ApiException {

        try {

            JSONObject json = (JSONObject) JSON.toJSON(req);
            Map<String, String> map = (Map) json;
            //这里将map.entrySet()转换成list
            List<Map.Entry<String, String>> list = new ArrayList<Map.Entry<String, String>>(map.entrySet());
            //然后通过比较器来实现排序
            //升序排序
            Collections.sort(list, Comparator.comparing(Map.Entry::getKey));

            Map<String, String> params = new HashMap<>();
            String str = "";
            for (Map.Entry<String, String> pair : list) {
                if(StringUtils.isEmpty(pair.getValue())) continue;

                str += pair.getKey() + "=" + pair.getValue() + "&";
                params.put(pair.getKey(), pair.getValue());
            }

            str += systemConfig.getPAYMENT_SECRET_KEY();
            String sign = MD5Util.getMD5Str(str).toLowerCase();
            req.setSign(sign);
            params.put("sign",sign);

            HttpEntity rtnEntity = HttpClientUtil.doPost(systemConfig.getPAYMENT_REQUEST_URL(), params);

            //新宝支付请求的接口没有返回值~ 坑爹货
            //String rtnStr = HttpClientUtil.toString(rtnEntity);
            if (rtnEntity == null) {
                throw new ApiException(ErrorCodeEnum.PaymentRequestException);
            }

            return true;
        }catch (Exception e){
            e.printStackTrace();
            throw new ApiException(ErrorCodeEnum.PaymentRequestException);
        }
    }

    @Override
    public PaymentRsp requestQuery(PaymentReq params) throws ApiException {
        return null;
    }
}
