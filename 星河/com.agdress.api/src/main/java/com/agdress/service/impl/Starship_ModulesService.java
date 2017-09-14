package com.agdress.service.impl;




import com.agdress.entity.Starship_ModulesEntity;
import com.agdress.mapper.Starship_ModulesMapper;
import com.agdress.mapper.Starship_RoleMapper;
import com.agdress.result.TreeResult;

import com.agdress.service.Starship_IModulesService;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;

@Service
public class Starship_ModulesService extends ServiceImpl<Starship_ModulesMapper, Starship_ModulesEntity> implements Starship_IModulesService {}
