package com.agdress.shiro;

import java.io.Serializable;
import java.util.Set;

public class ShiroUser implements Serializable {

	private Long id;
	private String loginName;
	private String name ;
	private Set<String> modulesSet;
	private Set<String> roles;
	private String rolesstr;

	public ShiroUser(Long id, String loginName, String name, Set<String> modulesSet) {
		this.id = id;
		this.loginName = loginName;
		this.name = name;
		this.modulesSet = modulesSet;
	}


	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getLoginName() {
		return loginName;
	}

	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Set<String> getModulesSet() {
		return modulesSet;
	}

	public void setModulesSet(Set<String> modulesSet) {
		this.modulesSet = modulesSet;
	}

	public Set<String> getRoles() {
		return roles;
	}

	public void setRoles(Set<String> roles) {
		this.roles = roles;
	}

	public String getRolesstr() {
		return rolesstr;
	}

	public void setRolesstr(String rolesstr) {
		this.rolesstr = rolesstr;
	}
}