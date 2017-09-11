package com.agdress.service.impl;


import com.agdress.commons.Exception.ApiException;
import com.agdress.commons.utils.cmsUtil;
import com.agdress.entity.BankEntity;
import com.agdress.entity.Starship_UserCardEntity;
import com.agdress.entity.Starship_UserEntity;
import com.agdress.entity.vo.Starship_UserVo;
import com.agdress.entity.vo.Starship_UserlistVo;
import com.agdress.enums.ErrorCodeEnum;
import com.agdress.mapper.BankMapper;
import com.agdress.mapper.Starship_UserMapper;
import com.agdress.result.DatatablesResult;
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

    @Override
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

    @Override
    public Starship_UserVo selectByUserId(Long userId) {
         Starship_UserVo user=userMapper.selectByUserId(userId);
        //获取未被删除记录的业务员列表
        Starship_UserEntity userEntity=new Starship_UserEntity();
        userEntity.setIsDelete(0);
        userEntity.setRoleId((long) 3);
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
    @Override
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
    @Override
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







}
