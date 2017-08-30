package com.agdress.service;



import com.agdress.entity.Starship_ModulesEntity;
import com.agdress.shiro.ShiroUser;
import com.baomidou.mybatisplus.service.IService;


public interface Starship_IModulesService extends IService<Starship_ModulesEntity> {

	Object selectTree(ShiroUser shiroUser);

}
