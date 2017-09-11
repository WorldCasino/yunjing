package com.cicada.shiro;

import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.subject.SimplePrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;

import com.cicada.pojo.User;
import com.cicada.pojo.vo.UserVo;
import com.cicada.service.IRoleService;
import com.cicada.service.IUserService;

public class CmsGuessRealm extends AuthorizingRealm {

	@Autowired
	private IUserService userService;

	@Autowired
	private IRoleService roleService;

	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(
			PrincipalCollection principals) {
		ShiroUser shiroUser = (ShiroUser) principals.getPrimaryPrincipal();

		SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
		info.setRoles(shiroUser.getRoles());
		info.addStringPermissions(shiroUser.getUrlSet());
		return info;
	}

	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(
			AuthenticationToken authcToken) throws AuthenticationException {
		UsernamePasswordToken token = (UsernamePasswordToken) authcToken;
		UserVo uservo = new UserVo();
		uservo.setLoginName(token.getUsername());
		List<User> list = userService.selectByLoginName(uservo);
		// 账号不存在
		if (list == null || list.isEmpty()) {
			return null;
		}
		User user = list.get(0);
		// 账号未启用
		if (user.getStatus() == 1) {
			return null;
		}

		// 读取用户的url和角色
		Map<String, Set<String>> resourceMap = roleService
				.selectResourceMapByUserId(user.getId());
		Set<String> urls = resourceMap.get("urls");
		Set<String> roles = resourceMap.get("roles");
		ShiroUser shiroUser = new ShiroUser(user.getId(), user.getLoginName(),
				user.getName(), urls);
		shiroUser.setRoles(roles);
		// 认证缓存信息
		return new SimpleAuthenticationInfo(shiroUser, user.getPassWord()
				.toCharArray(), getName());
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
