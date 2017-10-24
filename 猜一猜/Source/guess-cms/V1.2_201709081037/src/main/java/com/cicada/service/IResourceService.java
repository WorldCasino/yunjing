package com.cicada.service;

import com.cicada.pojo.Resource;
import com.cicada.shiro.ShiroUser;
import com.baomidou.mybatisplus.service.IService;

public interface IResourceService extends IService<Resource>{

	Object selectTree(ShiroUser shiroUser);

}
