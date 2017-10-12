package com.cicada.job.Ball;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.sql.Timestamp;
import java.util.*;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.cicada.commons.Exception.ApiException;
import com.cicada.commons.utils.DateFormatUtil;
import com.cicada.commons.utils.DateUtil;
import com.cicada.commons.utils.SpringContextUtil;
import com.cicada.commons.utils.SystemConfig;
import com.cicada.enums.ErrorCodeEnum;
import com.cicada.enums.MatchesStatusEnum;
import com.cicada.enums.MatchesTypeEnum;
import com.cicada.pojo.MatchesEntity;
import com.cicada.pojo.TeamEntity;
import com.cicada.service.IMatchesService;
import com.cicada.service.impl.MatchesServiceImpl;
import com.cicada.service.impl.TeamServiceImpl;
import com.sun.org.apache.xpath.internal.SourceTree;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

/**
 *NBA赛事调用示例代码 － 聚合数据
 *在线接口文档：http://www.juhe.cn/docs/92
 *
 * 99元2000次免费接口
 **/

public class BasketballMatchUtil {

    public static final String DEF_CHATSET = SystemConfig.getInstance().getBALL_MATCH_DEF_CHATSET();
    public static final int DEF_CONN_TIMEOUT = Integer.parseInt(SystemConfig.getInstance().getBALL_MATCH_DEF_CONN_TIMEOUT());
    public static final int DEF_READ_TIMEOUT = Integer.parseInt(SystemConfig.getInstance().getBALL_MATCH_DEF_READ_TIMEOUT());
    public static String userAgent =  SystemConfig.getInstance().getBALL_MATCH_USERAGENT();


    //配置您申请的KEY
    public static final String APPKEY =SystemConfig.getInstance().getBALL_MATCH_BASKETBALL_KEY();

    private static final Logger LOTTERY_LOGGER = LogManager.getLogger("ball");

    //10月1日至10月14日：NBA 季前赛
    public static long jqstarttime=DateUtil.fomatDate(DateUtil.getYear()+"-10-01").getTime();
    public static long jqendttime=DateUtil.fomatDate(DateUtil.getYear()+"-10-15").getTime();



    /**
     * NBA常规赛赛程赛果存储
     * 比赛状态,'1'=>'已结束', '2'=>'进行中', '3'=>'未开始', '4'=>'已取消
     *
     */
    public static void setBallList(){
        String now_date=DateUtil.getDay();//今天-今天之后的七天
//        EntityWrapper ew = new EntityWrapper();
//        ew.where("match_type = {0}", MatchesTypeEnum.Basketball.getCode());
//        ew.orderBy("settle_time", false);
//        List<MatchesEntity> matchesEntityList=((IMatchesService)SpringContextUtil.getBean("matchesServiceImpl")).selectList(ew);
//        if(matchesEntityList.size() >0){
//            MatchesEntity matchesEntity=matchesEntityList.get(0);
//            long jhminute=DateUtil.getDaySub(now_date,matchesEntity.getSettleTime().toString());
//            if(jhminute > 1){
//                return;
//            }
//        }
        for (int xi = 0 ; xi < 8; xi++) {
            String over_date=DateUtil.getAfterDayDate(now_date,""+xi);
            String result =null;
            String url =SystemConfig.getInstance().getBALL_MATCH_BASKETBALL_NBA();//请求接口地址
            Map params = new HashMap();//请求参数
            params.put("key",APPKEY);//应用APPKEY(应用详细页查询)
            params.put("date",over_date);//返回数据的格式,xml或json，默认json
            try {
                result =net(url, params, "GET");//正式
                JSONObject object = JSONObject.parseObject(result);
                if(object.getString("reason").equals("success")){
                    JSONArray jsonArray= object.getJSONArray("result") ;
                    for (int i = 0; i < jsonArray.size() ; i++) {
                        String title="NBA 常规赛";
                        JSONObject jsonObject2=jsonArray.getJSONObject(i);
                        String open_time=jsonObject2.getString("time");
                        String gl_match_id=jsonObject2.getString("match_id");
                        int status=jsonObject2.getIntValue("status");
                        JSONObject homejson=jsonObject2.getJSONObject("home");
                        String home_team_name=homejson.getString("name");
                        JSONObject awayjson=jsonObject2.getJSONObject("away");
                        String away_team_name=awayjson.getString("name");
                        //判断开赛状态
                        if(status != 3){
                            continue;
                        }
                        //判断标题
                        long nowplaytime=DateUtil.fomatDate(open_time).getTime();
                        if(nowplaytime >= jqstarttime && nowplaytime <= jqendttime){
                            title="NBA 季前赛";
                        }
                        BallUtil.SaveMatch( home_team_name, away_team_name,  open_time, title, MatchesTypeEnum.Basketball.getCode()+"" ,gl_match_id);
                    }
                }else{
                    LOTTERY_LOGGER.info(String.format("ball-参数对应无数据"+object.get("error_code")+"原因"+object.getString("reason")));
                }
            } catch (Exception e) {
                e.printStackTrace();
                LOTTERY_LOGGER.info(String.format("ball-获取篮球赛程是吧",e.toString()));
            }
        }
        //开始redis存储
        BallUtil.changeRedisBallList(MatchesTypeEnum.Basketball.getCode()+"");
    }




    /**
     *  篮球球队对战赛赛程查询--只定时比赛是否结束就可以
     *  返回参数：
     *      true:表示比赛结束
     *      false：表示比赛还未结束
     */
    public static boolean flagIsOver( long matchId,String home_team_name,String away_team_name,String day_date,String day_time,long gl_match_id){
        //无场次ID直接忽略
        if(gl_match_id == 0){
            return true;
        }
        boolean flag=false;
        String result =null;
        String url = SystemConfig.getInstance().getBALL_MATCH_BASKETBALL_COMBAT();//请求接口地址
        Map params = new HashMap();//请求参数
        params.put("key",APPKEY);//应用APPKEY(应用详细页查询)
        params.put("match_id",gl_match_id);//返回数据的格式,xml或json，默认json
        try {
            result =net(url, params, "GET");
            JSONObject object = JSONObject.parseObject(result);
            if(object.getString("reason").equals("success")) {
                JSONObject jsonObject= object.getJSONObject("result") ;
                int status=jsonObject.getIntValue("status");
                int home_score=jsonObject.getIntValue("home_score");
                int away_score=jsonObject.getIntValue("away_score");
                MatchesEntity matchesEntity=new MatchesEntity();
                matchesEntity.setMatchId(matchId);
                if(status == 1){
                    flag=true;
                    matchesEntity.setSettleTime(new Timestamp(System.currentTimeMillis()));
                    matchesEntity.setMatchesStatusEnum(MatchesStatusEnum.IsOver);
                }else if(status == 2){
                    matchesEntity.setMatchesStatusEnum(MatchesStatusEnum.Underway);
                }else{
                    matchesEntity.setMatchesStatusEnum(MatchesStatusEnum.NotStarted);
                }
                matchesEntity.setHomeScore(home_score);
                matchesEntity.setAwayScore(away_score);
                ((MatchesServiceImpl)SpringContextUtil.getBean("matchesServiceImpl")).updateById(matchesEntity);
            }else{
                LOTTERY_LOGGER.info(String.format("ball-暂无当前球赛记录"+object.get("error_code")+"原因"+object.getString("reason")));
            }
        } catch (Exception e) {
            e.printStackTrace();
            LOTTERY_LOGGER.info(String.format("ball-获取篮球赛程结果失败",e.toString()));
        }
        return  flag;
    }


    /**
     *
     * @param strUrl 请求地址
     * @param params 请求参数
     * @param method 请求方法
     * @return  网络请求字符串
     * @throws Exception
     */
    public static String net(String strUrl, Map params,String method) throws Exception {
        HttpURLConnection conn = null;
        BufferedReader reader = null;
        String rs = null;
        try {
            StringBuffer sb = new StringBuffer();
            if(method==null || method.equals("GET")){
                strUrl = strUrl+"?"+urlencode(params);
            }
            URL url = new URL(strUrl);
            conn = (HttpURLConnection) url.openConnection();
            if(method==null || method.equals("GET")){
                conn.setRequestMethod("GET");
            }else{
                conn.setRequestMethod("POST");
                conn.setDoOutput(true);
            }
            conn.setRequestProperty("User-agent", userAgent);
            conn.setUseCaches(false);
            conn.setConnectTimeout(DEF_CONN_TIMEOUT);
            conn.setReadTimeout(DEF_READ_TIMEOUT);
            conn.setInstanceFollowRedirects(false);
            conn.connect();
            if (params!= null && method.equals("POST")) {
                try {
                    DataOutputStream out = new DataOutputStream(conn.getOutputStream());
                    out.writeBytes(urlencode(params));
                } catch (Exception e) {
                    // TODO: handle exception
                }
            }
            InputStream is = conn.getInputStream();
            reader = new BufferedReader(new InputStreamReader(is, DEF_CHATSET));
            String strRead = null;
            while ((strRead = reader.readLine()) != null) {
                sb.append(strRead);
            }
            rs = sb.toString();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (reader != null) {
                reader.close();
            }
            if (conn != null) {
                conn.disconnect();
            }
        }
        return rs;
    }

    //将map型转为请求参数型
    public static String urlencode(Map<String,Object>data) {
        StringBuilder sb = new StringBuilder();
        for (Map.Entry i : data.entrySet()) {
            try {
                sb.append(i.getKey()).append("=").append(URLEncoder.encode(i.getValue()+"","UTF-8")).append("&");
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
        }
        return sb.toString();
    }



}