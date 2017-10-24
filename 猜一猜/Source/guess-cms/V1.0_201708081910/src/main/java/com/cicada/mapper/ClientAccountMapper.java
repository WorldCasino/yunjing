package com.cicada.mapper;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.cicada.pojo.ClientAccountEntity;

/**
 * Created by Administrator on 2017/4/28.
 */
public interface ClientAccountMapper extends BaseMapper<ClientAccountEntity> {

    void updateAccountCoins(ClientAccountEntity accountEntity);
}
