package com.cicada.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cicada.mapper.SysLogMapper;
import com.cicada.pojo.SysLog;
import com.cicada.result.DatatablesResult;
import com.cicada.service.ISysLogService;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@Service
public class
SysLogServiceImpl extends ServiceImpl<SysLogMapper, SysLog> implements ISysLogService {
	
	@Autowired
	private SysLogMapper sysLogMapper;

	@Override
	public DatatablesResult<SysLog> selectDataGrid(int page, int rows, int draw) {
		PageHelper.startPage(page, rows);
		List<SysLog> sysLogs = sysLogMapper.selectList(new EntityWrapper<SysLog>());
		PageInfo<SysLog> pageInfo = new PageInfo<>(sysLogs);
		DatatablesResult datatablesResult = new DatatablesResult();
		datatablesResult.setData(sysLogs);
		datatablesResult.setDraw(draw);
		datatablesResult.setRecordsTotal((int)pageInfo.getTotal());
		datatablesResult.setRecordsFiltered(datatablesResult.getRecordsTotal());
		return datatablesResult;
		
		
	}

}
