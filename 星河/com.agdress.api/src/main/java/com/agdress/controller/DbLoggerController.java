package com.agdress.controller;



 import com.agdress.commons.utils.DateFormatUtil;
 import com.agdress.commons.utils.SpringContextUtil;
 import com.agdress.entity.UserEntity;

import com.agdress.mapper.UserMapper;
 import com.agdress.message.SmsAdapter;
 import com.agdress.mongodb.DBLoggerDao;
import com.agdress.mongodb.model.DBLogger;
import com.agdress.service.IUserService;
 import com.agdress.service.Starship_IGamesService;
 import org.springframework.beans.factory.annotation.Autowired;
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


    //dblogger/test --- 测试
    @RequestMapping("/test")
    @ResponseBody
    public UserEntity test( ){
        try {
            UserEntity user =new UserEntity();
            user=userMapper.selectById(17000002);
            System.out.println("version="+user.getVersionNo());
            user.setNickname("sfsf");
            int r = userMapper.updateById(user);
            if(r == 0){
                System.out.println("处理失败，重新处理");
            }else{
                System.out.println("处理成功============");
            }
            //更新后的信息
            user=userMapper.selectById(17000002);
            System.out.println("version="+user.getVersionNo());
        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }
        return null;
    }




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



    @Autowired
    private Starship_IGamesService gamesService;

    /**
     * dblogger/getGamesList --- 测试
     */
    @RequestMapping("/getGamesList")
    @ResponseBody
    public void getGamesList ( ){
        try {
            gamesService.getThreeGamesList(null, null, 0, null,
                    null, null, 2, 0, 0, null, 1, 500, null);
        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }
    }



}