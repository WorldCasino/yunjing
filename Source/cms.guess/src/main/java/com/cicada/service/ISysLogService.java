package com.cicada.service;

import com.cicada.pojo.SysLog;
import com.cicada.result.DatatablesResult;
import com.baomidou.mybatisplus.service.IService;

public interface ISysLogService extends IService<SysLog>{

	DatatablesResult<SysLog> selectDataGrid(int page, int rows, int parseInt);

}
