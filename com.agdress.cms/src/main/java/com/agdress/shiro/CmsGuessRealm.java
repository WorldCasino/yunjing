package com.agdress.shiro;




import com.agdress.commons.utils.StringUtils;
import com.agdress.entity.Starship_RoleEntity;
import com.agdress.entity.Starship_UserEntity;
import com.agdress.mapper.Starship_RoleMapper;
import com.agdress.mapper.Starship_UserMapper;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.subject.SimplePrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;


import java.util.*;

public class CmsGuessRealm extends AuthorizingRealm {

	@Autowired
	private Starship_UserMapper userMapper;

	@Autowired
	private Starship_RoleMapper roleMapper;

	@Override
	protected AuthorizationInfo doGetAuthorizationInfo( PrincipalCollection principals) {
		ShiroUser shiroUser = (ShiroUser) principals.getPrimaryPrincipal();
 		SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
		info.setRoles(shiroUser.getRoles());
		info.addStringPermissions(shiroUser.getModulesSet());
		return info;
	}

	@Override
	protected AuthenticationInfo doGetAuthenticationInfo( AuthenticationToken authcToken) throws AuthenticationException {
		UsernamePasswordToken token = (UsernamePasswordToken) authcToken;
 		Starship_UserEntity userEntity = new Starship_UserEntity();
		userEntity.setLoginName(token.getUsername());
		userEntity.setIs_delete(0);
		userEntity=userMapper.selectOne(userEntity);
		// 账号不存在
		if (userEntity == null) {
			return null;
		}
 		// 账号未启用
		if (userEntity.getUser_status() == 1) {
			return null;
		}
 		// 读取用户的url和角色
		Map<String, Set<String>> resourceMap = new HashMap<String, Set<String>>();
		Set<String> modSet = new HashSet<String>();
		Set<String> roles = new HashSet<String>();
		String[] str=String.valueOf(userEntity.getRole_id()).split(",");
		for (int i = 0; i < str.length; i++) {
			if(!str[i].trim().equals("")){
				Long roleId=Long.parseLong(str[i]);
				List<Map<Long, String>> resourceList = roleMapper.selectModulesListByRoleId(roleId);
				if (resourceList != null) {
					for (Map<Long, String> map : resourceList) {
						if (StringUtils.isNotBlank(map.get("modulstr"))) {
							modSet.add(map.get("modulstr"));
						}
 					}
				}
				Starship_RoleEntity role = roleMapper.selectById(roleId);
				if (role != null) {
					roles.add(String.valueOf(role.getRoleId()));
				}
			}
		}
		ShiroUser shiroUser = new ShiroUser(userEntity.getUserId(), userEntity.getLoginName(),userEntity.getNickname(), modSet);
		shiroUser.setRoles(roles);
		shiroUser.setRolesstr(String.valueOf(userEntity.getRole_id()));
 		String password= userEntity.getPassWord();
		return new SimpleAuthenticationInfo(shiroUser,password.toCharArray(), getName());
	}

	@Override
	public void onLogout(PrincipalCollection principals) {
		super.clearCachedAuthorizationInfo(principals);
		ShiroUser shiroUser = (ShiroUser) principals.getPrimaryPrincipal();
		removeUserCache(shiroUser);
	}

	/**
	 * 清除用户缓存
	 * 
	 * @param shiroUser
	 */
	public void removeUserCache(ShiroUser shiroUser) {
		removeUserCache(shiroUser.getLoginName());
	}

	/**
	 * 清除用户缓存
	 * 
	 * @param loginName
	 */
	public void removeUserCache(String loginName) {
		SimplePrincipalCollection principals = new SimplePrincipalCollection();
		principals.add(loginName, super.getName());
		super.clearCachedAuthenticationInfo(principals);
	}

}
