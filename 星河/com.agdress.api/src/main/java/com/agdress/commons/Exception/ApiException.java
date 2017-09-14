package com.agdress.commons.Exception;

import com.agdress.commons.utils.SpringContextUtil;
import com.agdress.enums.ErrorCodeEnum;

/**
 * Api异常
 * Spring事务管理 需要抛出RuntimeException才会自动回滚
 * Created by Administrator on 2017/5/16.
 */
public class ApiException extends RuntimeException {
    private int code;

    public ApiException(int code,String msg){
        super(msg);
        this.code =code;
        //bug记录
        SpringContextUtil.getDBLoggerDao().saveDetail( "","3",code+"["+msg+"]" ,"", "","");
     }

    public ApiException(ErrorCodeEnum err){
        super(err.getDesc());
        this.code =err.getCode();
        //bug记录
        SpringContextUtil.getDBLoggerDao().saveDetail( "","3",err.getCode()+"["+err.getDesc()+"]" ,"", "","");
     }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }
}
