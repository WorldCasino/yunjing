package com.kk.controller;

import com.kk.commons.utils.ResponseWrapper;
import com.kk.entity.RoleEntity;
import com.kk.entity.RoleModulesEntity;
import com.kk.enums.UserTypeEnum;
import com.kk.result.DatatablesResult;
import com.kk.service.IRoleModulesService;
import com.kk.service.IRoleService;
import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

/**
 * 角色管理
 * @author wuyudong
 *
 */
@Controller
@RequestMapping("/role")
public class RoleController extends BaseController {



	@Autowired
	private IRoleService roleService;

	@Autowired
	private IRoleModulesService roleModulesService;


	/**
	 * 获取角色列表
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "/system/getRoleList",method = RequestMethod.POST)
	public ResponseEntity getRoleList() throws IOException {
		ResponseWrapper result;
		try {
			//将角色集合存到session
			RoleEntity roleEntity=new RoleEntity();
			roleEntity.setIsDelete(0);
			EntityWrapper<RoleEntity> wrapper = new EntityWrapper<RoleEntity>(roleEntity);
			List<RoleEntity> roleList=roleService.selectList(wrapper);
			result = ResponseWrapper.succeed(roleList);
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
		}
		return ResponseEntity.ok(result);
	}


	/**
	 * 获取角色列表
	 * @param params
	 * @return
	 */
	@RequestMapping(value = "/system/dataGrid", method = RequestMethod.POST)
	public ResponseEntity<DatatablesResult> dataGrid(@RequestBody JSONObject params) {
		int rows = params.getIntValue("length");
		int start = params.getIntValue("start");
		int draw = params.getIntValue("draw");
		int page = (start / rows) + 1;
		try {
			params.put("userType", UserTypeEnum.SystemUser);
			DatatablesResult datatablesResult = this.roleService.selectRoleVo(params, page, rows,draw );
			return ResponseEntity.ok(datatablesResult);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
	}



	/**
	 * 新增角色
	 * @param roleEntity
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "/system/addRole",method = RequestMethod.POST)
	public ResponseEntity addRole(RoleEntity roleEntity) throws IOException{
		ResponseWrapper result;
		try {
			roleEntity.setCreateDate(new Timestamp(new Date().getTime()));
			boolean n=roleService.insert(roleEntity);
			result = ResponseWrapper.succeed(n);
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
		}
		return ResponseEntity.ok(result);
	}


	/**
	 * 获取权限相关的菜单
	 * @param roleId
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "/system/findModulesById",method = RequestMethod.POST)
	public ResponseEntity findModulesById(String roleId) throws IOException{
		ResponseWrapper result;
		try {
			RoleModulesEntity rm=new RoleModulesEntity();
			rm.setRoleId(Long.parseLong(roleId));
			EntityWrapper<RoleModulesEntity> wrapper = new EntityWrapper<RoleModulesEntity>(rm);
			List<RoleModulesEntity> relist=roleModulesService.selectList(wrapper);
			String modulesstr="";
			for(RoleModulesEntity roleModulesEntity : relist){
				if(roleModulesEntity.getModuleId().toString().length() == 1){
					modulesstr+="0"+roleModulesEntity.getModuleId()+",";
				}else{
					modulesstr+=roleModulesEntity.getModuleId()+",";
				}
			}
			result = ResponseWrapper.succeed(modulesstr);
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
		}

		return ResponseEntity.ok(result);
	}


	/**
	 * 修改角色权限
	 * @param roleId 角色ID
	 * @param modulesStr 菜单集合，逗号分隔
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "/system/updateRoleModules",method = RequestMethod.POST)
	public ResponseEntity updateRoleModules(String roleId,String modulesStr) throws IOException {
		ResponseWrapper result;
		try {
			//清空当前角色的所有权限
			RoleModulesEntity rm = new RoleModulesEntity();
			rm.setRoleId(Long.parseLong(roleId));
			EntityWrapper<RoleModulesEntity> wrapper = new EntityWrapper<RoleModulesEntity>(rm);
			roleModulesService.delete(wrapper);
			//新增权限
			String[] modules=modulesStr.split(",");
			for (int i = 0; i <modules.length; i++) {
				if(modules[i].equals("")){
					continue;
				}
				rm = new RoleModulesEntity();
				rm.setRoleId(Long.parseLong(roleId));
				rm.setModuleId(Long.parseLong(modules[i]));
				roleModulesService.insert(rm);
				rm=null;
			}
			result = ResponseWrapper.succeed(true);
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
		}
		return ResponseEntity.ok(result);
	}

}
