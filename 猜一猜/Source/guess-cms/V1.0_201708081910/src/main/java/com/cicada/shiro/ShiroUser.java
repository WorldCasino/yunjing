package com.cicada.shiro;

import java.io.Serializable;
import java.util.Set;

public class ShiroUser implements Serializable {
	private Long id;
	private String loginName;
	private String name ;
	private Set<String> urlSet;
	private Set<String> roles;

	public ShiroUser(String loginName) {
		this.loginName = loginName;
	}

	public ShiroUser(Long id, String loginName, String name, Set<String> urlSet) {
		this.id = id;
		this.loginName = loginName;
		this.name = name;
		this.urlSet = urlSet;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Set<String> getUrlSet() {
		return urlSet;
	}

	public void setUrlSet(Set<String> urlSet) {
		this.urlSet = urlSet;
	}

	public Set<String> getRoles() {
		return roles;
	}

	public void setRoles(Set<String> roles) {
		this.roles = roles;
	}

	public String getLoginName() {
		return loginName;
	}
}
