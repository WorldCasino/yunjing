package com.kk.controller;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.kk.commons.Exception.ApiException;
import com.kk.commons.secret.Authorization;
import com.kk.commons.secret.CurrentUser;
import com.kk.commons.utils.ResponseWrapper;
import com.kk.commons.utils.StringUtils;
import com.kk.entity.CardEntity;
import com.kk.entity.UserEntity;
import com.kk.entity.vo.FirstVo;
import com.kk.entity.vo.LoginResultVo;

import com.kk.entity.vo.UserResultVo;
import com.kk.enums.ErrorCodeEnum;
import com.kk.enums.RoleTypeEnum;
import com.kk.enums.UserStatusEnum;
import com.kk.enums.UserTypeEnum;
import com.kk.result.DatatablesResult;
import com.kk.service.ICardService;
import com.kk.service.IUserAccountService;
import com.kk.service.IUserService;
import com.alibaba.fastjson.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

/**
 * Created by Administrator on 2017/8/8.
 * Description: *_*
 */

@RestController
@RequestMapping("/user")
public class UserController extends BaseController {

    @Autowired
    private IUserService userService;

    @Autowired
    private IUserAccountService userAccountService;


    @Autowired
    private ICardService cardService;

    /**
     * 账号密码登录
     * @param params
     * @return
     * /user/login/password
     */
    @RequestMapping(value = "/login/password",method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity passwordLogin(@RequestBody JSONObject params,HttpServletRequest request){

//        System.out.println("params:"+params.toString());

        String mobile = params.getString("mobile");
        String password=params.getString("password");
        String ip=StringUtils.getIp(request);
        LoginResultVo rtn = userService.passwordLogin(mobile,password,ip);

        ResponseWrapper result = ResponseWrapper.succeed(rtn);

        return ResponseEntity.ok(result);
    }



    /**
     * 注册
     * @param params
     * @return
     */
    @RequestMapping(value = "/login/register",method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity register(@RequestBody JSONObject params,HttpServletRequest request) throws Exception {

//        System.out.println("params:"+params.toString());

        String mobile = params.getString("mobile");
        String captcha = params.getString("captcha");
        String nickName=params.getString("nickName");
        String password=params.getString("password");
        String ip=StringUtils.getIp(request);
        LoginResultVo rtn = null;

        rtn = userService.register(mobile,captcha,nickName,ip,password);

        ResponseWrapper result = ResponseWrapper.succeed(rtn);

        return ResponseEntity.ok(result);
    }

    /**
     * 游客登录
     * @param params
     * @return
     */
    @RequestMapping(value = "/login/visitor",method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity visitorLogin(@RequestBody JSONObject params,HttpServletRequest request) throws Exception {

//       System.out.println("params:"+params.toString());

        String device = params.getString("device");
        String ip=StringUtils.getIp(request);

        LoginResultVo rtn = userService.visitorLogin(device,ip) ;

        ResponseWrapper result = ResponseWrapper.succeed(rtn);

        return ResponseEntity.ok(result);
    }


    /**
     * 退出登录
     * @param userEntity
     * @param req
     * @return
     */
    @Authorization
    @RequestMapping(value = "/logout", method = RequestMethod.POST)
    public ResponseWrapper logout(@CurrentUser UserEntity userEntity, @RequestBody String req) {
        userService.logout(userEntity);
        return ResponseWrapper.succeed("logout");
    }


    /**
     * 获取登录次数,以及客服信息
     * @param params
     * @return
     */
    @RequestMapping(value = "/logcount", method = RequestMethod.POST)
    @ResponseBody
    public ResponseWrapper logcount(@RequestBody JSONObject params) {

//      System.out.println("params:"+params.toString());

        String device = params.getString("device");
        FirstVo firstVo=userService.getLoginCount(device);

        return ResponseWrapper.succeed(firstVo);
    }


    /**
     * 忘记密码/修改密码
     * @param params
     * @return
     */
    @RequestMapping(value = "/login/forgetpassword",method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity forgetpassword(@RequestBody JSONObject params) throws Exception {

//        System.out.println("params:"+params.toString());

        String mobile = params.getString("mobile");
        String captcha = params.getString("captcha");
        String password=params.getString("password");
        ResponseWrapper result;
        userService.forgetpassword(mobile,captcha,password);
        result = ResponseWrapper.succeed(true);
        return ResponseEntity.ok(result);
    }


    /**
     * 获取会员信息
     * @param userEntity
     * @return
     */
    @Authorization
    @RequestMapping(value = "/mine/info", method = RequestMethod.POST)
    @ResponseBody
    public ResponseWrapper getMineInfo(@CurrentUser UserEntity userEntity) {

//        System.out.println("userEntity:"+userEntity.toString());

        return ResponseWrapper.succeed(userService.getUserInfo(userEntity));
    }


    /**
     * 获取账号余额
     * @param userEntity
     * @return
     * user/mine/balance/info
     */
    @RequestMapping(value = "/mine/balance/info", method = RequestMethod.POST)
    @ResponseBody
    public ResponseWrapper getMineBalanceInfo(@CurrentUser UserEntity userEntity) {
        double money=userService.refreshUserBalance(userEntity.getUserId());
        return ResponseWrapper.succeed(money);
    }


    /**
     * 获取绑卡信息
     * @param user
     * @return
     */
    @Authorization
    @RequestMapping(value = "/mine/card/info", method = RequestMethod.POST)
    @ResponseBody
    public ResponseWrapper getMineGameInfo(@CurrentUser UserEntity user) {
        CardEntity cardEntity=cardService.getCardInfo(user.getUserId());
        return ResponseWrapper.succeed(cardEntity);
    }

    /**
     * 绑定银行卡
     * @param userEntity
     * @param params
     * @return
     */
    @Authorization
    @RequestMapping(value = "/mine/update/card", method = RequestMethod.POST)
    @ResponseBody
    public ResponseWrapper updateMineCardInfo(@CurrentUser UserEntity userEntity, @RequestBody JSONObject params) {

//        System.out.println("userEntity:"+userEntity.toString());
//        System.out.println("params:"+params.toString());

        long bankType = params.getLong("bank_type");
        String cardNo = params.getString("card_no");
        String cardBank = params.getString("card_bank");
        String name = params.getString("name");
        // TODO: 2017/8/21 check params
        CardEntity cardEntity=cardService.updateCardInfo(userEntity.getUserId(), cardNo, cardBank, bankType, name);
        return ResponseWrapper.succeed(cardEntity);
    }


    /**
     * 获取登录游戏的类型
     * @param userEntity
     * @param request
     * @return
     * /user/mine/getUrlByKind
     * token
     * kind_id: 0-大厅  620-德州扑克 720-二八杠 820 牛牛
     *
     */
    @Authorization
    @RequestMapping(value = "/mine/getUrlByKind", method = RequestMethod.POST)
    @ResponseBody
    public ResponseWrapper getUrlByKind(@CurrentUser UserEntity userEntity,@RequestBody JSONObject params,HttpServletRequest request) throws Exception {

//      System.out.println("userEntity:"+userEntity.toString());

        String kind_id=params.getString("kind_id");
        long userId=userEntity.getUserId();
        String ip=StringUtils.getIp(request);

        String url=userService.getUrlByKind(userId,ip,kind_id);

        return ResponseWrapper.succeed(url);
    }






    /**
     * 修改头像
     * @param userEntity
     * @param req
     * @return
     */
    @Authorization
    @RequestMapping(value = "/mine/upload/photo", method = RequestMethod.POST)
    @ResponseBody
    public ResponseWrapper uploadMinePhoto(@CurrentUser UserEntity userEntity, MultipartHttpServletRequest req) {
        MultipartFile file = req.getFile("photo");

        // TODO: 2017/8/21 check

        return ResponseWrapper.succeed(userService.uploadHeadImage(userEntity, file));
    }



    /**
     * 后台用户列表
     * @param params
     * @return
     */
    @RequestMapping(value = "/system/dataGrid", method = RequestMethod.POST)
    public ResponseEntity<DatatablesResult> dataGrid(@RequestBody JSONObject params) {
        int rows = params.getIntValue("length");
        int start = params.getIntValue("start");
        int draw = params.getIntValue("draw");
        int page = (start / rows) + 1;
        try {
            params.put("userType", UserTypeEnum.Client.getCode());
            DatatablesResult datatablesResult = this.userService.selectUserVo(params, page, rows,draw );
            return ResponseEntity.ok(datatablesResult);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
    }


    /**
     * 获取用户详情
     * @param params
     * @return
     * @throws IOException
     */
    @RequestMapping(value = "/system/findById",method = RequestMethod.POST)
    public ResponseEntity findById(@RequestBody JSONObject params) throws IOException{
        ResponseWrapper result;
        try {
            UserResultVo us=new UserResultVo();
            us=userService.selectByUserId(Long.parseLong(params.getString("userId")));


            result = ResponseWrapper.succeed(us);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
        }
        return ResponseEntity.ok(result);
    }



    /**
     * 修改会员信息:电话号码，昵称，业务员，银行卡
     * @param userVo
     * @return
     * @throws IOException
     */
    @RequestMapping(value = "/system/updateUserSomeInfor",method = RequestMethod.POST)
    public ResponseEntity updateUserSomeInfor(UserResultVo userVo) throws IOException{
        ResponseWrapper result;
        try {
            userService.updateUserSomeInfor(userVo);
            result = ResponseWrapper.succeed(true);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
        }
        return ResponseEntity.ok(result);
    }

    /**
     * 充值会员余额
     * @param addbalance
     * @param userId
     * @param remarks
     * @return
     * @throws IOException
     */
    @RequestMapping(value = "/system/updateUserBalance",method = RequestMethod.POST)
    public ResponseEntity updateUserBalance(String addbalance,String userId,String remarks,String updateBy) throws IOException{
        ResponseWrapper result;
        try {
            userAccountService.updateUserBalance(addbalance,userId,remarks,updateBy);
            result = ResponseWrapper.succeed(true);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
        }
        return ResponseEntity.ok(result);
    }


    /**
     * 获取客服列表--ajax全部时间
     * @return
     * @throws IOException
     * ss_agent/getBeUserList
     */
    @RequestMapping(value = "/system/getBeUserList",method = RequestMethod.POST)
    public ResponseEntity getBeUserList() throws IOException {
        ResponseWrapper result;
        try {
            UserEntity userEntity=new UserEntity();
            userEntity.setIsDelete(0);
            userEntity.setRoleId((long) RoleTypeEnum.Salesman.getCode());
            EntityWrapper<UserEntity> wrapper = new EntityWrapper<UserEntity>(userEntity);
            List<UserEntity> userEntities=userService.selectList(wrapper);
            result = ResponseWrapper.succeed(userEntities);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
        }
        return ResponseEntity.ok(result);
    }

    /**
     * 客服列表
     * @param params
     * @return
     */
    @RequestMapping(value = "/system/ywdataGrid", method = RequestMethod.POST)
    public ResponseEntity<DatatablesResult> ywdataGrid(@RequestBody JSONObject params) {
        int rows = params.getIntValue("length");
        int start = params.getIntValue("start");
        int draw = params.getIntValue("draw");
        int page = (start / rows) + 1;
        try {
            params.put("roleId", RoleTypeEnum.Salesman.getCode());
            params.put("userType",UserTypeEnum.SystemUser.getCode());
            DatatablesResult datatablesResult = this.userService.selectUserVo(params, page, rows,draw );
            return ResponseEntity.ok(datatablesResult);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
    }


    /**
     * 账号列表
     * @param params
     * @return
     */
    @RequestMapping(value = "/system/xtdataGrid", method = RequestMethod.POST)
    public ResponseEntity<DatatablesResult> zhdataGrid(@RequestBody JSONObject params) {
        int rows = params.getIntValue("length");
        int start = params.getIntValue("start");
        int draw = params.getIntValue("draw");
        int page = (start / rows) + 1;
        try {
            params.put("userType",UserTypeEnum.SystemUser.getCode());
            DatatablesResult datatablesResult = this.userService.selectUserVo(params, page, rows,draw );
            return ResponseEntity.ok(datatablesResult);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
    }


    /**
     * 判断当前登录账号是否存在
     * @param loginName
     * @return
     * @throws IOException
     * ss_user/loginNameIsHave
     */
    @RequestMapping(value = "/system/loginNameIsHave",method = RequestMethod.POST)
    public ResponseEntity updateUserForXt(String loginName ) throws IOException{
        ResponseWrapper result;
        try {
            UserEntity starship_userEntity=new UserEntity();
            starship_userEntity.setLoginName(loginName);
            EntityWrapper<UserEntity> wrapper = new EntityWrapper<UserEntity>(starship_userEntity);
            List<UserEntity> selectList = userService.selectList(wrapper);
            boolean flag=true;
            if(selectList.size() >0){
                flag=false;
            }
            result = ResponseWrapper.succeed(flag);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
        }
        return ResponseEntity.ok(result);
    }



    /**
     * 新增用户信息
     * @param userEntity
     * @return
     * @throws IOException
     */
    @RequestMapping(value = "/system/addUserForXt",method = RequestMethod.POST)
    public ResponseEntity addUserForXt(UserEntity userEntity) throws IOException{
        ResponseWrapper result;
        try {
            userEntity.setCreateDate( new Timestamp(new Date().getTime()));
            userEntity.setPassWord(StringUtils.getMD5String(userEntity.getPassWord()));
            boolean n=userService.insert(userEntity);
            result = ResponseWrapper.succeed(n);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
        }
        return ResponseEntity.ok(result);
    }

    /**
     * 修改用户信息
     * @param userEntity
     * @return
     * @throws IOException
     */
    @RequestMapping(value = "/system/updateUserForXt",method = RequestMethod.POST)
    public ResponseEntity updateUserForXt(UserEntity userEntity) throws IOException{
        ResponseWrapper result;
        try {
            if(userEntity.getPassWord() != null && !userEntity.getPassWord().equals("")){
                userEntity.setPassWord(StringUtils.getMD5String(userEntity.getPassWord()));
            }
            boolean n=userService.updateById(userEntity);
            result = ResponseWrapper.succeed(n);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
        }
        return ResponseEntity.ok(result);
    }

    /**
     * 修改用户状态
     * @param userId
     * @param userStatus
     * @return
     * @throws IOException
     */
    @RequestMapping(value = "/system/updateUserForStatus",method = RequestMethod.POST)
    public ResponseEntity updateUserForStatus(String userId,String userStatus) throws IOException{
        ResponseWrapper result;
        try {
            UserEntity starship_userEntity=new UserEntity();
            starship_userEntity.setUserId(Long.parseLong(userId));
            starship_userEntity.setUserStatus(userStatus.equals("1")? UserStatusEnum.Locked:UserStatusEnum.Normall);
            boolean n=userService.updateById(starship_userEntity);
            result = ResponseWrapper.succeed(n);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
        }
        return ResponseEntity.ok(result);
    }


    /**
     * 修改用户密码
     * @param userId
     * @param passWord
     * @param messageCode
     * @return
     * @throws IOException
     */
    @RequestMapping(value = "/system/updatePassword",method = RequestMethod.POST)
    public ResponseEntity updatePassword(String userId,String passWord,String messageCode) throws IOException{
        ResponseWrapper result;
        try {
            userService.updatePassword(userId,passWord,messageCode);
            result = ResponseWrapper.succeed(true);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
        }
        return ResponseEntity.ok(result);
    }




}
