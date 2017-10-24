package com.kk.controller;



 import com.kk.commons.utils.DateFormatUtil;
 import com.kk.commons.utils.SpringContextUtil;
 import com.kk.entity.UserEntity;

import com.kk.mapper.UserMapper;
 import com.kk.message.SmsAdapter;
 import com.kk.mongodb.DBLoggerDao;
import com.kk.mongodb.model.DBLogger;
 import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.List;


/**
 *  DbLoggerController
 *
 */
@RestController
@RequestMapping("/dblogger")
public class DbLoggerController {

    @Resource(name="dBLoggerDao")
    private DBLoggerDao dBLoggerDao;


    //dblogger/sendMessage --- 测试
    @RequestMapping("/sendMessage")
    @ResponseBody
    public void sendMessage ( ){
        try {
            String four="【全民猜一猜后台】客服%s在后台申请给用户%s上调金币%s个，请注意查询。";
            String str=String.format(four,"大爷","二爷","200");
            ((SmsAdapter)SpringContextUtil.getBean("smsAdapter")).sendSmsNotify("15260282340",str);
        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }
     }




}