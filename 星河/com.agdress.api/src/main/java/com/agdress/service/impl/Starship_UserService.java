package com.agdress.service.impl;


import com.agdress.commons.Exception.ApiException;
import com.agdress.commons.utils.ConstantInterface;
import com.agdress.commons.utils.MD5Util;
import com.agdress.commons.utils.StringUtils;
import com.agdress.commons.utils.cmsUtil;
import com.agdress.entity.BankEntity;
import com.agdress.entity.Starship_UserCardEntity;
import com.agdress.entity.Starship_UserEntity;
import com.agdress.entity.vo.Starship_AgentrVo;
import com.agdress.entity.vo.Starship_UserVo;
import com.agdress.entity.vo.Starship_UserlistVo;
import com.agdress.enums.ErrorCodeEnum;
import com.agdress.enums.RoleTypeEnum;
import com.agdress.mapper.BankMapper;
import com.agdress.mapper.Starship_UserMapper;
import com.agdress.result.DatatablesResult;
import com.agdress.service.IUserService;
import com.agdress.service.Starship_IUserCardService;
import com.agdress.service.Starship_IUserService;
import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import redis.clients.jedis.JedisPool;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * Created by Administrator on 2017/8/17.
 *
 */

@Service
@Transactional
public class Starship_UserService extends ServiceImpl<Starship_UserMapper,Starship_UserEntity> implements Starship_IUserService {

    @Autowired
    private Starship_UserMapper userMapper;
    @Autowired
    private BankMapper bankMapper;
    @Autowired
    private Starship_IUserCardService userCardService;
    @Autowired
    private IUserService userService;
    @Autowired
    private JedisPool jedisPool;

    public void updateUserSomeInfor(Starship_UserVo userVo) {
        //判断是否有银行卡
        Starship_UserCardEntity cardEntity=new Starship_UserCardEntity();
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
        Starship_UserEntity starship_userEntity=new Starship_UserEntity();
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
    public Starship_UserVo selectByUserId(Long userId) {
        //先刷新账户余额
        userService.refreshUserBalance(userId);

        Starship_UserVo user = userMapper.selectByUserId(userId);

        //获取未被删除记录的业务员列表
        Starship_UserEntity userEntity=new Starship_UserEntity();
        userEntity.setIsDelete(0);
        userEntity.setRoleId((long) RoleTypeEnum.Salesman.getCode());
        EntityWrapper<Starship_UserEntity> wrapper = new EntityWrapper<Starship_UserEntity>(userEntity);
        List<Starship_UserEntity> bulist=userMapper.selectList(wrapper);
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
    public Starship_UserEntity selectByLoginName(Starship_UserVo userVo) {
        Starship_UserEntity user = new Starship_UserEntity();
        user.setLoginName(userVo.getLoginNumber());
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
    public DatatablesResult<Starship_UserlistVo> selectUserVo(JSONObject params, Integer page, Integer rows, Integer draw) {
        PageHelper.startPage(page, rows);
        Map<String,String> whereMap = cmsUtil.toHashMap(params);
        List<Starship_UserlistVo> userlistVos = this.userMapper.selectUserListVoPage(whereMap);
        PageInfo<Starship_UserlistVo> pageInfo = new PageInfo<Starship_UserlistVo>(userlistVos);
        DatatablesResult pageResult = new DatatablesResult<Starship_UserlistVo>();
        pageResult.setData(userlistVos);
        pageResult.setDraw(draw);
        pageResult.setRecordsTotal((int)pageInfo.getTotal());
        pageResult.setRecordsFiltered(pageResult.getRecordsTotal());
        return pageResult;
    }

    @Override
    public void updatePassword(String userId, String passWord, String messageCode) {
        Starship_UserEntity userEntity=userMapper.selectById(Long.parseLong(userId));
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
    public Starship_AgentrVo getAgentLoginId(String bgLoginId) {
        Starship_AgentrVo starship_agentrVo=userMapper.getAgentId(bgLoginId);
         return starship_agentrVo;
    }
}
