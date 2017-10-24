package com.kk.service.impl;


import com.alibaba.fastjson.JSON;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.kk.commons.Exception.ApiException;
import com.kk.commons.secret.ITokenManager;
import com.kk.commons.utils.*;
import com.kk.entity.BankEntity;
import com.kk.entity.CardEntity;
import com.kk.entity.UserAccountEntity;
import com.kk.entity.UserEntity;
import com.kk.entity.vo.*;
import com.kk.enums.*;
import com.kk.kygame.GameRsp;
import com.kk.kygame.IGameConnector;
import com.kk.kygame.dentity.DBack;
import com.kk.mapper.BankMapper;
import com.kk.mapper.UserAccountMapper;
import com.kk.mapper.UserMapper;
import com.kk.message.SmsAdapter;
import com.kk.redis.RedisHelper;
import com.kk.result.DatatablesResult;
import com.kk.service.ICardService;
import com.kk.service.IUserService;
import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.apache.log4j.LogManager;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;


/**
 * Created by Administrator on 2017/8/17.
 *
 */

@Service
@Transactional
public class UserService extends ServiceImpl<UserMapper,UserEntity> implements IUserService{

    Logger logger = LoggerFactory.getLogger(UserService.class);

    private static final org.apache.log4j.Logger GAMES = LogManager.getLogger("kkgames");


    @Autowired
    private JedisPool jedisPool;
    @Autowired
    private ITokenManager tokenManager;


    @Autowired
    private SystemConfig systemConfig;

    @Autowired
    private IGameConnector gameConnector;

    @Autowired
    private BankMapper bankMapper;

    @Autowired
    private ICardService userCardService;

    @Autowired
    private UserMapper userMapper;
    @Autowired
    private UserAccountMapper userAccountMapper;


    /**
     * 账号密码登录
     * @param phone
     * @param password 密码
     * @return
     * @throws ApiException
     */
    @Override
    public LoginResultVo passwordLogin(String phone, String password ,String ip) throws ApiException {
        Map<String, Object> map = new HashMap<>();
        map.put("login_name",phone);
        List<UserEntity> list = userMapper.selectByMap(map);
        UserEntity user;
        if(list.size() == 0){
            throw new ApiException(ErrorCodeEnum.UserNotFind);
        }else {
            user = list.get(0);
            if(!user.getPassWord().equals(MD5Util.getMD5StrByKK(password))){
                throw new ApiException(ErrorCodeEnum.PasswordError);
            }
        }
        String kyAccount=user.getKyAccount();
         String url="";
        try {
            GameRsp<Object> gameRsp=gameConnector.login( kyAccount,"0",ip,phone,KindIdEnum.Hall.getCode());
            DBack dBack= JSON.parseObject(JSONObject.toJSONString(gameRsp.getD()), DBack.class);
            if(dBack.getCode() == 0){
                url=dBack.getUrl();
            }else{
                GAMES.info("账号密码登录失败："+dBack.toString());
                throw new ApiException(ErrorCodeEnum.LoginError);
            }
        }catch (Exception e){
            e.printStackTrace();
            throw new ApiException(ErrorCodeEnum.SystemError);
        }
        if(url.equals("")){
            throw new ApiException(ErrorCodeEnum.UserNotFind);
        }
        user.setLastTime(new Timestamp(System.currentTimeMillis()));
        user.setUpdateBy(user.getUserId());
        user.setUpdateDate(new Timestamp(System.currentTimeMillis()));
        user.setKyUrl(url);
        userMapper.updateById(user);
        String token = tokenManager.createToken(user.getUserId(),Long.parseLong(phone)).getToken();//7天过期，登录成功会自动续期
        LoginResultVo resultVo = new LoginResultVo();
        resultVo.setUserId(user.getUserId());
        resultVo.setToken(token);
        resultVo.setUrl(url);
        return resultVo;
    }


    /**
     * 注册
     * @param phone
     * @param code
     * @param kyAccount--用来注册开元的
     * @param ip
     * @param passWord
     * @return
     * @throws ApiException
     */
    @Override
    public LoginResultVo register(String phone, String code,String kyAccount,String ip,String passWord) throws Exception {
        String key = ConstantInterface.KEY_SMS_CAPTCHA + phone;

        String captcha = jedisPool.getResource().get(key);
        if (StringUtils.isEmpty(captcha)) {
            throw new ApiException(ErrorCodeEnum.CaptchaInvalidError);
        }else if(!captcha.equals(code)){
            throw new ApiException(ErrorCodeEnum.CaptchaErrorException);
        }

        if(kyAccount == null || kyAccount.equals("")){
            throw new ApiException(ErrorCodeEnum.KyUserCreateException);
        }

        /**
         * 判断用户名是否一样在开元上
         */
        Map<String, Object> map2 = new HashMap<>();
        map2.put("ky_account",phone);
        List<UserEntity> accountlist = userMapper.selectByMap(map2);
        if(accountlist.size() >0 ){
            throw new ApiException(ErrorCodeEnum.UserHavingFind);
        }

        UserEntity user;
        Map<String, Object> map = new HashMap<>();
        map.put("login_name",phone);
        map.put("user_type",UserTypeEnum.Client.getCode());
        List<UserEntity> list = userMapper.selectByMap(map);
        if(list.size() == 0){
            user = new UserEntity();
            user.setLoginName(phone);
            user.setPassWord(MD5Util.getMD5StrByKK(passWord));
            user.setGender(GenderEnum.Unknown);
            user.setNickName(kyAccount);
            user.setPhone(phone);
            user.setUserStatus(UserStatusEnum.Normall);
            user.setUserType(UserTypeEnum.Client);
            user.setLastTime(new Timestamp(System.currentTimeMillis()));
            user.setCreateDate(new Timestamp(System.currentTimeMillis()));
            // related to customer service
            Map<String, Object> customerServiceMap = new HashMap<>();
            customerServiceMap.put("role_id", RoleTypeEnum.Salesman.getCode());
            customerServiceMap.put("is_delete","0");
            customerServiceMap.put("user_status", "0");
            List<UserEntity> customerServiceList = userMapper.selectByMap(customerServiceMap);
            if (customerServiceList.size() == 0) {
                logger.error("没有一个客服角色可供使用!");
            }else{
                long customerServiceUserId = customerServiceList.get(new Random().nextInt(customerServiceList.size())).getUserId();
                user.setBeUserId(customerServiceUserId);
            }
        }else {
            throw new ApiException(ErrorCodeEnum.UserHavingFind);
        }

        String url="";
        /**
         * 开元平台注册
         */
        GameRsp<Object> gameRsp=gameConnector.login( kyAccount,"0",ip,StringUtils.lineCode,KindIdEnum.Hall.getCode());
        GAMES.info("【"+kyAccount+"】注册信息："+gameRsp.toString());
        DBack dBack= JSON.parseObject(JSONObject.toJSONString(gameRsp.getD()), DBack.class);
        if(dBack.getCode() == 0){
            url=dBack.getUrl();
        }else{
            throw new ApiException(ErrorCodeEnum.KyUserCreateException);
        }
        user.setKyAccount(kyAccount);
        user.setKyUrl(url);
        userMapper.insert(user);
        //7天过期，登录成功会自动续期
        String token = tokenManager.createToken(user.getUserId(),Long.parseLong(user.getPhone())).getToken();
        LoginResultVo resultVo = new LoginResultVo();
        resultVo.setUserId(user.getUserId());
        resultVo.setToken(token);
        resultVo.setUrl(url);
        resultVo.setUserType(UserTypeEnum.Client.getCode());
        return resultVo;
    }


    /**
     * 退出登录
     * @param userEntity
     * @throws ApiException
     */
    @Override
    public void logout(UserEntity userEntity) throws ApiException {
        tokenManager.deleteToken(userEntity.getUserId());
    }


    /**
     * 游客登录
     * @param device 设备ID
     * @return
     * @throws ApiException
     */
    public LoginResultVo visitorLogin(String device,String ip) throws Exception {
        LoginResultVo resultVo = new LoginResultVo();

        String touristMoney="500";//游客登录获取到的金额

        //生成一条游客登录的记录
        String kyAccount="游客_"+device;
        /**
         * 判断用户名是否一样在开元上
         */
        UserEntity userEntity=new UserEntity();
        Map<String, Object> map2 = new HashMap<>();
        map2.put("ky_account",kyAccount);
        List<UserEntity> accountlist = userMapper.selectByMap(map2);
        if(accountlist.size() >0 ){
            userEntity=accountlist.get(0);
            touristMoney="0";
        }else{
            userEntity.setLoginName(kyAccount);
            userEntity.setGender(GenderEnum.Unknown);
            userEntity.setNickName(kyAccount);
            userEntity.setUserStatus(UserStatusEnum.Normall);
            userEntity.setUserType(UserTypeEnum.Tourist);
            userEntity.setLastTime(new Timestamp(System.currentTimeMillis()));
            userEntity.setCreateDate(new Timestamp(System.currentTimeMillis()));
            userEntity.setKyAccount(kyAccount);
            // related to customer service
            Map<String, Object> customerServiceMap = new HashMap<>();
            customerServiceMap.put("role_id", RoleTypeEnum.Salesman.getCode());
            customerServiceMap.put("is_delete","0");
            customerServiceMap.put("user_status", "0");
            List<UserEntity> customerServiceList = userMapper.selectByMap(customerServiceMap);
            if (customerServiceList.size() == 0) {
                logger.error("没有一个客服角色可供使用!");
            }else{
                long customerServiceUserId = customerServiceList.get(new Random().nextInt(customerServiceList.size())).getUserId();
                userEntity.setBeUserId(customerServiceUserId);
            }
            userMapper.insert(userEntity);
        }
        String url="";
        /**
         * 开元平台注册
         */
        GameRsp<Object> gameRsp=gameConnector.loginByVisitor( kyAccount,touristMoney,ip,StringUtils.lineCode,KindIdEnum.Hall.getCode());
        GAMES.info("【"+kyAccount+"】注册信息："+gameRsp.toString());
        DBack dBack= JSON.parseObject(JSONObject.toJSONString(gameRsp.getD()), DBack.class);
        if(dBack.getCode() == 0){
            url=dBack.getUrl();
        }else{
            throw new ApiException(ErrorCodeEnum.KyUserCreateException);
        }

        //TODO 游客登录
            //设备号只能登录1  次
//        Jedis jedis = null;
//        boolean flag=false;
//        try{
//            jedis = RedisHelper.getJedis();
//            if(jedis.exists(device)){
//                String loginCount=jedis.get(device);
//                if(Integer.parseInt(loginCount) >= 5){
//                    flag=true;
//                }else{
//                    loginCount=String.valueOf(Integer.parseInt(loginCount)+1);
//                    jedis.set(device,loginCount);
//                }
//            }else{
//                jedis.set("visitor:"+device,"1");
//            }
//        }catch (Exception e){
//            RedisHelper.returnBrokenResource(jedis);
//        }finally {
//            RedisHelper.returnResource(jedis);
//        }
//        if(flag){
//            throw new ApiException(ErrorCodeEnum.NotRegirstUser);
//        }
        String token = tokenManager.createToken(userEntity.getUserId(),0L).getToken();
        resultVo.setUserId(userEntity.getUserId());
        resultVo.setToken(token);
        resultVo.setUrl(url);
        resultVo.setUserType(UserTypeEnum.Tourist.getCode());
        return resultVo;
    }



    /**
     * 忘记密码
     * @param phone
     * @param password
     * @return
     * @throws ApiException
     */
    @Override
    public void forgetpassword(String phone,String code,String password) throws Exception {
        String key = ConstantInterface.KEY_SMS_CAPTCHA + phone;

        String captcha = jedisPool.getResource().get(key);
        if (StringUtils.isEmpty(captcha)) {
            throw new ApiException(ErrorCodeEnum.CaptchaInvalidError);
        }else if(!captcha.equals(code)){
            throw new ApiException(ErrorCodeEnum.CaptchaErrorException);
        }

        UserEntity user;
        Map<String, Object> map = new HashMap<>();
        map.put("login_name",phone);
        map.put("user_type",UserTypeEnum.Client.getCode());
        List<UserEntity> list = userMapper.selectByMap(map);
        if(list.size() == 0){
            throw new ApiException(ErrorCodeEnum.UserNotFind);
        }
        user=list.get(0);
        user.setPassWord(MD5Util.getMD5StrByKK(password));
        int n=userMapper.updateById(user);
        if(n == 0){
            throw new ApiException(ErrorCodeEnum.UpdatePasswordError);
        }
    }






    /**
     * 获取设备的登录次数
     * @param device 设备ID
     * @return
     * @throws ApiException
     */
    @Override
    public FirstVo getLoginCount(String device) throws ApiException {
        FirstVo firstVo = new FirstVo();
        int loginCount=1;
//      Jedis jedis = null;
        try{
//            jedis = RedisHelper.getJedis();
//            if(jedis.exists("visitor:"+device)){
//                loginCount=loginCount-Integer.parseInt(jedis.get("visitor:"+device));
//            }
            firstVo.setLoginCount(String.valueOf(loginCount));

            Map<String, Object> customerServiceMap = new HashMap<>();
            customerServiceMap.put("role_id", RoleTypeEnum.Salesman.getCode());
            customerServiceMap.put("is_delete","0");
            customerServiceMap.put("user_status", "0");
            List<UserEntity> customerServiceList = userMapper.selectByMap(customerServiceMap);
            if (customerServiceList.size() == 0) {
                logger.error("没有一个客服角色可供使用!");
            }else{
                firstVo.setBeUserPhone(customerServiceList.get(0).getPhone());
                firstVo.setBeUserQq(customerServiceList.get(0).getQq());
            }
        }catch (Exception e){
            e.printStackTrace();
//            RedisHelper.returnBrokenResource(jedis);
        }finally {
//            RedisHelper.returnResource(jedis);
        }
        return firstVo;
    }


    /**
     * 获取最新账户信息
     * @param userEntity
     * @return
     * @throws ApiException
     */
    @Override
    public UserWebVo getUserInfo(UserEntity userEntity) throws ApiException {

        this.refreshUserBalance(userEntity.getUserId());

        UserWebVo vo = userMapper.getUserInfo(userEntity.getUserId());

        if(vo.getCardId() == null){
            //获取银行卡类型
            Map<String, Object> bankMap = new HashMap<>();
            bankMap.put("is_delete", 0);
            List<BankEntity> bankEntityList = bankMapper.selectByMap(bankMap);
            vo.setBankEntityList(bankEntityList);

        }

        return vo;
    }

    /**
     * 获取账户余额
     * @param userId
     * @return
     */
    public Double refreshUserBalance(long userId){
        Double balance=0D;
        UserEntity user = userMapper.selectById(userId);
        // 如果更新余额失败，其他数据正常处理，不认为是失败
        try {
            /**
             * 获取开元账号余额
             */
            GameRsp<Object> gameRsp;
            if(user.getUserType().getCode() == UserTypeEnum.Tourist.getCode()){
                gameRsp=gameConnector.gamesAllBalanceVisitor(user.getKyAccount());
            }else{
                gameRsp= gameConnector.gamesAllBalance(user.getKyAccount());
            }
            GAMES.info("【"+user.getKyAccount()+"】获取余额信息："+gameRsp.toString());
            DBack  dBack= JSON.parseObject(JSONObject.toJSONString(gameRsp.getD()), DBack.class);
            if(dBack.getCode() == 0){
                balance=dBack.getFreeMoney();
            }

            //判断
            Map<String,Object> whereMap = new HashMap<>();
            whereMap.put("user_id",user.getUserId());
            whereMap.put("is_delete",0);
            List<UserAccountEntity> temp = userAccountMapper.selectByMap(whereMap);
            UserAccountEntity accountEntity;
            if(temp.size()==0){
                accountEntity = new UserAccountEntity();
                accountEntity.setUserId(user.getUserId());
                accountEntity.setBalance(balance);
                accountEntity.setCurrency(CurrencyEnum.CNY);
                accountEntity.setActype(1);
                accountEntity.setCreateBy(user.getUserId());
                accountEntity.setCreateDate(new Timestamp(System.currentTimeMillis()));
                accountEntity.setUpdateBy(user.getUserId());
                accountEntity.setUpdateDate(new Timestamp(System.currentTimeMillis()));
                accountEntity.setIsDelete(0);
                userAccountMapper.insert(accountEntity);
            }else {
                accountEntity = temp.get(0);
                accountEntity.setBalance(balance);
                int ret = userAccountMapper.updateById(accountEntity);
                if (ret < 1) {
                    logger.error("【"+accountEntity.toString()+"】更新余额失败！");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("获取余额数据异常！",e);
            balance = null;
        }

        return balance;
    }


//    /**
//     * 修改密码
//     * @param userEntity
//     * @param password
//     * @return
//     * @throws ApiException
//     */
//    @Override
//    public int updateUserInfo(UserEntity userEntity, String password) throws ApiException {
//       userEntity.setPassWord(password);
//        int ret = userMapper.updateById(userEntity);
//        if (ret == 0) {
//            throw new ApiException(-1, "更新信息失败!");
//        }
//        return ret;
//    }

    /**
     * 进入游戏大厅
     * @param userId
     * @param ip
     * @param kind_id
     * @return
     * @throws Exception
     */
    @Override
    public String getUrlByKind(long userId,String ip,String kind_id) throws Exception {

        if(Integer.parseInt(kind_id) == KindIdEnum.Taurus.getCode()){
            throw new ApiException(ErrorCodeEnum.ThisGameNotOpen);
        }

        if(Integer.parseInt(kind_id) != KindIdEnum.TexasHoldem.getCode() &&  Integer.parseInt(kind_id) != KindIdEnum.Bar.getCode()){
            throw new ApiException(ErrorCodeEnum.ThisGameNotOpen);
        }

        UserEntity userEntity=userMapper.selectById(userId);
        if(userEntity == null){
            throw new ApiException(ErrorCodeEnum.UserNotFind);
        }
        String kyAccount=userEntity.getKyAccount();
        String url="";
        /**
         * 开元平台获取游戏大厅地址
         */
        GameRsp<Object> gameRsp;
        DBack dBack;
        if(userEntity.getUserType().getCode() == 2){
            gameRsp=gameConnector.loginByVisitor( kyAccount,"0",ip,StringUtils.lineCode,Integer.parseInt(kind_id));
            dBack= JSON.parseObject(JSONObject.toJSONString(gameRsp.getD()), DBack.class);
        }else {
            gameRsp=gameConnector.login( kyAccount,"0",ip,StringUtils.lineCode,Integer.parseInt(kind_id));
            dBack= JSON.parseObject(JSONObject.toJSONString(gameRsp.getD()), DBack.class);
        }
        if(dBack.getCode() == 0){
            url=dBack.getUrl();
        }else{
            GAMES.info("进入游戏大厅失败："+dBack.toString());
            throw new ApiException(ErrorCodeEnum.LoginError);
        }
        return url;
    }


    @Override
    public String uploadHeadImage(UserEntity userEntity, MultipartFile file) throws ApiException {
        try {
//            boolean ret = FTPClientUtil.uploadImage("", String.valueOf(userEntity.getUserId()), file.getInputStream());
//            if (!ret) {
//                throw new ApiException(-1 , "上传头像失败!");
//            }
            PicUploadResult result = FileUploadUtil.imgUpload(file, false, "", "");
            if (result.getError() == 0) {
                String url = result.getUrl();
                userEntity.setHeadUrl(url);
                // update
                int n = userMapper.updateById(userEntity);
                if (n > 0) {
                    return systemConfig.getURL_BASE_IMG() + url;
                } else {
                    throw new ApiException(-1, "");
                }
            } else {
                throw new ApiException(-1, "上传头像图片无效!");
            }
        } catch (IOException e) {
            e.printStackTrace();
            throw new ApiException(-1 , "获取头像数据失败!");
        } catch (ApiException e) {
            e.printStackTrace();
            throw e;
        } catch (Exception e) {
            e.printStackTrace();
            throw new ApiException(-1, "上传头像图片解析异常!");
        }
    }

    //========================================== 总后台的==================================================


    public void updateUserSomeInfor(UserResultVo userVo) {
        //判断是否有银行卡
        CardEntity cardEntity=new CardEntity();
        cardEntity.setCardBank(userVo.getCardBank());
        cardEntity.setCardName(userVo.getCardName());
        cardEntity.setCardNo(userVo.getCardNo());
        cardEntity.setUpdateBy(userVo.getUpdateBy());
        cardEntity.setBankType(Long.parseLong(userVo.getBankType()));
        boolean flag=true;
        if(userVo.getCardId() == null){
            cardEntity.setUserId(userVo.getUserId());
            flag=userCardService.insert(cardEntity);
        }else {
            cardEntity.setCardId(userVo.getCardId());
            flag=userCardService.updateById(cardEntity);
        }
        UserEntity starship_userEntity=new UserEntity();
        starship_userEntity.setUserId(userVo.getUserId());
        starship_userEntity.setNickName(userVo.getNickName());
        starship_userEntity.setPhone(userVo.getPhone());
        starship_userEntity.setBeUserId(userVo.getBeUserId());
        starship_userEntity.setUpdateBy(userVo.getUpdateBy());
        int n=userMapper.updateById(starship_userEntity);
        if(n == 0 && !flag){
            throw new ApiException(ErrorCodeEnum.SystemBusy);
        }
    }


    /**
     * 查看用户详情
     *
     * @param userId
     * @return
     */
    public UserResultVo selectByUserId(Long userId) {
        //先刷新账户余额
        this.refreshUserBalance(userId);

        UserResultVo user = userMapper.selectByUserId(userId);

        //获取未被删除记录的业务员列表
        UserEntity userEntity=new UserEntity();
        userEntity.setIsDelete(0);
        userEntity.setRoleId((long) RoleTypeEnum.Salesman.getCode());
        EntityWrapper<UserEntity> wrapper = new EntityWrapper<UserEntity>(userEntity);
        List<UserEntity> bulist=userMapper.selectList(wrapper);
        user.setBeuserList(bulist);

        //获取银行卡类型
        Map<String, Object> bankMap = new HashMap<>();
        bankMap.put("is_delete", 0);
        List<BankEntity> bankEntityList = bankMapper.selectByMap(bankMap);
        user.setBankEntityList(bankEntityList);

        return user;
    }

    /**
     * 根据用户名称获取实体
     * @param userVo
     * @return
     */
    public  UserEntity selectByLoginName(UserResultVo userVo) {
        UserEntity user = new UserEntity();
        user.setLoginName(userVo.getLoginName());
        user.setPassWord(userVo.getPassWord());
        user=userMapper.selectOne(user);
        return user;
    }

    /**
     * 获取用户列表
     * @param params
     * @param page
     * @param rows
     * @param draw
     * @return
     */
    public DatatablesResult<UserResultVo> selectUserVo(JSONObject params, Integer page, Integer rows, Integer draw) {
        PageHelper.startPage(page, rows);
        Map<String,String> whereMap = cmsUtil.toHashMap(params);
        List<UserResultVo> userlistVos = this.userMapper.selectUserListVoPage(whereMap);
        PageInfo<UserResultVo> pageInfo = new PageInfo<UserResultVo>(userlistVos);
        DatatablesResult pageResult = new DatatablesResult<UserResultVo>();
        pageResult.setData(userlistVos);
        pageResult.setDraw(draw);
        pageResult.setRecordsTotal((int)pageInfo.getTotal());
        pageResult.setRecordsFiltered(pageResult.getRecordsTotal());
        return pageResult;
    }

    @Override
    public void updatePassword(String userId, String passWord, String messageCode) {
        UserEntity userEntity=userMapper.selectById(Long.parseLong(userId));
        if(userEntity == null){
            throw new ApiException(ErrorCodeEnum.UserNotFind);
        }
        if(userEntity.getRoleId() == RoleTypeEnum.Agent.getCode()){String key = ConstantInterface.KEY_SMS_CAPTCHA + userEntity.getPhone();
            String captcha = jedisPool.getResource().get(key);
            if (StringUtils.isEmpty(captcha)) {
                throw new ApiException(ErrorCodeEnum.CaptchaInvalidError);
            }else if(!captcha.equals(messageCode)){
                throw new ApiException(ErrorCodeEnum.CaptchaErrorException);
            }
        }
        userEntity.setPassWord(MD5Util.getMD5Str(passWord));
        int n=userMapper.updateById(userEntity);
        if(n ==0){
            throw new ApiException(ErrorCodeEnum.RepetitiveException);
        }
    }

    @Override
    public AgentVo getAgentLoginId(String bgLoginId) {
        AgentVo starship_agentrVo=userMapper.getAgentId(bgLoginId);
        return starship_agentrVo;
    }




}
