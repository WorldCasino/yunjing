package com.cicada.redis;

import com.cicada.commons.utils.XingeUtil;
import com.cicada.enums.DeviceTypeEnum;
import org.junit.Test;

import static org.junit.Assert.*;

/**
 * Created by Administrator on 2017/10/14.
 */
public class MessageQueueListenerTest {
    @Test
    public void handleMessage() throws Exception {
        try {
            org.json.JSONObject xgResult = XingeUtil.pushSignl(DeviceTypeEnum.Android, "b667a78253842b344846b4612adf8d118b620fd6", "安卓推送测试 1120", 1120);
            System.out.println(xgResult);
        }catch (Exception e){
            e.printStackTrace();
        }

    }

}