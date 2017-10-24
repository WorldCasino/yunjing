package com.kk.commons.utils;

import com.alibaba.fastjson.JSONObject;

import java.util.HashMap;
import java.util.Set;

/**
 * Created by Administrator on 2017/6/30.
 */
public class cmsUtil {

    /**
     * JSONObject 对象转 map
     * @param jsonObject
     * @return
     */
    public static HashMap<String, String> toHashMap(JSONObject jsonObject)
    {
        HashMap<String, String> data = new HashMap<String, String>();
        Set<String> keySet = jsonObject.keySet();
        // 遍历jsonObject数据，添加到Map对象
        for (String key :keySet) {
            Object value = jsonObject.get(key);
            data.put(key, String.valueOf(value));
        }

        return data;
    }
}
