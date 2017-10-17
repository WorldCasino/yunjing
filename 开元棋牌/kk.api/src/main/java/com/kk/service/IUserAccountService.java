package com.kk.service;



import com.baomidou.mybatisplus.service.IService;
import com.kk.entity.UserAccountEntity;

/**
 * Created by Administrator on 2017/8/17.
 *
 */

public interface IUserAccountService extends IService<UserAccountEntity> {

        void updateUserBalance(String addbalance, String userId, String remarks, String systemUserId);

}
