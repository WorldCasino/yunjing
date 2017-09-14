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

import com.cicada.commons.utils.DateFormatUtil;
import com.cicada.commons.utils.DateUtil;
import com.cicada.commons.utils.SpringContextUtil;
import com.cicada.commons.utils.SystemConfig;
import com.cicada.enums.MatchesStatusEnum;
import com.cicada.enums.MatchesTypeEnum;
import com.cicada.pojo.MatchesEntity;
import com.cicada.service.impl.MatchesServiceImpl;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 *足球联赛调用示例代码 － 聚合数据
 *在线接口文档：http://www.juhe.cn/docs/90
 **/

public class FootBallMatchUtil {
    public static final String DEF_CHATSET = "UTF-8";
    public static final int DEF_CONN_TIMEOUT = 30000;
    public static final int DEF_READ_TIMEOUT = 30000;
    public static String userAgent =  "Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/29.0.1547.66 Safari/537.36";


    private static String[] str={"英超","西甲","德甲","意甲","法甲","中超" };

    //配置您申请的KEY
    public static final String APPKEY ="31609450dd1411379218d98b6b3a1610";

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
                JSONObject object = JSONObject.fromObject(result);
                if(object.getInt("error_code")==0){
                    JSONObject jsonObject=object.getJSONObject("result");
                    String keytitle=jsonObject.getString("key");
                    JSONObject views=jsonObject.getJSONObject("views");
                    JSONObject tabls=jsonObject.getJSONObject("tabs");
                    Iterator it = tabls.keys();
                    while (it.hasNext()) {
                        String key = (String) it.next();
                        if(!key.contains("saicheng")){
                            continue;
                        }
                        String value = tabls.getString(key);
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
                            String score=jsonObject2.getString("c4R");
                            String home_score="";
                            String away_score="";
                            if(!score.equals("VS")){
                                home_score=score.split("-")[0];
                                away_score=score.split("-")[1];
                            }
                            BallUtil.SaveMatch( home_team_name,"", away_team_name,"", day_week, day_date, day_time, keytitle+value, MatchesTypeEnum.Football.getDesc().toString(),home_score,away_score);
                        }
                    }
                }else{
                    System.out.println(object.get("error_code")+":"+object.get("reason"));
                }
            }
            //开始存储
             BallUtil.changeRedisBallList(MatchesTypeEnum.Football.getDesc().toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
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
    public static boolean flagIsOver(long matchId,String home_team_name,String away_team_name,String day_date,String day_time){
        boolean flag=false;
        String result =null;
        String url = SystemConfig.getInstance().getBALL_MATCH_FOOTBALL_COMBAT();//请求接口地址
        Map params = new HashMap();//请求参数
        params.put("key",APPKEY);//应用APPKEY(应用详细页查询)
        params.put("dtype","");//返回数据的格式,xml或json，默认json
        params.put("hteam",home_team_name);//主队球队名称
        params.put("vteam",away_team_name);//客队球队名称
        try {
            result =net(url, params, "GET");
            JSONObject object = JSONObject.fromObject(result);
            if(object.getInt("error_code")==0){
                 JSONObject jsonObject=object.getJSONObject("result");
                 System.out.println(jsonObject.toString());
                 JSONArray jsonArray=jsonObject.getJSONArray("list");
                for (int i = 0; i < jsonArray.size() ; i++) {
                    JSONObject jsonObject2=jsonArray.getJSONObject(i);
                    String team1=jsonObject2.getString("team1");
                    String team2=jsonObject2.getString("team2");
                    String score=jsonObject2.getString("score");
                    String date=jsonObject2.getString("date");
                    String time=jsonObject2.getString("time");
                    //判断是否是当前球队比赛
                    if(time.equals(day_time) && date.contains(day_date)){
                        MatchesEntity matchesEntity=new MatchesEntity();
                        matchesEntity.setMatchId(matchId);
                        String home_score="0";
                        String away_score="0";
                        if(!score.equals("VS")){
                            //比赛结束开始计算
                            flag=true;
                            matchesEntity.setSettleTime(new Timestamp(System.currentTimeMillis()));
                            matchesEntity.setMatchesStatusEnum(MatchesStatusEnum.IsOver);
                            home_score=score.split("-")[0];
                            away_score=score.split("-")[1];
                        }
                        matchesEntity.setHomeScore(Integer.parseInt(home_score));
                        matchesEntity.setAwayScore(Integer.parseInt(away_score));
                        ((MatchesServiceImpl) SpringContextUtil.getBean("matchesServiceImpl")).updateById(matchesEntity);
                    }else{
                        continue;
                    }
                }
            }else{
                System.out.println(object.get("error_code")+":"+object.get("reason"));
            }
        } catch (Exception e) {
            e.printStackTrace();
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

private  static  String ceshistr1="{\"reason\": \"查询成功\",\"result\": {\"key\": \"法甲\",\"tabs\": {\"saicheng1\": \"第17轮赛程\",\"saicheng2\": \"第18轮赛程\",\"saicheng3\": null,\"jifenbang\": \"积分榜\",\"sheshoubang\": \"射手榜\"},\"views\": {\"saicheng1\": [{\"c1\": \"未开赛\",\"c2\": \"12-06周六\",\"c3\": \"03:30\",\"c4R\": \"VS\",\"c4T1\": \"图卢兹\",\"c4T1URL\": \"http://match.sports.sina.com.cn/football/team.php?id=486\",\"c4T2\": \"摩纳哥\",\"c4T2URL\": \"http://match.sports.sina.com.cn/football/team.php?id=317\",\"c51\": \"视频暂无\",\"c51Link\": \"\",\"c52\": \"图文直播\",\"c52Link\": \"http://match.sports.sina.com.cn/livecast/g/live.php?id=111967\"},{\"c1\": \"未开赛\",\"c2\": \"12-07周日\",\"c3\": \"00:00\",\"c4R\": \"VS\",\"c4T1\": \"巴黎圣日耳曼\",\"c4T1URL\": \"http://match.sports.sina.com.cn/football/team.php?id=316\",\"c4T2\": \"南特\",\"c4T2URL\": \"http://match.sports.sina.com.cn/football/team.php?id=480\",\"c51\": \"视频暂无\",\"c51Link\": \"\",\"c52\": \"图文直播\",\"c52Link\": \"http://match.sports.sina.com.cn/livecast/g/live.php?id=111963\"},{\"c1\": \"未开赛\",\"c2\": \"12-07周日\",\"c3\": \"03:00\",\"c4R\": \"VS\",\"c4T1\": \"波尔多\",\"c4T1URL\": \"http://match.sports.sina.com.cn/football/team.php?id=476\",\"c4T2\": \"洛里昂\",\"c4T2URL\": \"http://match.sports.sina.com.cn/football/team.php?id=1385\",\"c51\": \"视频暂无\",\"c51Link\": \"\",\"c52\": \"图文直播\",\"c52Link\": \"http://match.sports.sina.com.cn/livecast/g/live.php?id=111958\"},{\"c1\": \"未开赛\",\"c2\": \"12-07周日\",\"c3\": \"03:00\",\"c4R\": \"VS\",\"c4T1\": \"卡昂\",\"c4T1URL\": \"http://match.sports.sina.com.cn/football/team.php?id=10165\",\"c4T2\": \"尼斯\",\"c4T2URL\": \"http://match.sports.sina.com.cn/football/team.php?id=3165\",\"c51\": \"视频暂无\",\"c51Link\": \"\",\"c52\": \"图文直播\",\"c52Link\": \"http://match.sports.sina.com.cn/livecast/g/live.php?id=111959\"},{\"c1\": \"未开赛\",\"c2\": \"12-07周日\",\"c3\": \"03:00\",\"c4R\": \"VS\",\"c4T1\": \"雷恩\",\"c4T1URL\": \"http://match.sports.sina.com.cn/football/team.php?id=477\",\"c4T2\": \"蒙彼利埃\",\"c4T2URL\": \"http://match.sports.sina.com.cn/football/team.php?id=1626\",\"c51\": \"视频暂无\",\"c51Link\": \"\",\"c52\": \"图文直播\",\"c52Link\": \"http://match.sports.sina.com.cn/livecast/g/live.php?id=111965\"},{\"c1\": \"未开赛\",\"c2\": \"12-07周日\",\"c3\": \"03:00\",\"c4R\": \"VS\",\"c4T1\": \"圣埃蒂安\",\"c4T1URL\": \"http://match.sports.sina.com.cn/football/team.php?id=483\",\"c4T2\": \"巴斯蒂亚\",\"c4T2URL\": \"http://match.sports.sina.com.cn/football/team.php?id=376\",\"c51\": \"视频暂无\",\"c51Link\": \"\",\"c52\": \"图文直播\",\"c52Link\": \"http://match.sports.sina.com.cn/livecast/g/live.php?id=111966\"},{\"c1\": \"未开赛\",\"c2\": \"12-07周日\",\"c3\": \"21:00\",\"c4R\": \"VS\",\"c4T1\": \"埃维昂\",\"c4T1URL\": \"http://match.sports.sina.com.cn/football/team.php?id=35151\",\"c4T2\": \"里昂\",\"c4T2URL\": \"http://match.sports.sina.com.cn/football/team.php?id=436\",\"c51\": \"视频暂无\",\"c51Link\": \"\",\"c52\": \"图文直播\",\"c52Link\": \"http://match.sports.sina.com.cn/livecast/g/live.php?id=111960\"},{\"c1\": \"未开赛\",\"c2\": \"12-08周一\",\"c3\": \"00:00\",\"c4R\": \"VS\",\"c4T1\": \"朗斯\",\"c4T1URL\": \"http://match.sports.sina.com.cn/football/team.php?id=396\",\"c4T2\": \"里尔\",\"c4T2URL\": \"http://match.sports.sina.com.cn/football/team.php?id=456\",\"c51\": \"视频暂无\",\"c51Link\": \"\",\"c52\": \"图文直播\",\"c52Link\": \"http://match.sports.sina.com.cn/livecast/g/live.php?id=111961\"},{\"c1\": \"未开赛\",\"c2\": \"12-08周一\",\"c3\": \"00:00\",\"c4R\": \"VS\",\"c4T1\": \"兰斯\",\"c4T1URL\": \"http://match.sports.sina.com.cn/football/team.php?id=13205\",\"c4T2\": \"甘冈\",\"c4T2URL\": \"http://match.sports.sina.com.cn/football/team.php?id=416\",\"c51\": \"视频暂无\",\"c51Link\": \"\",\"c52\": \"图文直播\",\"c52Link\": \"http://match.sports.sina.com.cn/livecast/g/live.php?id=111964\"},{\"c1\": \"未开赛\",\"c2\": \"12-08周一\",\"c3\": \"04:00\",\"c4R\": \"VS\",\"c4T1\": \"马赛\",\"c4T1URL\": \"http://match.sports.sina.com.cn/football/team.php?id=478\",\"c4T2\": \"梅斯\",\"c4T2URL\": \"http://match.sports.sina.com.cn/football/team.php?id=479\",\"c51\": \"视频暂无\",\"c51Link\": \"\",\"c52\": \"图文直播\",\"c52Link\": \"http://match.sports.sina.com.cn/livecast/g/live.php?id=111962\"}],\"saicheng2\": [{\"c1\": \"未开赛\",\"c2\": \"12-13周六\",\"c3\": \"03:30\",\"c4R\": \"VS\",\"c4T1\": \"里昂\",\"c4T1URL\": \"http://match.sports.sina.com.cn/football/team.php?id=436\",\"c4T2\": \"卡昂\",\"c4T2URL\": \"http://match.sports.sina.com.cn/football/team.php?id=10165\",\"c51\": \"视频暂无\",\"c51Link\": \"\",\"c52\": \"图文直播\",\"c52Link\": \"http://match.sports.sina.com.cn/livecast/g/live.php?id=111972\"},{\"c1\": \"未开赛\",\"c2\": \"12-14周日\",\"c3\": \"00:00\",\"c4R\": \"VS\",\"c4T1\": \"南特\",\"c4T1URL\": \"http://match.sports.sina.com.cn/football/team.php?id=480\",\"c4T2\": \"波尔多\",\"c4T2URL\": \"http://match.sports.sina.com.cn/football/team.php?id=476\",\"c51\": \"视频暂无\",\"c51Link\": \"\",\"c52\": \"图文直播\",\"c52Link\": \"http://match.sports.sina.com.cn/livecast/g/live.php?id=111975\"},{\"c1\": \"未开赛\",\"c2\": \"12-14周日\",\"c3\": \"03:00\",\"c4R\": \"VS\",\"c4T1\": \"巴斯蒂亚\",\"c4T1URL\": \"http://match.sports.sina.com.cn/football/team.php?id=376\",\"c4T2\": \"雷恩\",\"c4T2URL\": \"http://match.sports.sina.com.cn/football/team.php?id=477\",\"c51\": \"视频暂无\",\"c51Link\": \"\",\"c52\": \"图文直播\",\"c52Link\": \"http://match.sports.sina.com.cn/livecast/g/live.php?id=111968\"},{\"c1\": \"未开赛\",\"c2\": \"12-14周日\",\"c3\": \"03:00\",\"c4R\": \"VS\",\"c4T1\": \"洛里昂\",\"c4T1URL\": \"http://match.sports.sina.com.cn/football/team.php?id=1385\",\"c4T2\": \"梅斯\",\"c4T2URL\": \"http://match.sports.sina.com.cn/football/team.php?id=479\",\"c51\": \"视频暂无\",\"c51Link\": \"\",\"c52\": \"图文直播\",\"c52Link\": \"http://match.sports.sina.com.cn/livecast/g/live.php?id=111971\"},{\"c1\": \"未开赛\",\"c2\": \"12-14周日\",\"c3\": \"03:00\",\"c4R\": \"VS\",\"c4T1\": \"蒙彼利埃\",\"c4T1URL\": \"http://match.sports.sina.com.cn/football/team.php?id=1626\",\"c4T2\": \"朗斯\",\"c4T2URL\": \"http://match.sports.sina.com.cn/football/team.php?id=396\",\"c51\": \"视频暂无\",\"c51Link\": \"\",\"c52\": \"图文直播\",\"c52Link\": \"http://match.sports.sina.com.cn/livecast/g/live.php?id=111974\"},{\"c1\": \"未开赛\",\"c2\": \"12-14周日\",\"c3\": \"03:00\",\"c4R\": \"VS\",\"c4T1\": \"兰斯\",\"c4T1URL\": \"http://match.sports.sina.com.cn/football/team.php?id=13205\",\"c4T2\": \"埃维昂\",\"c4T2URL\": \"http://match.sports.sina.com.cn/football/team.php?id=35151\",\"c51\": \"视频暂无\",\"c51Link\": \"\",\"c52\": \"图文直播\",\"c52Link\": \"http://match.sports.sina.com.cn/livecast/g/live.php?id=111977\"},{\"c1\": \"未开赛\",\"c2\": \"12-14周日\",\"c3\": \"21:00\",\"c4R\": \"VS\",\"c4T1\": \"尼斯\",\"c4T1URL\": \"http://match.sports.sina.com.cn/football/team.php?id=3165\",\"c4T2\": \"圣埃蒂安\",\"c4T2URL\": \"http://match.sports.sina.com.cn/football/team.php?id=483\",\"c51\": \"视频暂无\",\"c51Link\": \"\",\"c52\": \"图文直播\",\"c52Link\": \"http://match.sports.sina.com.cn/livecast/g/live.php?id=111976\"},{\"c1\": \"未开赛\",\"c2\": \"12-15周一\",\"c3\": \"00:00\",\"c4R\": \"VS\",\"c4T1\": \"甘冈\",\"c4T1URL\": \"http://match.sports.sina.com.cn/football/team.php?id=416\",\"c4T2\": \"巴黎圣日耳曼\",\"c4T2URL\": \"http://match.sports.sina.com.cn/football/team.php?id=316\",\"c51\": \"视频暂无\",\"c51Link\": \"\",\"c52\": \"图文直播\",\"c52Link\": \"http://match.sports.sina.com.cn/livecast/g/live.php?id=111969\"},{\"c1\": \"未开赛\",\"c2\": \"12-15周一\",\"c3\": \"00:00\",\"c4R\": \"VS\",\"c4T1\": \"里尔\",\"c4T1URL\": \"http://match.sports.sina.com.cn/football/team.php?id=456\",\"c4T2\": \"图卢兹\",\"c4T2URL\": \"http://match.sports.sina.com.cn/football/team.php?id=486\",\"c51\": \"视频暂无\",\"c51Link\": \"\",\"c52\": \"图文直播\",\"c52Link\": \"http://match.sports.sina.com.cn/livecast/g/live.php?id=111970\"},{\"c1\": \"未开赛\",\"c2\": \"12-15周一\",\"c3\": \"04:00\",\"c4R\": \"VS\",\"c4T1\": \"摩纳哥\",\"c4T1URL\": \"http://match.sports.sina.com.cn/football/team.php?id=317\",\"c4T2\": \"马赛\",\"c4T2URL\": \"http://match.sports.sina.com.cn/football/team.php?id=478\",\"c51\": \"视频暂无\",\"c51Link\": \"\",\"c52\": \"图文直播\",\"c52Link\": \"http://match.sports.sina.com.cn/livecast/g/live.php?id=111973\"}],\"saicheng3\": null,\"jifenbang\": [{\"c1\": \"1\",\"c2\": \"马赛\",\"c2L\": \"http://match.sports.sina.com.cn/football/team.php?id=478\",\"c3\": \"16\",\"c41\": \"11\",\"c42\": \"2\",\"c43\": \"3\",\"c5\": \"19\",\"c6\": \"35\"},{\"c1\": \"2\",\"c2\": \"巴黎圣日耳曼\",\"c2L\": \"http://match.sports.sina.com.cn/football/team.php?id=316\",\"c3\": \"16\",\"c41\": \"9\",\"c42\": \"7\",\"c43\": \"0\",\"c5\": \"19\",\"c6\": \"34\"},{\"c1\": \"3\",\"c2\": \"圣埃蒂安\",\"c2L\": \"http://match.sports.sina.com.cn/football/team.php?id=483\",\"c3\": \"16\",\"c41\": \"8\",\"c42\": \"5\",\"c43\": \"3\",\"c5\": \"6\",\"c6\": \"29\"},{\"c1\": \"4\",\"c2\": \"雷恩\",\"c2L\": \"http://match.sports.sina.com.cn/football/team.php?id=477\",\"c3\": \"16\",\"c41\": \"8\",\"c42\": \"4\",\"c43\": \"4\",\"c5\": \"5\",\"c6\": \"28\"},{\"c1\": \"5\",\"c2\": \"波尔多\",\"c2L\": \"http://match.sports.sina.com.cn/football/team.php?id=476\",\"c3\": \"16\",\"c41\": \"8\",\"c42\": \"4\",\"c43\": \"4\",\"c5\": \"4\",\"c6\": \"28\"},{\"c1\": \"6\",\"c2\": \"里昂\",\"c2L\": \"http://match.sports.sina.com.cn/football/team.php?id=436\",\"c3\": \"15\",\"c41\": \"8\",\"c42\": \"3\",\"c43\": \"4\",\"c5\": \"13\",\"c6\": \"27\"},{\"c1\": \"7\",\"c2\": \"南特\",\"c2L\": \"http://match.sports.sina.com.cn/football/team.php?id=480\",\"c3\": \"16\",\"c41\": \"6\",\"c42\": \"6\",\"c43\": \"4\",\"c5\": \"1\",\"c6\": \"24\"},{\"c1\": \"8\",\"c2\": \"摩纳哥\",\"c2L\": \"http://match.sports.sina.com.cn/football/team.php?id=317\",\"c3\": \"16\",\"c41\": \"6\",\"c42\": \"5\",\"c43\": \"5\",\"c5\": \"1\",\"c6\": \"23\"},{\"c1\": \"9\",\"c2\": \"兰斯\",\"c2L\": \"http://match.sports.sina.com.cn/football/team.php?id=13205\",\"c3\": \"15\",\"c41\": \"6\",\"c42\": \"4\",\"c43\": \"5\",\"c5\": \"-6\",\"c6\": \"22\"},{\"c1\": \"10\",\"c2\": \"蒙彼利埃\",\"c2L\": \"http://match.sports.sina.com.cn/football/team.php?id=1626\",\"c3\": \"16\",\"c41\": \"6\",\"c42\": \"3\",\"c43\": \"7\",\"c5\": \"-2\",\"c6\": \"21\"}],\"sheshoubang\": [{\"c1\": \"1\",\"c2\": \"拉卡泽特\",\"c2L\": \"http://match.sports.sina.com.cn/football/player.php?id=59966\",\"c3\": \"里昂\",\"c3L\": \"http://match.sports.sina.com.cn/football/team.php?id=436\",\"c4\": \"11\",\"c5\": \"1\"},{\"c1\": \"2\",\"c2\": \"吉尼亚克\",\"c2L\": \"http://match.sports.sina.com.cn/football/player.php?id=37827\",\"c3\": \"马赛\",\"c3L\": \"http://match.sports.sina.com.cn/football/team.php?id=478\",\"c4\": \"11\",\"c5\": \"1\"},{\"c1\": \"3\",\"c2\": \"马迪巴\",\"c2L\": \"http://match.sports.sina.com.cn/football/player.php?id=90126\",\"c3\": \"雷恩\",\"c3L\": \"http://match.sports.sina.com.cn/football/team.php?id=477\",\"c4\": \"7\",\"c5\": \"0\"},{\"c1\": \"4\",\"c2\": \"沃斯\",\"c2L\": \"http://match.sports.sina.com.cn/football/player.php?id=56624\",\"c3\": \"埃维昂\",\"c3L\": \"http://match.sports.sina.com.cn/football/team.php?id=35151\",\"c4\": \"7\",\"c5\": \"1\"},{\"c1\": \"5\",\"c2\": \"本耶德尔\",\"c2L\": \"http://match.sports.sina.com.cn/football/player.php?id=83912\",\"c3\": \"图卢兹\",\"c3L\": \"http://match.sports.sina.com.cn/football/team.php?id=486\",\"c4\": \"7\",\"c5\": \"1\"},{\"c1\": \"6\",\"c2\": \"卡瓦尼\",\"c2L\": \"http://match.sports.sina.com.cn/football/player.php?id=40720\",\"c3\": \"巴黎圣日耳曼\",\"c3L\": \"http://match.sports.sina.com.cn/football/team.php?id=316\",\"c4\": \"7\",\"c5\": \"1\"},{\"c1\": \"7\",\"c2\": \"米奎尔-洛佩斯\",\"c2L\": \"http://match.sports.sina.com.cn/football/player.php?id=166552\",\"c3\": \"里昂\",\"c3L\": \"http://match.sports.sina.com.cn/football/team.php?id=436\",\"c4\": \"6\",\"c5\": \"0\"},{\"c1\": \"8\",\"c2\": \"爱德华多\",\"c2L\": \"http://match.sports.sina.com.cn/football/player.php?id=61841\",\"c3\": \"尼斯\",\"c3L\": \"http://match.sports.sina.com.cn/football/team.php?id=3165\",\"c4\": \"6\",\"c5\": \"0\"},{\"c1\": \"9\",\"c2\": \"伊布拉希莫维奇\",\"c2L\": \"http://match.sports.sina.com.cn/football/player.php?id=9808\",\"c3\": \"巴黎圣日耳曼\",\"c3L\": \"http://match.sports.sina.com.cn/football/team.php?id=316\",\"c4\": \"6\",\"c5\": \"1\"},{\"c1\": \"10\",\"c2\": \"迪亚巴特\",\"c2L\": \"http://match.sports.sina.com.cn/football/player.php?id=33103\",\"c3\": \"波尔多\",\"c3L\": \"http://match.sports.sina.com.cn/football/team.php?id=476\",\"c4\": \"6\",\"c5\": \"2\"}]}},\"error_code\": 0}";



private static String ceshistr2="{\"reason\": \"查询成功\",\"result\": {\"key\": \"皇家马德里阿尔梅里亚\",\"list\": [{\"date\": \"12-13周六\",\"link1content\": \"视频暂无\",\"link1url\": \"\",\"link2content\": \"图文直播\",\"link2url\": \"http://match.sports.sina.com.cn/livecast/g/live.php?id=112892\",\"link3content\": \"\",\"link3url\": \"\",\"live\": \"\",\"score\": \"VS\",\"team1\": \"阿尔梅里亚\",\"team1icon\": \"http://www.sinaimg.cn/ty/2013/0813/U5244P6DT20130813113821.png\",\"team1url\": \"http://match.sports.sina.com.cn/football/team.php?id=4418\",\"team2\": \"皇家马德里\",\"team2icon\": \"http://www.sinaimg.cn/ty/2013/0510/U5244P6DT20130510172217.jpg\",\"team2url\": \"http://match.sports.sina.com.cn/football/team.php?id=157\",\"time\": \"03:45\"},{\"date\": \"04-29周三\",\"link1content\": \"视频暂无\",\"link1url\": \"\",\"link2content\": \"图文直播\",\"link2url\": \"http://match.sports.sina.com.cn/livecast/g/live.php?id=113090\",\"link3content\": \"\",\"link3url\": \"\",\"live\": \"\",\"score\": \"VS\",\"team1\": \"皇家马德里\",\"team1icon\": \"http://www.sinaimg.cn/ty/2013/0510/U5244P6DT20130510172217.jpg\",\"team1url\": \"http://match.sports.sina.com.cn/football/team.php?id=157\",\"team2\": \"阿尔梅里亚\",\"team2icon\": \"http://www.sinaimg.cn/ty/2013/0813/U5244P6DT20130813113821.png\",\"team2url\": \"http://match.sports.sina.com.cn/football/team.php?id=4418\",\"time\": \"23:00\"}]},\"error_code\": 0}";























}