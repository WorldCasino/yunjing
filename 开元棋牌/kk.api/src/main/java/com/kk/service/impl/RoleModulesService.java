package com.kk.service.impl;



import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.kk.entity.RoleModulesEntity;
import com.kk.mapper.RoleModulesMapper;
import com.kk.service.IRoleModulesService;
import org.springframework.stereotype.Service;

@Service
public class RoleModulesService extends ServiceImpl<RoleModulesMapper, RoleModulesEntity> implements IRoleModulesService {}
