package com.agdress.commons.interceptor;


import com.agdress.commons.annotations.MapF2F;
import com.agdress.commons.secret.VersionLocker;
import com.agdress.commons.utils.ReflectUtil;
import javafx.util.Pair;
import org.apache.commons.lang3.StringUtils;
import org.apache.ibatis.executor.resultset.DefaultResultSetHandler;
import org.apache.ibatis.executor.statement.StatementHandler;
import org.apache.ibatis.reflection.MetaObject;
import org.apache.ibatis.reflection.ReflectionException;
import org.apache.ibatis.reflection.SystemMetaObject;


import org.apache.ibatis.binding.MapperMethod;
import org.apache.ibatis.mapping.BoundSql;
import org.apache.ibatis.mapping.MappedStatement;
import org.apache.ibatis.mapping.SqlCommandType;
import org.apache.ibatis.plugin.Interceptor;
import org.apache.ibatis.plugin.Intercepts;
import org.apache.ibatis.plugin.Invocation;
import org.apache.ibatis.plugin.Plugin;
import org.apache.ibatis.plugin.Signature;
import org.apache.ibatis.type.TypeHandlerRegistry;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.lang.reflect.Method;
import java.lang.reflect.Proxy;
import java.sql.*;
import java.util.*;


/**
 *
 * 类名称：VersionPlugin.java
 * 类描述：加注解控制锁，true表示控制，false表示不控制
 * @author fuhang
 * 作者单位：
 * 联系方式：
 * 创建时间：2014年7月1日
 * @version 1.0

<!--配置缓存-->
<plugin interceptor="com.agdress.commons.interceptor.VersionPlugin">
<property name="dialect" value="mysql"/>
<property name="versionSql" value="version_no"/>
<property name="versionFile" value="versionNo"/>
</plugin>



 */
@Intercepts({@Signature(type=StatementHandler.class,method="prepare",args={Connection.class,Integer.class})})
public class VersionPlugin implements Interceptor {

    private static String dialect = "";	//数据库方言
    private static String versionSql = "";	//数据库的name
    private static String versionFile = "";	//项目里的name
    private Logger logger = LoggerFactory.getLogger(VersionPlugin.class);


    public Object intercept(Invocation invocation) throws Throwable {
         try {
             StatementHandler statementHandler = (StatementHandler) processTarget(invocation.getTarget());
             MetaObject metaObject = SystemMetaObject.forObject(statementHandler);
             MappedStatement ms = (MappedStatement) metaObject.getValue("delegate.mappedStatement");
             //开始获取判断注解
//             String className = StringUtils.substringBeforeLast(ms.getId(), ".");// 当前类
//             String currentMethodName = StringUtils.substringAfterLast(ms.getId(), ".");// 当前方法
//             Method method = findMethod(className, currentMethodName);// 获取当前Method
//             if (method == null || method.getAnnotation(VersionLocker.class) == null) {// 如果当前Method没有注解VersionLocker
//                 return invocation.proceed();
//             }
             SqlCommandType sqlCmdType = ms.getSqlCommandType();
              //判断是不是一个更新操作
             if(sqlCmdType != SqlCommandType.UPDATE) {
                 return invocation.proceed();
             }
             //如果没有versionNo这个字段会出错ReflectionException，不参与安全锁控制
             Object originalVersion = metaObject.getValue("delegate.boundSql.parameterObject."+versionFile);
             BoundSql boundSql =(BoundSql) metaObject.getValue("delegate.boundSql");
             String originalSql = removeBreakingWhitespace(boundSql.getSql());
             originalSql=generateVersionSql(originalSql,originalVersion,versionSql);
             metaObject.setValue("delegate.boundSql.sql", originalSql);
         }catch (ReflectionException e){
            logger.error("ReflectionException 不包含"+versionSql+"字段，直接返回");
         }catch (Exception e){
            logger.error(e.toString());
         }
         return invocation.proceed();
    }

    /**
     * 找到与指定函数名匹配的Method。
     *
     * @param className
     * @param targetMethodName
     * @return
     * @throws Throwable
     */
    private Method findMethod(String className, String targetMethodName) throws Throwable {
        Method[] methods = Class.forName(className).getDeclaredMethods();// 该类所有声明的方法
        if (methods == null) {
            return null;
        }

        for (Method method : methods) {
            if (StringUtils.equals(method.getName(), targetMethodName)) {
                return method;
            }
        }

        return null;
    }

    /**
     * 去除换行符等
     *
     * @param original
     * @return
     */
    private String removeBreakingWhitespace(String original) {
        StringTokenizer whitespaceStripper = new StringTokenizer(original);
        StringBuilder builder = new StringBuilder();
        while (whitespaceStripper.hasMoreTokens()) {
            builder.append(whitespaceStripper.nextToken());
            builder.append(" ");
        }
        return builder.toString();
    }


    /**
     * 根据数据库方言，生成特定的乐观锁sql
     * @param sql
     * @param nowversion
     * @return
     */
    private String generateVersionSql(String sql,Object nowversion,String versionname){
        StringBuffer versionSql = new StringBuffer();
        long number= (long) nowversion;
        if("mysql".equals(dialect)){
            versionSql.append(sql);
            if(sql.contains("where") || sql.contains("WHERE")){
                versionSql.append(" and  "+versionname+"="+(number-1));
            }
        }else if("oracle".equals(dialect)){
            versionSql.append(sql);
            if(sql.contains("where") || sql.contains("WHERE")){
                versionSql.append(" and  "+versionname+"="+(number-1));
            }

        }
        return versionSql.toString();
    }

    /**
     * 解析获取StatementHandler
     * @param target
     * @return
     */
    private static Object processTarget(Object target) {
        if(Proxy.isProxyClass(target.getClass())) {
            MetaObject mo = SystemMetaObject.forObject(target);
            return processTarget(mo.getValue("h.target"));
        }
        return target;
    }





    public Object plugin(Object arg0) {
        // TODO Auto-generated method stub
         if (arg0 instanceof StatementHandler) {
            return Plugin.wrap(arg0, this);
        } else {
            return arg0;
        }
    }

    @Override
    public void setProperties(Properties p) {
        dialect = p.getProperty("dialect");
        versionSql = p.getProperty("versionSql");
        versionFile = p.getProperty("versionFile");
     }

}
