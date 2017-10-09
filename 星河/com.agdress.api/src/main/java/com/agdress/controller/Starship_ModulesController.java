package com.agdress.controller;

import com.agdress.entity.Starship_ModulesEntity;
import com.agdress.mapper.Starship_ModulesMapper;
import com.agdress.result.TreeResult;
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
@RequestMapping("/ss_modules")
public class Starship_ModulesController extends BaseController {



	@Autowired
	private Starship_ModulesMapper modulesMapper;

	  /**
     * 菜单树(右边)
     *ss_modules/tree
     * @return
     */
	@RequestMapping(value = "/tree", method = RequestMethod.POST)
    public ResponseEntity<Object> tree(String roles) {
 		List<TreeResult> trees = new ArrayList<TreeResult>();
  		if (roles != null) {
			List<Starship_ModulesEntity> resourceLists = modulesMapper.selectModulesListByRoleId(roles);
			trees=this.getTreeResult(resourceLists);
		}
 		return ResponseEntity.ok(trees);
     }



	private List<TreeResult> getTreeResult(List<Starship_ModulesEntity> resourceList ){
		List<TreeResult> trees = new ArrayList<TreeResult>();

		if (resourceList == null) {
			return trees;
		}
		for (Starship_ModulesEntity modules : resourceList) {
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
	@RequestMapping(value = "/getModuleList", method = RequestMethod.POST)
	public ResponseEntity<Object> getModuleList() {
		List<Starship_ModulesEntity> selectList=new ArrayList<Starship_ModulesEntity>();
 		try{
			//获取父类标签
			Starship_ModulesEntity modulesEntity=new Starship_ModulesEntity();
			modulesEntity.setPid((long) 0);
			modulesEntity.setStatus((long) 1);
			EntityWrapper<Starship_ModulesEntity> wrapper = new EntityWrapper<Starship_ModulesEntity>(modulesEntity);
			wrapper.groupBy("seq");
			selectList = modulesMapper.selectList(wrapper);
			for (Starship_ModulesEntity sne: selectList) {
				//从内层开始
				if(sne.getId().toString().length() == 1){
					sne.setModuleId("0"+sne.getId());
				}else{
					sne.setModuleId(String.valueOf(sne.getId()));
				}
				Starship_ModulesEntity smallModules=new Starship_ModulesEntity();
				smallModules.setPid((sne.getId()));
				smallModules.setStatus((long) 1);
				EntityWrapper<Starship_ModulesEntity> wrapper2 = new EntityWrapper<Starship_ModulesEntity>(smallModules);
				wrapper.groupBy("seq");
				List<Starship_ModulesEntity> selectList2 = modulesMapper.selectList(wrapper2);
				for ( Starship_ModulesEntity twosne: selectList2) {
					if(twosne.getId().toString().length() == 1){
						twosne.setModuleId("0"+twosne.getId());
					}else{
						twosne.setModuleId(String.valueOf(twosne.getId()));
					}
					Starship_ModulesEntity smallModules2=new Starship_ModulesEntity();
					smallModules2.setPid((twosne.getId()));
					smallModules2.setStatus((long) 1);
					EntityWrapper<Starship_ModulesEntity> wrapper3 = new EntityWrapper<Starship_ModulesEntity>(smallModules2);
					wrapper.groupBy("seq");
					List<Starship_ModulesEntity> selectList3 = modulesMapper.selectList(wrapper3);
					for ( Starship_ModulesEntity threesne: selectList3) {
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
