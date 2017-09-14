package com.agdress.service.impl;




import com.agdress.commons.utils.CodeFactory;
import com.agdress.commons.utils.DateFormatUtil;
import com.agdress.entity.Starship_UserAccountDetailEntity;
import com.agdress.entity.Starship_UserAccountEntity;
import com.agdress.enums.*;
import com.agdress.mapper.Starship_UserAccountMapper;
import com.agdress.service.IRechargeService;
import com.agdress.service.Starship_IUserAccountService;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


/**
 * Created by Administrator on 2017/8/17.
 *
 */

@Service
@Transactional
public class Starship_UserAccountService extends ServiceImpl<Starship_UserAccountMapper,Starship_UserAccountEntity> implements Starship_IUserAccountService {



    @Autowired
    private IRechargeService rechargeService;

    @Override
    public void updateUserBalance(String addbalance,String userId,String remarks) {

        rechargeService.saveMoneyForUser(Long.parseLong(userId),Double.parseDouble(addbalance),RechargeStatusEnum.RechargeSuccess, CodeFactory.generateRechargeCode(),99999999,remarks);

    }


}
