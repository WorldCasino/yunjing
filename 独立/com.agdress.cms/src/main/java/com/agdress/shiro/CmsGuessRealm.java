package com.agdress.shiro;




import com.agdress.entity.Starship_UserEntity;
import com.agdress.entity.vo.Starship_UserVo;
import com.agdress.service.Starship_IRoleService;
import com.agdress.service.Starship_IUserService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.subject.SimplePrincipalCollection;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;


import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.util.List;
import java.util.Map;
import java.util.Set;

public class CmsGuessRealm extends AuthorizingRealm {

	@Autowired
	private Starship_IUserService userService;

	@Autowired
	private Starship_IRoleService roleService;

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
		Starship_UserVo uservo = new Starship_UserVo();
		uservo.setLoginnumber(token.getUsername());
		Starship_UserEntity userEntity = userService.selectByLoginName(uservo);
		// 账号不存在
		if (userEntity == null) {
			return null;
		}
 		// 账号未启用
		if (userEntity.getUser_status() == 1) {
			return null;
		}
		//放入缓存
		Subject sybject = SecurityUtils.getSubject();
		sybject.getSession().removeAttribute("login_id");
		sybject.getSession().setAttribute("login_id",userEntity.getUserId());
 		// 读取用户的url和角色
		Map<String, Set<String>> resourceMap = roleService.selectModulesMapByUserId(String.valueOf(userEntity.getRole_id()));
		Set<String> mods = resourceMap.get("mods");
		Set<String> roles = resourceMap.get("roles");
//		System.out.println("mods="+mods.toString());System.out.println("roles="+roles.toString());
		ShiroUser shiroUser = new ShiroUser(userEntity.getUserId(), userEntity.getLoginName(),userEntity.getNickname(), mods);
		shiroUser.setRoles(roles);
 		String password= userEntity.getPassWord();
//		try {
//			password = StringUtils.getMD5String(userEntity.getPassWord());
//		} catch (NoSuchAlgorithmException e) {
//			e.printStackTrace();
//		} catch (UnsupportedEncodingException e) {
//			e.printStackTrace();
//		}
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
