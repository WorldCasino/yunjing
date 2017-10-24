package com.kk.controller;

import com.kk.entity.ModulesEntity;
import com.kk.mapper.ModulesMapper;
import com.kk.result.TreeResult;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.ArrayList;
import java.util.List;

/**
 * 权限管理
 * @author wuyudong
 *
 */
@Controller
@RequestMapping("/modules")
public class ModulesController extends BaseController {



	@Autowired
	private ModulesMapper modulesMapper;

	/**
	 * 菜单树(右边)
	 *ss_modules/tree
	 * @return
	 */
	@RequestMapping(value = "/system/tree", method = RequestMethod.POST)
	public ResponseEntity<Object> tree(String roles) {
		List<TreeResult> trees = new ArrayList<TreeResult>();
		if (roles != null) {
			List<ModulesEntity> resourceLists = modulesMapper.selectModulesListByRoleId(roles);
			trees=this.getTreeResult(resourceLists);
		}
		return ResponseEntity.ok(trees);
	}



	private List<TreeResult> getTreeResult(List<ModulesEntity> resourceList ){
		List<TreeResult> trees = new ArrayList<TreeResult>();

		if (resourceList == null) {
			return trees;
		}
		for (ModulesEntity modules : resourceList) {
			TreeResult tree = new TreeResult();
			tree.setId(modules.getId());
			tree.setPid(modules.getPid());
			tree.setText(modules.getName());
			tree.setIconCls(modules.getIcon());
			tree.setAttributes(modules.getUrl());
			tree.setOpenMode(modules.getOpenMode());
			tree.setState(String.valueOf(modules.getStatus()));
			if (modules.getPid()!=null) {
				tree.setTargetType("iframe-tab");
			}
			trees.add(tree);
		}
		return trees;
	}



	/**
	 * 获取全部的菜单
	 *ss_modules/getModuleList
	 * @return
	 */
	@RequestMapping(value = "/system/getModuleList", method = RequestMethod.POST)
	public ResponseEntity<Object> getModuleList() {
		List<ModulesEntity> selectList=new ArrayList<ModulesEntity>();
		try{
			//获取父类标签
			ModulesEntity modulesEntity=new ModulesEntity();
			modulesEntity.setPid((long) 0);
			modulesEntity.setStatus((long) 1);
			EntityWrapper<ModulesEntity> wrapper = new EntityWrapper<ModulesEntity>(modulesEntity);
			wrapper.groupBy("seq");
			selectList = modulesMapper.selectList(wrapper);
			for (ModulesEntity sne: selectList) {
				//从内层开始
				if(sne.getId().toString().length() == 1){
					sne.setModuleId("0"+sne.getId());
				}else{
					sne.setModuleId(String.valueOf(sne.getId()));
				}
				ModulesEntity smallModules=new ModulesEntity();
				smallModules.setPid((sne.getId()));
				smallModules.setStatus((long) 1);
				EntityWrapper<ModulesEntity> wrapper2 = new EntityWrapper<ModulesEntity>(smallModules);
				wrapper.groupBy("seq");
				List<ModulesEntity> selectList2 = modulesMapper.selectList(wrapper2);
				for ( ModulesEntity twosne: selectList2) {
					if(twosne.getId().toString().length() == 1){
						twosne.setModuleId("0"+twosne.getId());
					}else{
						twosne.setModuleId(String.valueOf(twosne.getId()));
					}
					ModulesEntity smallModules2=new ModulesEntity();
					smallModules2.setPid((twosne.getId()));
					smallModules2.setStatus((long) 1);
					EntityWrapper<ModulesEntity> wrapper3 = new EntityWrapper<ModulesEntity>(smallModules2);
					wrapper.groupBy("seq");
					List<ModulesEntity> selectList3 = modulesMapper.selectList(wrapper3);
					for ( ModulesEntity threesne: selectList3) {
						if (threesne.getId().toString().length() == 1) {
							threesne.setModuleId("0" + threesne.getId());
						} else {
							threesne.setModuleId(String.valueOf(threesne.getId()));
						}
					}
					twosne.setList(selectList3);
				}
				sne.setList(selectList2);
			}
		}catch (Exception e){
			e.printStackTrace();
		}
		return ResponseEntity.ok(selectList);
	}



}
