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
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
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
import com.cicada.service.impl.MatchesServiceImpl;
import com.cicada.service.impl.TeamServiceImpl;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

/**
 *NBA赛事调用示例代码 － 聚合数据
 *在线接口文档：http://www.juhe.cn/docs/92
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



    //status:0-未开赛，1-正在直播，2-已结束

    /**
     * NBA常规赛赛程赛果存储
     */
    public static void setBallList(){
        String result =null;
        String url =SystemConfig.getInstance().getBALL_MATCH_BASKETBALL_NBA();//请求接口地址
        Map params = new HashMap();//请求参数
        params.put("key",APPKEY);//应用APPKEY(应用详细页查询)
        params.put("dtype","");//返回数据的格式,xml或json，默认json
         try {
             result =net(url, params, "GET");//正式
             JSONObject object = JSONObject.parseObject(result);
              if(object.getInteger("error_code")    ==0){
//                System.out.println(object.get("result"));
                JSONObject jsonObject=object.getJSONObject("result");
                JSONArray jsonArray= jsonObject.getJSONArray("list") ;
                for (int i = 0; i < jsonArray.size() ; i++) {
                    String title="NBA 常规赛";
                    JSONObject jsonObject2=jsonArray.getJSONObject(i);
                    String time_title=  jsonObject2.getString("title");
                    String day_date=time_title.substring(0,5).trim();
                    String day_week=time_title.substring(6,time_title.length()).trim();
                    //判断标题
                    long nowplaytime=DateUtil.fomatDate(DateFormatUtil.getYear().trim()+"-"+day_date).getTime();
                    long number=nowplaytime-(new Date()).getTime();
                    //时间判断如果是今天的就忽略
                    if(number <= 0){
                        continue;
                    }
                    if(nowplaytime >= jqstarttime && nowplaytime <= jqendttime){
                        title="NBA 季前赛";
                    }
                    //获取赛事
                    JSONArray jsonArray2= jsonObject2.getJSONArray("tr");
                    for (int j = 0; j < jsonArray2.size() ; j++) {

                         JSONObject jsonObject3= jsonArray2.getJSONObject(j);
//                         System.out.println(jsonObject3.toString());
                         String time=jsonObject3.getString("time");
                         String day_time=time.substring(6,time.length());
                         String home_team_name=jsonObject3.getString("player2");
                         String home_team_logo=jsonObject3.getString("player2logobig");
                         String away_team_name=jsonObject3.getString("player1");
                         String away_team_logo=jsonObject3.getString("player1logobig");
                         String score=jsonObject3.getString("score");
                          BallUtil.SaveMatch( home_team_name, home_team_logo,away_team_name,away_team_logo, day_week, day_date, day_time, title, MatchesTypeEnum.Basketball.getCode()+"" );
                     }
               }
             }else{
                  LOTTERY_LOGGER.info(String.format("ball-获取篮球赛程失败",object.get("error_code")+":"+object.get("reason")));
             }
         } catch (Exception e) {
            e.printStackTrace();
             LOTTERY_LOGGER.info(String.format("ball-获取篮球赛程是吧",e.toString()));
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
    public static boolean flagIsOver( long matchId,String home_team_name,String away_team_name,String day_date,String day_time){
        boolean flag=false;
        String result =null;
        String url = SystemConfig.getInstance().getBALL_MATCH_BASKETBALL_COMBAT();//请求接口地址
        Map params = new HashMap();//请求参数
        params.put("key",APPKEY);//应用APPKEY(应用详细页查询)
        params.put("dtype","");//返回数据的格式,xml或json，默认json
        params.put("hteam",home_team_name);//主队球队名称
        params.put("vteam",away_team_name);//客队球队名称
        try {
            result =net(url, params, "GET");
            JSONObject object = JSONObject.parseObject(result);
            if( object.getInteger("error_code")   ==0){
//                System.out.println(object.get("result"));
                JSONObject jsonObject= object.getJSONObject("result") ;
                JSONArray jsonArray= jsonObject.getJSONArray("list") ;
                for (int i = 0; i < jsonArray.size() ; i++) {
                    JSONObject jsonObject2 =  jsonArray.getJSONObject(i) ;
                    String status=jsonObject2.getString("status");
                    String again_day=jsonObject2.getString("m_time").substring(0,6);
                    String now_day=DateFormatUtil.getYYYY_MM_DD();
                    //非当天比赛的场次排除
                    if(!now_day.contains(again_day)){
                        continue;
                    }
                    String score=jsonObject2.getString("score");
                    String home_score="0";
                    String away_score="0";
                    if(!score.equals("VS")){
                        home_score=score.split("-")[0];
                        away_score=score.split("-")[1];
                    }
                    MatchesEntity matchesEntity=new MatchesEntity();
                    matchesEntity.setMatchId(matchId);
                    if(status.equals("2")){
                        flag=true;
                        matchesEntity.setSettleTime(new Timestamp(System.currentTimeMillis()));
                        matchesEntity.setMatchesStatusEnum(MatchesStatusEnum.IsOver);
                     }else if(status.equals("1")){
                        matchesEntity.setMatchesStatusEnum(MatchesStatusEnum.Underway);
                    }else{
                        matchesEntity.setMatchesStatusEnum(MatchesStatusEnum.NotStarted);
                    }
                    matchesEntity.setHomeScore(Integer.parseInt(home_score));
                    matchesEntity.setAwayScore(Integer.parseInt(away_score));
                    ((MatchesServiceImpl)SpringContextUtil.getBean("matchesServiceImpl")).updateById(matchesEntity);
                }
            }else{
                LOTTERY_LOGGER.info(String.format("ball-获取蓝球赛果失败",object.get("error_code")+":"+object.get("reason")));
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




    public static void main(String[] args){
    }



//    //1.获取球队
//    public static void getTeam(){
//        String result =null;
//        String url ="http://v.juhe.cn/nba/all_team_info.php";//请求接口地址
//        Map params = new HashMap();//请求参数
//        params.put("key","27398ce915369f329522af83f8be64b6");//应用APPKEY(应用详细页查询)
//        try {
//            result =net(url, params, "GET");
//            JSONObject object = JSONObject.parseObject(result);
////            System.out.println(object.toString());
//            if(object.get("reason").toString().equals("success")){
//                JSONObject jsonObject= object.getJSONObject("result") ;
//                System.out.println(jsonObject.toString());
//                 for (int i = 1; i < 31 ; i++) {
//                     if(jsonObject.get(i+"") == null){
//                         continue;
//                     }
//                     JSONObject jsonObject2= jsonObject.getJSONObject(i+"");
//                     TeamEntity teamEntity=new TeamEntity();
//                     teamEntity.setTeamInfor(jsonObject2.getString("intro"));
//                     teamEntity.setTeamLogo(jsonObject2.getString("logo_link"));
//                     teamEntity.setTeamName(jsonObject2.getString("name"));
//                     ((TeamServiceImpl)SpringContextUtil.getBean("teamServiceImpl")).insert(teamEntity);
//                }
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//
//    }


    private  static  String ceshistr1="";



    private static String ceshistr2="";


}