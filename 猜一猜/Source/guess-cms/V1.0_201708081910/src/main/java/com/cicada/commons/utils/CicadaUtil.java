package com.cicada.commons.utils;

import com.alibaba.fastjson.JSONObject;

import java.util.HashMap;
import java.util.Set;

/**
 * Created by Administrator on 2017/6/30.
 */
public class CicadaUtil {

    /**
     * JSONObject 对象转 map
     * @param jsonObject
     * @return
     */
    public static HashMap<String, Object> toHashMap(JSONObject jsonObject)
    {
        HashMap<String, Object> data = new HashMap<String, Object>();
        Set<String> keySet = jsonObject.keySet();
        // 遍历jsonObject数据，添加到Map对象
        for (String key :keySet) {
            Object value = jsonObject.get(key);
            data.put(key, value);
        }

        return data;
    }
}
