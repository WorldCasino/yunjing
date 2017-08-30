package com.agdress.service.impl;


import com.agdress.commons.utils.cmsUtil;
import com.agdress.entity.Starship_UserEntity;
import com.agdress.entity.vo.Starship_UserVo;
import com.agdress.entity.vo.Starship_UserlistVo;
import com.agdress.mapper.Starship_UserMapper;
import com.agdress.result.DatatablesResult;
import com.agdress.service.Starship_IUserService;
import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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


    @Override
    public Starship_UserVo selectByUserId(Long userId) {
        Starship_UserVo user=userMapper.selectByUserId(userId);
        //获取未被删除记录的业务员列表
        Starship_UserEntity userEntity=new Starship_UserEntity();
        userEntity.setIs_delete(0);
        userEntity.setRole_id((long) 3);
        EntityWrapper<Starship_UserEntity> wrapper = new EntityWrapper<Starship_UserEntity>(userEntity);
        List<Starship_UserEntity> bulist=userMapper.selectList(wrapper);
        user.setBeuserlist(bulist);
        return user;
    }


    @Override
    public Starship_UserEntity selectByLoginName(Starship_UserVo userVo) {
        Starship_UserEntity user = new Starship_UserEntity();
        user.setLoginName(userVo.getLoginnumber());
        user.setPassWord(userVo.getPassword());
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
