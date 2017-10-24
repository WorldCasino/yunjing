package com.cicada.wechat.pay;

import java.util.*;

/**
 * Created by Administrator on 2017/5/17.
 * Description: *_*
 */
public class WxPayData {

    private SortedMap<String, Object> values = new TreeMap<>();

    public void setValue(String key, Object value) {
        values.put(key, value);
    }

    public Object getValue(String key) {
        return  values.get(key);
    }

    public boolean isSet(String key) {
        return values.containsKey(key);
    }

    public String toUrl() throws WxPayException {
        StringBuffer buffer = new StringBuffer();
        Set<Map.Entry<String, Object>> set = values.entrySet();
        for (Iterator<Map.Entry<String, Object>> iter = set.iterator(); iter.hasNext();) {
            Map.Entry<String, Object> entry = iter.next();
            String key = entry.getKey();
            Object value = entry.getValue();
            if (value == null) {
                throw new WxPayException("WxPayData内部含有值为null的字段!");
            }

            if (!"sign".equals(key) && !key.isEmpty()) {
                buffer.append(key + "=");
                buffer.append(value);
                buffer.append("&");
            }
        }
        String url = buffer.toString();
        return url.substring(0, url.length() - 1);
    }
}
