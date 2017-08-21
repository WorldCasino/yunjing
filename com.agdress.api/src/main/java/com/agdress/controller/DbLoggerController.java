package com.agdress.controller;



import com.agdress.commons.secret.VersionLocker;
import com.agdress.commons.utils.DateFormatUtil;
import com.agdress.entity.UserEntity;
import com.agdress.entity.vo.LoginResultVo;
import com.agdress.enums.GenderEnum;
import com.agdress.enums.UserStatusEnum;
import com.agdress.enums.UserTypeEnum;
import com.agdress.mapper.UserMapper;
import com.agdress.mongodb.DBLoggerDao;
 import com.agdress.mongodb.model.DBLogger;
import com.agdress.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.List;
import java.util.logging.Logger;


/**
 *  DbLoggerController
 *  
   */  
@RestController
@RequestMapping("/dblogger")
public class DbLoggerController {

    @Resource(name="dBLoggerDao")
    private DBLoggerDao dBLoggerDao;

    //dblogger/saveLogger ---记录接口访问时间以及接口名称
    @RequestMapping("/saveLogger")
    @ResponseBody
    public String saveLogger(){
         try {
             DBLogger logger = new DBLogger();
             logger.setId("111111");
             logger.setErrorType("1");
             logger.setErrorContent("404 Bad Request");
             logger.setCreatetime(DateFormatUtil.Now());
             logger.setRequest_parameter("({'2':'2','2','2'})");
             logger.setResult_parameter("({'2':'2','2','2'})");
             logger.setPath("dblogger/saveLogger");
              dBLoggerDao.save(logger);
         } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }
        return "0";
    }

    //dblogger/findAll --- 值查询
    @RequestMapping("/findAll")
    @ResponseBody
    public List<DBLogger> findAll( DBLogger dblogger){
        List<DBLogger> ulist=null;
        try {
             ulist=dBLoggerDao.listAllByCondition(dblogger);
         } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }
        return ulist;
    }


    //dblogger/findLikeAll?key=id&content=2 ---值模糊查询
    @RequestMapping("/findLikeAll")
    @ResponseBody
    public List<DBLogger> findLikeAll(String key ,String content){
        List<DBLogger> ulist=null;
        try {
            ulist=dBLoggerDao.listAllByLikeCondition(key,content);
        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }
        return ulist;
    }


    @Autowired
    private UserMapper userMapper;

    @Autowired
    private IUserService userService;

    //dblogger/test --- 测试
    @VersionLocker
    @RequestMapping("/test")
    @ResponseBody
    public UserEntity test( ){
        UserEntity user = null;
        try {
            user = new UserEntity();
//            String phone="15260282340";
//            user.setBgUserId(22222);
//            user.setLoginName(phone);
//            user.setPassword(String.valueOf((int)(Math.random()*(999999-100000+1))+100000));
//            user.setGender(GenderEnum.Unknown);
//            user.setNickname(phone);
//            user.setPhone(phone);
//            user.setUserStatus(UserStatusEnum.Normall);
//            user.setUserType(UserTypeEnum.Client);
//            user.setTimeStamp(0);
//            userMapper.insert(user);
            user.setUserId(17000002);
            user.setTimeStamp(19);
            user.setNickname("我自己");
            userMapper.updateById(user);
             //
//           userMapper.updateVersion(user);
        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }
        return user;
    }




}