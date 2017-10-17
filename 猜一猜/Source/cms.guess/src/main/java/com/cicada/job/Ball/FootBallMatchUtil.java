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
import java.util.Iterator;
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
import com.cicada.service.impl.MatchesServiceImpl;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

/**
 *足球联赛调用示例代码 － 聚合数据
 *在线接口文档：http://www.juhe.cn/docs/90
 **/

public class FootBallMatchUtil {
    public static final String DEF_CHATSET = SystemConfig.getInstance().getBALL_MATCH_DEF_CHATSET();
    public static final int DEF_CONN_TIMEOUT = Integer.parseInt(SystemConfig.getInstance().getBALL_MATCH_DEF_CONN_TIMEOUT());
    public static final int DEF_READ_TIMEOUT = Integer.parseInt(SystemConfig.getInstance().getBALL_MATCH_DEF_READ_TIMEOUT());
    public static String userAgent =  SystemConfig.getInstance().getBALL_MATCH_USERAGENT();


    private static String[] str={"英超","西甲","德甲","意甲","法甲","中超" };

    //配置您申请的KEY
    public static final String APPKEY =SystemConfig.getInstance().getBALL_MATCH_FOOTBALL_KEY();

    private static final Logger LOTTERY_LOGGER = LogManager.getLogger("ball");

    //1.足球联赛赛事查询
    public static void setBallList(){
        String result =null;
        String url =SystemConfig.getInstance().getBALL_MATCH_FOOTBALL_LEAGUE();//请求接口地址
        Map params = new HashMap();//请求参数
        params.put("key",APPKEY);//应用APPKEY(应用详细页查询)
        params.put("dtype","");//返回数据的格式,xml或json，默认json
        try {
            for (int stri = 0; stri < str.length ; stri++) {
                params.put("league",str[stri]);//联赛名称
                result =net(url, params, "GET");
                JSONObject object = JSONObject.parseObject(result);
                if( object.getInteger("error_code")   ==0){
                    JSONObject jsonObject=object.getJSONObject("result");
                    String keytitle=jsonObject.getString("key");
                    JSONObject views=jsonObject.getJSONObject("views");
                    JSONObject tabls=jsonObject.getJSONObject("tabs");
//                    System.out.println(tabls.toString());
                    for (Map.Entry<String, Object> entry : tabls.entrySet()) {
//                        System.out.println( entry.getKey()+ ":" + entry.getValue());
                        String key = entry.getKey();
                        if(!key.contains("saicheng") || entry.getValue() == null){
                            continue;
                        }
                        String value =  entry.getValue().toString().replaceAll("赛程","");
//                        System.out.println("key="+key);System.out.println("value="+value);
                        if(value.equals("null")){
                            continue;
                        }
                        JSONArray liansai=views.getJSONArray(key);
                        for (int i = 0; i < liansai.size() ; i++) {
                            JSONObject jsonObject2=liansai.getJSONObject(i);
                            String time_title=  jsonObject2.getString("c2");
                            String day_date=time_title.substring(0,5);
                            String day_week=time_title.substring(5,time_title.length());
                            long number=DateUtil.fomatDate(DateFormatUtil.getYear().trim()+"-"+day_date).getTime()-(new Date()).getTime();
                            //时间判断如果是今天的就忽略
                            if(number <= 0){
                                continue;
                            }
                            String day_time=jsonObject2.getString("c3");
                            String home_team_name=jsonObject2.getString("c4T1");
                            String away_team_name=jsonObject2.getString("c4T2");
                            String open_time= DateFormatUtil.getYear().trim()+"-"+day_date.trim()+" "+day_time.trim()+":00";
                            BallUtil.SaveMatch( home_team_name,  away_team_name, open_time, keytitle+" "+value, MatchesTypeEnum.Football.getCode()+"" ,"");
                        }
                    }
                }else{
                    LOTTERY_LOGGER.info(String.format("获取足球赛程失败"+object.get("error_code")+":"+object.get("reason")));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            LOTTERY_LOGGER.error(String.format("获取足球赛程失败",e));
        }
        //开始存储
        BallUtil.changeRedisBallList(MatchesTypeEnum.Football.getCode()+"");
    }

    /**
     * 球队对战赛赛程查询
     * @param matchId
     * @param home_team_name
     * @param away_team_name
     * @param day_date
     * @param day_time
     * @return
     */
    public static boolean flagIsOver(long matchId,String home_team_name,String away_team_name,String day_date,String day_time,String title){
        boolean flag=false;
        String result =null;
        String url =SystemConfig.getInstance().getBALL_MATCH_FOOTBALL_LEAGUE();//请求接口地址
        Map params = new HashMap();//请求参数
        params.put("key",APPKEY);//应用APPKEY(应用详细页查询)
        params.put("dtype","");//返回数据的格式,xml或json，默认json
        try {
            params.put("league",title.substring(0,2).trim());//联赛名称
            result =net(url, params, "GET");
            JSONObject object = JSONObject.parseObject(result);
            if(object.getInteger("error_code")   ==0){
                JSONObject jsonObject=object.getJSONObject("result");
                String keytitle=jsonObject.getString("key");
                JSONObject views=jsonObject.getJSONObject("views");
                JSONObject tabls=jsonObject.getJSONObject("tabs");
                for (Map.Entry<String, Object> entry : tabls.entrySet()) {
//                    System.out.println( entry.getKey()+ ":" + entry.getValue());
                    String key = entry.getKey();
                    if(!key.contains("saicheng") || entry.getValue() == null){
                        continue;
                    }
                    String value = entry.getValue().toString();
                    if(!value.contains(title.substring(2,title.length()).trim())){
                        continue;
                    }
                    JSONArray liansai=views.getJSONArray(key);
                    for (int i = 0; i < liansai.size() ; i++) {
                        JSONObject jsonObject2=liansai.getJSONObject(i);
                        String time_title2=  jsonObject2.getString("c2");
                        String day_date2=time_title2.substring(0,5);
                        String day_week=time_title2.substring(5,time_title2.length());
                        String day_time2=jsonObject2.getString("c3");
                        String home_team_name2=jsonObject2.getString("c4T1");
                        String away_team_name2=jsonObject2.getString("c4T2");
                        if(!day_date2.equals(day_date) || !day_time2.equals(day_time)){
                            continue;
                        }
                        if(!home_team_name2.equals(home_team_name) || !away_team_name2.equals(away_team_name)){
                            continue;
                        }
                        LOTTERY_LOGGER.info(String.format("当前足球球赛【"+matchId+"】结果记录"+jsonObject2.toString()));
                        String c1=jsonObject2.getString("c1");
                        String score=jsonObject2.getString("c4R");
                        if(c1.equals("已结束") && !score.equals("VS")){
                            MatchesEntity matchesEntity=new MatchesEntity();
                            matchesEntity.setMatchId(matchId);
                            //比赛结束开始计算
                            matchesEntity.setSettleTime(new Timestamp(System.currentTimeMillis()));
                            matchesEntity.setMatchesStatusEnum(MatchesStatusEnum.IsOver);
                            matchesEntity.setHomeScore(Integer.parseInt(score.split("-")[0]));
                            matchesEntity.setAwayScore(Integer.parseInt( score.split("-")[1]));
                            ((MatchesServiceImpl) SpringContextUtil.getBean("matchesServiceImpl")).updateById(matchesEntity);
                            flag=true;
                            break;
                        }
                    }
                }
            }else{
                LOTTERY_LOGGER.info(String.format("获取足球赛程【"+matchId+"】结果失败"+object.get("error_code")+":"+object.get("reason")));
            }
        } catch (Exception e) {
            e.printStackTrace();
            LOTTERY_LOGGER.error(String.format("获取足球赛程【"+matchId+"】结果失败",e));
        }
        return  flag;
    }




    /**
     * 球队对战赛赛程查询
     * @param matchId
     * @param home_team_name
     * @param away_team_name
     * @param day_date
     * @param day_time
     * @return
     */
//    public static boolean flagIsOverNot(long matchId,String home_team_name,String away_team_name,String day_date,String day_time,String title){
//        boolean flag=false;
//        String result =null;
//        String url = SystemConfig.getInstance().getBALL_MATCH_FOOTBALL_COMBAT();//请求接口地址
//        Map params = new HashMap();//请求参数
//        params.put("key",APPKEY);//应用APPKEY(应用详细页查询)
//        params.put("dtype","");//返回数据的格式,xml或json，默认json
//        params.put("hteam",home_team_name);//主队球队名称
//        params.put("vteam",away_team_name);//客队球队名称
//        try {
//            result =net(url, params, "GET");
//            JSONObject object = JSONObject.fromObject(result);
//            if(object.getInt("error_code")==0){
//                 JSONObject jsonObject=object.getJSONObject("result");
//                 System.out.println(jsonObject.toString());
//                 JSONArray jsonArray=jsonObject.getJSONArray("list");
//                for (int i = 0; i < jsonArray.size() ; i++) {
//                    JSONObject jsonObject2=jsonArray.getJSONObject(i);
//                    String team1=jsonObject2.getString("team1");
//                    String team2=jsonObject2.getString("team2");
//                    String score=jsonObject2.getString("score");
//                    String date=jsonObject2.getString("date");
//                    String time=jsonObject2.getString("time");
//                    //判断是否是当前球队比赛
//                    if(time.equals(day_time) && date.contains(day_date)){
//                        MatchesEntity matchesEntity=new MatchesEntity();
//                        matchesEntity.setMatchId(matchId);
//                        if(!score.equals("VS")){
//                            //比赛结束开始计算
//                            matchesEntity.setSettleTime(new Timestamp(System.currentTimeMillis()));
//                            matchesEntity.setMatchesStatusEnum(MatchesStatusEnum.IsOver);
//                            matchesEntity.setHomeScore(Integer.parseInt(score.split("-")[0]));
//                            matchesEntity.setAwayScore(Integer.parseInt( score.split("-")[1]));
//                            ((MatchesServiceImpl) SpringContextUtil.getBean("matchesServiceImpl")).updateById(matchesEntity);
//                            flag=true;
//                        }
//                    }else{
//                        continue;
//                    }
//                }
//            }else{
//                LOTTERY_LOGGER.info(String.format("获取足球赛果失败",object.get("error_code")+":"+object.get("reason")));
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//            throw new ApiException(ErrorCodeEnum.SystemError.getCode(),"获取足球赛果失败");
//        }
//        return  flag;
//    }



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
        for (Map.Entry i: data.entrySet()) {
            try {
                sb.append(i.getKey()).append("=").append(URLEncoder.encode(i.getValue()+"","UTF-8")).append("&");
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
        }
        return sb.toString();
    }



    public static void main(String[] args) {

    }

    private  static  String ceshistr1="{    \"reason\": \"查询成功\",    \"result\": {        \"key\": \"西甲\",        \"tabs\": {            \"saicheng1\": \"第5轮赛程\",            \"saicheng2\": \"第6轮赛程\",            \"saicheng3\": null,            \"jifenbang\": \"积分榜\",            \"sheshoubang\": \"射手榜\"        },        \"views\": {            \"saicheng1\": [                {                    \"c1\": \"已结束\",                    \"c2\": \"09-20周三\",                    \"c3\": \"02:00\",                    \"c4T1\": \"瓦伦西亚\",                    \"c4T1URL\": \"http://match.sports.sina.com.cn/football/team.php?id=169\",                    \"c4R\": \"5-0\",                    \"c4T2\": \"马拉加\",                    \"c4T2URL\": \"http://match.sports.sina.com.cn/football/team.php?id=163\",                    \"c51\": \"全场统计\",                    \"c51Link\": \"http://match.sports.sina.com.cn/livecast/g/live.php?id=165727\",                    \"c52\": \"图文数据\",                    \"c52Link\": \"http://match.sports.sina.com.cn/livecast/g/live.php?id=165727\",                    \"liveid\": \"942846\"                },                {                    \"c1\": \"已结束\",                    \"c2\": \"09-20周三\",                    \"c3\": \"04:00\",                    \"c4T1\": \"巴塞罗那\",                    \"c4T1URL\": \"http://match.sports.sina.com.cn/football/team.php?id=130\",                    \"c4R\": \"6-1\",                    \"c4T2\": \"埃瓦尔\",                    \"c4T2URL\": \"http://match.sports.sina.com.cn/football/team.php?id=4417\",                    \"c51\": \"全场统计\",                    \"c51Link\": \"http://match.sports.sina.com.cn/livecast/g/live.php?id=165720\",                    \"c52\": \"全场战报\",                    \"c52Link\": \"http://sports.sina.com.cn/g/laliga/2017-09-20/doc-ifykymue7355757.shtml?cre=360.ala.xj.sc\",                    \"liveid\": \"942843\"                },                {                    \"c1\": \"未开赛\",                    \"c2\": \"09-21周四\",                    \"c3\": \"02:00\",                    \"c4T1\": \"毕尔巴鄂竞技\",                    \"c4T1URL\": \"http://match.sports.sina.com.cn/football/team.php?id=131\",                    \"c4R\": \"VS\",                    \"c4T2\": \"马德里竞技\",                    \"c4T2URL\": \"http://match.sports.sina.com.cn/football/team.php?id=162\",                    \"c51\": \"视频暂无\",                    \"c51Link\": \"\",                    \"c52\": \"前瞻预测\",                    \"c52Link\": \"http://match.sports.sina.com.cn/livecast/g/live.php?id=165719\",                    \"liveid\": \"942840\"                },                {                    \"c1\": \"未开赛\",                    \"c2\": \"09-21周四\",                    \"c3\": \"02:00\",                    \"c4T1\": \"莱加内斯\",                    \"c4T1URL\": \"http://match.sports.sina.com.cn/football/team.php?id=4526\",                    \"c4R\": \"VS\",                    \"c4T2\": \"赫罗纳\",                    \"c4T2URL\": \"http://match.sports.sina.com.cn/football/team.php?id=13869\",                    \"c51\": \"视频暂无\",                    \"c51Link\": \"\",                    \"c52\": \"前瞻预测\",                    \"c52Link\": \"http://match.sports.sina.com.cn/livecast/g/live.php?id=165723\",                    \"liveid\": \"942848\"                },                {                    \"c1\": \"未开赛\",                    \"c2\": \"09-21周四\",                    \"c3\": \"03:00\",                    \"c4T1\": \"拉科鲁尼亚\",                    \"c4T1URL\": \"http://match.sports.sina.com.cn/football/team.php?id=161\",                    \"c4R\": \"VS\",                    \"c4T2\": \"阿拉维斯\",                    \"c4T2URL\": \"http://match.sports.sina.com.cn/football/team.php?id=155\",                    \"c51\": \"视频暂无\",                    \"c51Link\": \"\",                    \"c52\": \"前瞻预测\",                    \"c52Link\": \"http://match.sports.sina.com.cn/livecast/g/live.php?id=165722\",                    \"liveid\": \"942845\"                },                {                    \"c1\": \"未开赛\",                    \"c2\": \"09-21周四\",                    \"c3\": \"04:00\",                    \"c4T1\": \"皇家马德里\",                    \"c4T1URL\": \"http://match.sports.sina.com.cn/football/team.php?id=157\",                    \"c4R\": \"VS\",                    \"c4T2\": \"皇家贝蒂斯\",                    \"c4T2URL\": \"http://match.sports.sina.com.cn/football/team.php?id=154\",                    \"c51\": \"视频暂无\",                    \"c51Link\": \"\",                    \"c52\": \"前瞻预测\",                    \"c52Link\": \"http://match.sports.sina.com.cn/livecast/g/live.php?id=165725\",                    \"liveid\": \"942847\"                },                {                    \"c1\": \"未开赛\",                    \"c2\": \"09-21周四\",                    \"c3\": \"04:00\",                    \"c4T1\": \"塞维利亚\",                    \"c4T1URL\": \"http://match.sports.sina.com.cn/football/team.php?id=166\",                    \"c4R\": \"VS\",                    \"c4T2\": \"拉斯帕尔马斯\",                    \"c4T2URL\": \"http://match.sports.sina.com.cn/football/team.php?id=221\",                    \"c51\": \"视频暂无\",                    \"c51Link\": \"\",                    \"c52\": \"前瞻预测\",                    \"c52Link\": \"http://match.sports.sina.com.cn/livecast/g/live.php?id=165726\",                    \"liveid\": \"942841\"                },                {                    \"c1\": \"未开赛\",                    \"c2\": \"09-22周五\",                    \"c3\": \"02:00\",                    \"c4T1\": \"比利亚雷亚尔\",                    \"c4T1URL\": \"http://match.sports.sina.com.cn/football/team.php?id=219\",                    \"c4R\": \"VS\",                    \"c4T2\": \"西班牙人\",                    \"c4T2URL\": \"http://match.sports.sina.com.cn/football/team.php?id=182\",                    \"c51\": \"视频暂无\",                    \"c51Link\": \"\",                    \"c52\": \"前瞻预测\",                    \"c52Link\": \"http://match.sports.sina.com.cn/livecast/g/live.php?id=165728\",                    \"liveid\": \"942844\"                },                {                    \"c1\": \"未开赛\",                    \"c2\": \"09-22周五\",                    \"c3\": \"03:00\",                    \"c4T1\": \"维戈塞尔塔\",                    \"c4T1URL\": \"http://match.sports.sina.com.cn/football/team.php?id=165\",                    \"c4R\": \"VS\",                    \"c4T2\": \"赫塔菲\",                    \"c4T2URL\": \"http://match.sports.sina.com.cn/football/team.php?id=4405\",                    \"c51\": \"视频暂无\",                    \"c51Link\": \"\",                    \"c52\": \"前瞻预测\",                    \"c52Link\": \"http://match.sports.sina.com.cn/livecast/g/live.php?id=165721\",                    \"liveid\": \"942839\"                },                {                    \"c1\": \"未开赛\",                    \"c2\": \"09-22周五\",                    \"c3\": \"04:00\",                    \"c4T1\": \"莱万特\",                    \"c4T1URL\": \"http://match.sports.sina.com.cn/football/team.php?id=4385\",                    \"c4R\": \"VS\",                    \"c4T2\": \"皇家社会\",                    \"c4T2URL\": \"http://match.sports.sina.com.cn/football/team.php?id=160\",                    \"c51\": \"视频暂无\",                    \"c51Link\": \"\",                    \"c52\": \"前瞻预测\",                    \"c52Link\": \"http://match.sports.sina.com.cn/livecast/g/live.php?id=165724\",                    \"liveid\": \"942842\"                }            ],            \"saicheng2\": [                {                    \"c1\": \"未开赛\",                    \"c2\": \"09-23周六\",                    \"c3\": \"19:00\",                    \"c4T1\": \"马德里竞技\",                    \"c4T1URL\": \"http://match.sports.sina.com.cn/football/team.php?id=162\",                    \"c4R\": \"VS\",                    \"c4T2\": \"塞维利亚\",                    \"c4T2URL\": \"http://match.sports.sina.com.cn/football/team.php?id=166\",                    \"c51\": \"视频暂无\",                    \"c51Link\": \"\",                    \"c52\": \"前瞻预测\",                    \"c52Link\": \"http://match.sports.sina.com.cn/livecast/g/live.php?id=165730\",                    \"liveid\": \"942852\"                },                {                    \"c1\": \"未开赛\",                    \"c2\": \"09-23周六\",                    \"c3\": \"22:15\",                    \"c4T1\": \"阿拉维斯\",                    \"c4T1URL\": \"http://match.sports.sina.com.cn/football/team.php?id=155\",                    \"c4R\": \"VS\",                    \"c4T2\": \"皇家马德里\",                    \"c4T2URL\": \"http://match.sports.sina.com.cn/football/team.php?id=157\",                    \"c51\": \"视频暂无\",                    \"c51Link\": \"\",                    \"c52\": \"前瞻预测\",                    \"c52Link\": \"http://match.sports.sina.com.cn/livecast/g/live.php?id=165729\",                    \"liveid\": \"942849\"                },                {                    \"c1\": \"未开赛\",                    \"c2\": \"09-24周日\",                    \"c3\": \"00:30\",                    \"c4T1\": \"马拉加\",                    \"c4T1URL\": \"http://match.sports.sina.com.cn/football/team.php?id=163\",                    \"c4R\": \"VS\",                    \"c4T2\": \"毕尔巴鄂竞技\",                    \"c4T2URL\": \"http://match.sports.sina.com.cn/football/team.php?id=131\",                    \"c51\": \"视频暂无\",                    \"c51Link\": \"\",                    \"c52\": \"前瞻预测\",                    \"c52Link\": \"http://match.sports.sina.com.cn/livecast/g/live.php?id=165736\",                    \"liveid\": \"942850\"                },                {                    \"c1\": \"未开赛\",                    \"c2\": \"09-24周日\",                    \"c3\": \"02:45\",                    \"c4T1\": \"赫罗纳\",                    \"c4T1URL\": \"http://match.sports.sina.com.cn/football/team.php?id=13869\",                    \"c4R\": \"VS\",                    \"c4T2\": \"巴塞罗那\",                    \"c4T2URL\": \"http://match.sports.sina.com.cn/football/team.php?id=130\",                    \"c51\": \"视频暂无\",                    \"c51Link\": \"\",                    \"c52\": \"前瞻预测\",                    \"c52Link\": \"http://match.sports.sina.com.cn/livecast/g/live.php?id=165734\",                    \"liveid\": \"942854\"                },                {                    \"c1\": \"未开赛\",                    \"c2\": \"09-24周日\",                    \"c3\": \"18:00\",                    \"c4T1\": \"西班牙人\",                    \"c4T1URL\": \"http://match.sports.sina.com.cn/football/team.php?id=182\",                    \"c4R\": \"VS\",                    \"c4T2\": \"拉科鲁尼亚\",                    \"c4T2URL\": \"http://match.sports.sina.com.cn/football/team.php?id=161\",                    \"c51\": \"视频暂无\",                    \"c51Link\": \"\",                    \"c52\": \"前瞻预测\",                    \"c52Link\": \"http://match.sports.sina.com.cn/livecast/g/live.php?id=165732\",                    \"liveid\": \"942851\"                },                {                    \"c1\": \"未开赛\",                    \"c2\": \"09-24周日\",                    \"c3\": \"22:15\",                    \"c4T1\": \"赫塔菲\",                    \"c4T1URL\": \"http://match.sports.sina.com.cn/football/team.php?id=4405\",                    \"c4R\": \"VS\",                    \"c4T2\": \"比利亚雷亚尔\",                    \"c4T2URL\": \"http://match.sports.sina.com.cn/football/team.php?id=219\",                    \"c51\": \"视频暂无\",                    \"c51Link\": \"\",                    \"c52\": \"前瞻预测\",                    \"c52Link\": \"http://match.sports.sina.com.cn/livecast/g/live.php?id=165733\",                    \"liveid\": \"942855\"                },                {                    \"c1\": \"未开赛\",                    \"c2\": \"09-25周一\",                    \"c3\": \"00:30\",                    \"c4T1\": \"埃瓦尔\",                    \"c4T1URL\": \"http://match.sports.sina.com.cn/football/team.php?id=4417\",                    \"c4R\": \"VS\",                    \"c4T2\": \"维戈塞尔塔\",                    \"c4T2URL\": \"http://match.sports.sina.com.cn/football/team.php?id=165\",                    \"c51\": \"视频暂无\",                    \"c51Link\": \"\",                    \"c52\": \"前瞻预测\",                    \"c52Link\": \"http://match.sports.sina.com.cn/livecast/g/live.php?id=165731\",                    \"liveid\": \"942857\"                },                {                    \"c1\": \"未开赛\",                    \"c2\": \"09-25周一\",                    \"c3\": \"00:30\",                    \"c4T1\": \"拉斯帕尔马斯\",                    \"c4T1URL\": \"http://match.sports.sina.com.cn/football/team.php?id=221\",                    \"c4R\": \"VS\",                    \"c4T2\": \"莱加内斯\",                    \"c4T2URL\": \"http://match.sports.sina.com.cn/football/team.php?id=4526\",                    \"c51\": \"视频暂无\",                    \"c51Link\": \"\",                    \"c52\": \"前瞻预测\",                    \"c52Link\": \"http://match.sports.sina.com.cn/livecast/g/live.php?id=165735\",                    \"liveid\": \"942853\"                },                {                    \"c1\": \"未开赛\",                    \"c2\": \"09-25周一\",                    \"c3\": \"02:45\",                    \"c4T1\": \"皇家社会\",                    \"c4T1URL\": \"http://match.sports.sina.com.cn/football/team.php?id=160\",                    \"c4R\": \"VS\",                    \"c4T2\": \"瓦伦西亚\",                    \"c4T2URL\": \"http://match.sports.sina.com.cn/football/team.php?id=169\",                    \"c51\": \"视频暂无\",                    \"c51Link\": \"\",                    \"c52\": \"前瞻预测\",                    \"c52Link\": \"http://match.sports.sina.com.cn/livecast/g/live.php?id=165738\",                    \"liveid\": \"942858\"                },                {                    \"c1\": \"未开赛\",                    \"c2\": \"09-26周二\",                    \"c3\": \"03:00\",                    \"c4T1\": \"皇家贝蒂斯\",                    \"c4T1URL\": \"http://match.sports.sina.com.cn/football/team.php?id=154\",                    \"c4R\": \"VS\",                    \"c4T2\": \"莱万特\",                    \"c4T2URL\": \"http://match.sports.sina.com.cn/football/team.php?id=4385\",                    \"c51\": \"视频暂无\",                    \"c51Link\": \"\",                    \"c52\": \"前瞻预测\",                    \"c52Link\": \"http://match.sports.sina.com.cn/livecast/g/live.php?id=165737\",                    \"liveid\": \"942856\"                }            ],            \"saicheng3\": null,            \"jifenbang\": [                {                    \"c1\": \"1\",                    \"c2\": \"巴塞罗那\",                    \"c2L\": \"http://match.sports.sina.com.cn/football/team.php?id=130\",                    \"c3\": \"5\",                    \"c41\": \"5\",                    \"c42\": \"0\",                    \"c43\": \"0\",                    \"c5\": \"15\",                    \"c6\": \"15\"                },                {                    \"c1\": \"2\",                    \"c2\": \"塞维利亚\",                    \"c2L\": \"http://match.sports.sina.com.cn/football/team.php?id=166\",                    \"c3\": \"4\",                    \"c41\": \"3\",                    \"c42\": \"1\",                    \"c43\": \"0\",                    \"c5\": \"5\",                    \"c6\": \"10\"                },                {                    \"c1\": \"3\",                    \"c2\": \"瓦伦西亚\",                    \"c2L\": \"http://match.sports.sina.com.cn/football/team.php?id=169\",                    \"c3\": \"5\",                    \"c41\": \"2\",                    \"c42\": \"3\",                    \"c43\": \"0\",                    \"c5\": \"6\",                    \"c6\": \"9\"                },                {                    \"c1\": \"4\",                    \"c2\": \"皇家社会\",                    \"c2L\": \"http://match.sports.sina.com.cn/football/team.php?id=160\",                    \"c3\": \"4\",                    \"c41\": \"3\",                    \"c42\": \"0\",                    \"c43\": \"1\",                    \"c5\": \"4\",                    \"c6\": \"9\"                },                {                    \"c1\": \"5\",                    \"c2\": \"皇家马德里\",                    \"c2L\": \"http://match.sports.sina.com.cn/football/team.php?id=157\",                    \"c3\": \"4\",                    \"c41\": \"2\",                    \"c42\": \"2\",                    \"c43\": \"0\",                    \"c5\": \"5\",                    \"c6\": \"8\"                },                {                    \"c1\": \"6\",                    \"c2\": \"马德里竞技\",                    \"c2L\": \"http://match.sports.sina.com.cn/football/team.php?id=162\",                    \"c3\": \"4\",                    \"c41\": \"2\",                    \"c42\": \"2\",                    \"c43\": \"0\",                    \"c5\": \"5\",                    \"c6\": \"8\"                },                {                    \"c1\": \"7\",                    \"c2\": \"毕尔巴鄂竞技\",                    \"c2L\": \"http://match.sports.sina.com.cn/football/team.php?id=131\",                    \"c3\": \"4\",                    \"c41\": \"2\",                    \"c42\": \"1\",                    \"c43\": \"1\",                    \"c5\": \"2\",                    \"c6\": \"7\"                },                {                    \"c1\": \"8\",                    \"c2\": \"比利亚雷亚尔\",                    \"c2L\": \"http://match.sports.sina.com.cn/football/team.php?id=219\",                    \"c3\": \"4\",                    \"c41\": \"2\",                    \"c42\": \"0\",                    \"c43\": \"2\",                    \"c5\": \"1\",                    \"c6\": \"6\"                },                {                    \"c1\": \"9\",                    \"c2\": \"莱万特\",                    \"c2L\": \"http://match.sports.sina.com.cn/football/team.php?id=4385\",                    \"c3\": \"4\",                    \"c41\": \"1\",                    \"c42\": \"3\",                    \"c43\": \"0\",                    \"c5\": \"1\",                    \"c6\": \"6\"                },                {                    \"c1\": \"10\",                    \"c2\": \"莱加内斯\",                    \"c2L\": \"http://match.sports.sina.com.cn/football/team.php?id=4526\",                    \"c3\": \"4\",                    \"c41\": \"2\",                    \"c42\": \"0\",                    \"c43\": \"2\",                    \"c5\": \"0\",                    \"c6\": \"6\"                }            ],            \"sheshoubang\": [                {                    \"c1\": \"1\",                    \"c2\": \"梅西\",                    \"c2L\": \"http://match.sports.sina.com.cn/football/player.php?id=19054\",                    \"c3\": \"巴塞罗那\",                    \"c3L\": \"http://match.sports.sina.com.cn/football/team.php?id=130\",                    \"c4\": \"9\",                    \"c5\": \"1\"                },                {                    \"c1\": \"2\",                    \"c2\": \"戈麦斯\",                    \"c2L\": \"http://match.sports.sina.com.cn/football/player.php?id=215206\",                    \"c3\": \"维戈塞尔塔\",                    \"c3L\": \"http://match.sports.sina.com.cn/football/team.php?id=165\",                    \"c4\": \"4\",                    \"c5\": \"0\"                },                {                    \"c1\": \"3\",                    \"c2\": \"扎乍\",                    \"c2L\": \"http://match.sports.sina.com.cn/football/player.php?id=60270\",                    \"c3\": \"瓦伦西亚\",                    \"c3L\": \"http://match.sports.sina.com.cn/football/team.php?id=169\",                    \"c4\": \"4\",                    \"c5\": \"0\"                },                {                    \"c1\": \"4\",                    \"c2\": \"胡安米\",                    \"c2L\": \"http://match.sports.sina.com.cn/football/player.php?id=80287\",                    \"c3\": \"皇家社会\",                    \"c3L\": \"http://match.sports.sina.com.cn/football/team.php?id=160\",                    \"c4\": \"3\",                    \"c5\": \"0\"                },                {                    \"c1\": \"5\",                    \"c2\": \"保利尼奥\",                    \"c2L\": \"http://match.sports.sina.com.cn/football/player.php?id=100534\",                    \"c3\": \"巴塞罗那\",                    \"c3L\": \"http://match.sports.sina.com.cn/football/team.php?id=130\",                    \"c4\": \"2\",                    \"c5\": \"0\"                },                {                    \"c1\": \"6\",                    \"c2\": \"苏亚雷斯\",                    \"c2L\": \"http://match.sports.sina.com.cn/football/player.php?id=89572\",                    \"c3\": \"巴塞罗那\",                    \"c3L\": \"http://match.sports.sina.com.cn/football/team.php?id=130\",                    \"c4\": \"2\",                    \"c5\": \"0\"                },                {                    \"c1\": \"7\",                    \"c2\": \"科雷阿\",                    \"c2L\": \"http://match.sports.sina.com.cn/football/player.php?id=156223\",                    \"c3\": \"马德里竞技\",                    \"c3L\": \"http://match.sports.sina.com.cn/football/team.php?id=162\",                    \"c4\": \"2\",                    \"c5\": \"0\"                },                {                    \"c1\": \"8\",                    \"c2\": \"加雷斯-贝尔\",                    \"c2L\": \"http://match.sports.sina.com.cn/football/player.php?id=36903\",                    \"c3\": \"皇家马德里\",                    \"c3L\": \"http://match.sports.sina.com.cn/football/team.php?id=157\",                    \"c4\": \"2\",                    \"c5\": \"0\"                },                {                    \"c1\": \"9\",                    \"c2\": \"华金\",                    \"c2L\": \"http://match.sports.sina.com.cn/football/player.php?id=10316\",                    \"c3\": \"皇家贝蒂斯\",                    \"c3L\": \"http://match.sports.sina.com.cn/football/team.php?id=154\",                    \"c4\": \"2\",                    \"c5\": \"0\"                },                {                    \"c1\": \"10\",                    \"c2\": \"罗德里戈\",                    \"c2L\": \"http://match.sports.sina.com.cn/football/player.php?id=80954\",                    \"c3\": \"瓦伦西亚\",                    \"c3L\": \"http://match.sports.sina.com.cn/football/team.php?id=169\",                    \"c4\": \"2\",                    \"c5\": \"0\"                }            ]        }    },    \"error_code\": 0}";



    private static String ceshistr2="{\"reason\": \"查询成功\",\"result\": {\"key\": \"皇家马德里阿尔梅里亚\",\"list\": [{\"date\": \"12-13周六\",\"link1content\": \"视频暂无\",\"link1url\": \"\",\"link2content\": \"图文直播\",\"link2url\": \"http://match.sports.sina.com.cn/livecast/g/live.php?id=112892\",\"link3content\": \"\",\"link3url\": \"\",\"live\": \"\",\"score\": \"VS\",\"team1\": \"阿尔梅里亚\",\"team1icon\": \"http://www.sinaimg.cn/ty/2013/0813/U5244P6DT20130813113821.png\",\"team1url\": \"http://match.sports.sina.com.cn/football/team.php?id=4418\",\"team2\": \"皇家马德里\",\"team2icon\": \"http://www.sinaimg.cn/ty/2013/0510/U5244P6DT20130510172217.jpg\",\"team2url\": \"http://match.sports.sina.com.cn/football/team.php?id=157\",\"time\": \"03:45\"},{\"date\": \"04-29周三\",\"link1content\": \"视频暂无\",\"link1url\": \"\",\"link2content\": \"图文直播\",\"link2url\": \"http://match.sports.sina.com.cn/livecast/g/live.php?id=113090\",\"link3content\": \"\",\"link3url\": \"\",\"live\": \"\",\"score\": \"VS\",\"team1\": \"皇家马德里\",\"team1icon\": \"http://www.sinaimg.cn/ty/2013/0510/U5244P6DT20130510172217.jpg\",\"team1url\": \"http://match.sports.sina.com.cn/football/team.php?id=157\",\"team2\": \"阿尔梅里亚\",\"team2icon\": \"http://www.sinaimg.cn/ty/2013/0813/U5244P6DT20130813113821.png\",\"team2url\": \"http://match.sports.sina.com.cn/football/team.php?id=4418\",\"time\": \"23:00\"}]},\"error_code\": 0}";























}