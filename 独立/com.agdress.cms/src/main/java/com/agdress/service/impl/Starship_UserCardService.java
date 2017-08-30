package com.agdress.service.impl;



import com.agdress.entity.Starship_UserCardEntity;
import com.agdress.mapper.Starship_UserCardMapper;


import com.agdress.service.Starship_IUserCardService;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;



/**
 * Created by Administrator on 2017/8/17.
 *
 */

@Service
@Transactional
public class Starship_UserCardService extends ServiceImpl<Starship_UserCardMapper,Starship_UserCardEntity> implements Starship_IUserCardService {


}
