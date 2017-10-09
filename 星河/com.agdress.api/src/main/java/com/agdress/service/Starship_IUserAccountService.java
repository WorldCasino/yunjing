package com.agdress.service;


import com.agdress.entity.Starship_UserAccountEntity;
import com.baomidou.mybatisplus.service.IService;

/**
 * Created by Administrator on 2017/8/17.
 *
 */

public interface Starship_IUserAccountService extends IService<Starship_UserAccountEntity> {

        void updateUserBalance(String addbalance,String userId,String remarks,String systemUserId);

}
