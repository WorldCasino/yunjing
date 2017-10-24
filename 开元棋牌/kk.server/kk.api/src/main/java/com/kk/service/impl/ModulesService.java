package com.kk.service.impl;



import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.kk.entity.ModulesEntity;
import com.kk.mapper.ModulesMapper;
import com.kk.service.IModulesService;
import org.springframework.stereotype.Service;

@Service
public class ModulesService extends ServiceImpl<ModulesMapper, ModulesEntity> implements IModulesService {}
