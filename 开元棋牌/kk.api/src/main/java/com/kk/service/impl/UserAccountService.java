package com.kk.service.impl;



import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.kk.entity.UserAccountEntity;
import com.kk.mapper.UserAccountMapper;
import com.kk.service.IRechargeService;
import com.kk.service.IUserAccountService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


/**
 * Created by Administrator on 2017/8/17.
 *
 */

@Service
@Transactional
public class UserAccountService extends ServiceImpl<UserAccountMapper,UserAccountEntity> implements IUserAccountService {

    @Autowired
    private IRechargeService rechargeService;

    @Override
    public void updateUserBalance(String addbalance,String userId,String remarks,String systemUserId) {

        rechargeService.saveMoneyForUser(Long.parseLong(userId),Double.parseDouble(addbalance),remarks,systemUserId);
    }


}
