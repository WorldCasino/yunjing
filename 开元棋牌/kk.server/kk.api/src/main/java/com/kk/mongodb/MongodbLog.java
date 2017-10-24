package com.kk.mongodb;


/**

 <!-- map和json之间的转换 -->
 <dependency>
 <groupId>net.sf.json-lib</groupId>
 <artifactId>json-lib</artifactId>
 <version>2.4</version>
 <classifier>jdk15</classifier>
 </dependency>
 <!--  mongodb支持库 -->
 <dependency>
 <groupId>org.springframework.data</groupId>
 <artifactId>spring-data-mongodb</artifactId>
 <version>1.8.0.RELEASE</version>
 </dependency>

 <!-- 在spring配置文件中需要导入 -->
 <import resource="applicationContext-mongodb.xml"/>


 //在SpringContextUtil中设置获取mongodb需要的服务层
     public static  DBLoggerDao getDBLoggerDao(){
         return (DBLoggerDao) getBean("dBLoggerDao");



 //添加日志
 SpringContextUtil.getDBLoggerDao().saveDetail(StringUtils.getUUId(),request.getRequestURL().toString(),"1","400","",DateFormatUtil.Now(),JSONObject.fromObject(request.getParameterMap()).toString(),"");

 */

