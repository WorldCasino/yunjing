package com.agdress.controller;

import com.agdress.commons.utils.ResponseWrapper;
import com.agdress.entity.Starship_RoleEntity;
import com.agdress.entity.Starship_RoleModulesEntity;
import com.agdress.mapper.Starship_RoleMapper;
import com.agdress.result.DatatablesResult;
import com.agdress.service.Starship_IRoleModulesService;
import com.agdress.service.Starship_IRoleService;
import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.github.pagehelper.PageInfo;
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
@RequestMapping("/ss_role")
public class Starship_RoleController extends BaseController {



	@Autowired
	private Starship_IRoleService roleService;

	@Autowired
	private Starship_IRoleModulesService roleModulesService;

	@Autowired
	private Starship_RoleMapper roleMapper;




	/**
	 * 获取角色列表
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "/getRoleList",method = RequestMethod.POST)
	public ResponseEntity getRoleList() throws IOException {
		ResponseWrapper result;
		try {
			//将角色集合存到session
			Starship_RoleEntity roleEntity=new Starship_RoleEntity();
			roleEntity.setIsDelete(0);
			EntityWrapper<Starship_RoleEntity> wrapper = new EntityWrapper<Starship_RoleEntity>(roleEntity);
			List<Starship_RoleEntity> roleList=roleService.selectList(wrapper);
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
  	@RequestMapping(value = "/dataGrid", method = RequestMethod.POST)
	public ResponseEntity<DatatablesResult> dataGrid(@RequestBody JSONObject params) {
		int rows = params.getIntValue("length");
		int start = params.getIntValue("start");
		int draw = params.getIntValue("draw");
		int page = (start / rows) + 1;
 		try {
			Starship_RoleEntity r=new Starship_RoleEntity();
			EntityWrapper<Starship_RoleEntity> wrapper = new EntityWrapper<Starship_RoleEntity>(r);
			List<Starship_RoleEntity> roleList = this.roleService.selectList(wrapper);
			PageInfo<Starship_RoleEntity> pageInfo = new PageInfo<Starship_RoleEntity>(roleList);
 			DatatablesResult rdbr = new DatatablesResult<Starship_RoleEntity>();
			rdbr.setData(roleList);
			rdbr.setDraw(draw);
			rdbr.setRecordsTotal((int)pageInfo.getTotal());
			rdbr.setRecordsFiltered(rdbr.getRecordsTotal());
 			return ResponseEntity.ok(rdbr);
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
	@RequestMapping(value = "/addRole",method = RequestMethod.POST)
	public ResponseEntity addRole(Starship_RoleEntity roleEntity) throws IOException{
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
	@RequestMapping(value = "/findModulesById",method = RequestMethod.POST)
	public ResponseEntity findModulesById(String roleId) throws IOException{
		ResponseWrapper result;
		try {
			Starship_RoleModulesEntity rm=new Starship_RoleModulesEntity();
			rm.setRoleId(Long.parseLong(roleId));
			EntityWrapper<Starship_RoleModulesEntity> wrapper = new EntityWrapper<Starship_RoleModulesEntity>(rm);
			List<Starship_RoleModulesEntity> relist=roleModulesService.selectList(wrapper);
			String modulesstr="";
			for(Starship_RoleModulesEntity roleModulesEntity : relist){
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
	 * @param role_id 角色ID
	 * @param modulesstr 菜单集合，逗号分隔
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "/updateRoleModules",method = RequestMethod.POST)
	public ResponseEntity updateRoleModules(String role_id,String modulesstr) throws IOException {
		ResponseWrapper result;
		try {
			//清空当前角色的所有权限
			Starship_RoleModulesEntity rm = new Starship_RoleModulesEntity();
			rm.setRoleId(Long.parseLong(role_id));
			EntityWrapper<Starship_RoleModulesEntity> wrapper = new EntityWrapper<Starship_RoleModulesEntity>(rm);
			roleModulesService.delete(wrapper);
			//新增权限
 			String[] modules=modulesstr.split(",");
			for (int i = 0; i <modules.length; i++) {
				if(modules[i].equals("")){
					continue;
				}
				rm = new Starship_RoleModulesEntity();
				rm.setRoleId(Long.parseLong(role_id));
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
