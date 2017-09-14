package com.cicada.job.Ball;

import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.cicada.commons.utils.*;
import com.cicada.enums.MatchesPlayTypeEnum;
import com.cicada.enums.MatchesStatusEnum;
import com.cicada.enums.MatchesTypeEnum;
import com.cicada.enums.TaskTypeEnum;
import com.cicada.pojo.MatchesEntity;
import com.cicada.pojo.PlayOddsEntity;
import com.cicada.pojo.TeamEntity;
import com.cicada.pojo.vo.MatchesVo;
import com.cicada.service.impl.MatchesServiceImpl;
import com.cicada.service.impl.PlayOddsServiceImpl;
import com.cicada.service.impl.TeamServiceImpl;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.data.redis.core.RedisTemplate;
import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;

import java.io.*;
import java.sql.Timestamp;
import java.util.*;

/**
 * 球类赛事的通用util
 */
public class BallUtil {

    private static final long serialVersionUID = -1L;

    private  static String   basketball_rediskey="ball_matches:basketball";//篮球球赛redistribution缓存的key
    private static int basetBall_settletime=120;//篮球比赛结束时间定时（分）

    private  static String  football_rediskey="ball_matches:football";//足球球赛redistribution缓存的key
    private static int footBall_settletime=120;//足球比赛结束时间定时（分

    private static int open_beforlocktime=-15;//比赛开始之前多少分钟锁定

    private static String imgBeforStr=SystemConfig.getInstance().getURL_BASE_IMG()+"/team/";//图片前缀地址


    private static final Logger LOTTERY_LOGGER = LogManager.getLogger("ball");

    /**
     * 新增赛事
     * @param home_team_name
     * @param home_team_logo
     * @param away_team_name
     * @param away_team_logo
     * @param day_week
     * @param day_date
     * @param day_time
     * @param title
     * @param balltype
     * @param home_score
     * @param away_score
     */
    public static void SaveMatch(String home_team_name,String home_team_logo,String  away_team_name,String away_team_logo,String day_week,String day_date,String day_time,String title,String balltype,String home_score,String away_score){
        String open_time= DateFormatUtil.getYear().trim()+"-"+day_date.trim()+" "+day_time.trim()+":00";
//        System.out.println("open_time="+open_time+"*****"+home_team_name);
        int home_team_id=0;
        int away_team_id=0;
         //判断是否有主队球队信息
        TeamEntity teamEntity=new TeamEntity();
        teamEntity.setTeamName(home_team_name);
        EntityWrapper<TeamEntity> wrapper = new EntityWrapper<TeamEntity>(teamEntity);
        List<TeamEntity> selectList =  ((TeamServiceImpl) SpringContextUtil.getBean("teamServiceImpl")).selectList(wrapper);
        if(selectList.size() == 0){
            teamEntity.setTeamLogo(home_team_logo);
            ((TeamServiceImpl)SpringContextUtil.getBean("teamServiceImpl")).insert(teamEntity);
            home_team_id=teamEntity.getTeamId();
        }else{
            home_team_id=selectList.get(0).getTeamId();
        }
         //判断是否有客队球队信息
        teamEntity=new TeamEntity();
        teamEntity.setTeamName(away_team_name);
        EntityWrapper<TeamEntity> wrapper2 = new EntityWrapper<TeamEntity>(teamEntity);
        List<TeamEntity>   selectList2 =  ((TeamServiceImpl)SpringContextUtil.getBean("teamServiceImpl")).selectList(wrapper2);
        if(selectList2.size() == 0){
            teamEntity.setTeamLogo(away_team_logo);
            ((TeamServiceImpl)SpringContextUtil.getBean("teamServiceImpl")).insert(teamEntity);
            away_team_id=teamEntity.getTeamId();
        }else{
            away_team_id=selectList2.get(0).getTeamId();
        }
        //判断当前球队是否已经加入
        MatchesEntity matchesEntity=new MatchesEntity();
        matchesEntity.setHomeTeamId(home_team_id);
        if(!home_score.equals("")){
            matchesEntity.setHomeScore(Integer.parseInt(home_score));
        }
         matchesEntity.setAwayTeamId(away_team_id);
        if(!away_score.equals("")){
            matchesEntity.setAwayScore(Integer.parseInt(away_score));
        }
        matchesEntity.setDayDate(day_date);
        matchesEntity.setDayTime(day_time);
        EntityWrapper<MatchesEntity> wrapper3 = new EntityWrapper<MatchesEntity>(matchesEntity);
        List<MatchesEntity>  selectList3 =  ((MatchesServiceImpl)SpringContextUtil.getBean("matchesServiceImpl")).selectList(wrapper3);
        if(selectList3.size() != 0){
            return;
        }
        matchesEntity.setTitle(title);
        matchesEntity.setMatchesStatusEnum(MatchesStatusEnum.NotStarted);
        if(balltype.equals(String.valueOf(MatchesTypeEnum.Basketball.getCode()))){
            matchesEntity.setMatchesTypeEnum(MatchesTypeEnum.Basketball);
        }else{
            matchesEntity.setMatchesTypeEnum(MatchesTypeEnum.Football);
        }
        matchesEntity.setDayWeek(day_week);
        matchesEntity.setOpenTime(Timestamp.valueOf(open_time));
        //设置---锁定时间
        String lock_time= DateUtil.getAfterMinuteDate(open_time,open_beforlocktime);
        matchesEntity.setLockTime(Timestamp.valueOf(lock_time));
        //设置---结束时间
        String settleTime=DateUtil.getAfterMinuteDate(open_time,footBall_settletime);//足球
        if(balltype.equals(String.valueOf(MatchesTypeEnum.Basketball.getCode()))){//篮球
            settleTime=DateUtil.getAfterMinuteDate(open_time,basetBall_settletime);
        }
        matchesEntity.setSettleTime(Timestamp.valueOf(settleTime));
        matchesEntity.setUpdateTime(new Timestamp(System.currentTimeMillis()));
        ((MatchesServiceImpl)SpringContextUtil.getBean("matchesServiceImpl")).insert(matchesEntity);
        //根据球赛开始结束时间定时操作
        TimerBall(  open_time,  settleTime, matchesEntity.getMatchId());
     }


    /**
     * redis开赛定时器
     */
    public static void TimerBall(String open_time,String settleTime,Long matchId){
        //设置定时器----修改开始时间
        long opentime= DateUtil.fomatDate1(open_time).getTime();
        long nowtime=new Date().getTime();
        long open_n=opentime-nowtime;
        if(open_n < 0){
            open_n=60;
        }
        JedisPool jedisPool = (JedisPool)SpringContextUtil.getBean("jedisPool");
        String strkey = ConstantInterface.REDIS_BALLKEY_LOTTERY_PREFIX +matchId;
        Jedis jedis = jedisPool.getResource();
        if(jedis.exists(strkey.getBytes())){
            jedis.del(strkey.getBytes());
        }
        jedisPool.getResource().setex(strkey, (int) open_n, String.format("待开赛任务 %s", matchId));
        LOTTERY_LOGGER.info(String.format("竞猜项目【%s】 成功加入倒计时开赛队列，过期时间%s秒",matchId,open_n));
     }


    /**
     * 修改开赛时间锁定时间
     * @param matchId
     */
     public static void updateMatchTime(long matchId){
         try{
             MatchesEntity matchesEntity = ((MatchesServiceImpl) SpringContextUtil.getBean("matchesServiceImpl")).selectById(matchId);
             if (matchesEntity.getMatchesStatusEnum().getCode() == MatchesStatusEnum.NotStarted.getCode()) {
                 //未开赛进来
                 matchesEntity.setMatchesStatusEnum(MatchesStatusEnum.Underway);
                 ((MatchesServiceImpl) SpringContextUtil.getBean("matchesServiceImpl")).updateById(matchesEntity);
                 //结束监听事件---发布成功提交REDIS，倒计时开奖
                 long settletime = matchesEntity.getSettleTime().getTime();
                 long nowtime = new Date().getTime();
                 long expire = (settletime - nowtime) / 1000;
                 //long expire=60;
                 if (expire < 0) {
                     expire = 60;
                 }
                 JedisPool jedisPool = (JedisPool) SpringContextUtil.getBean("jedisPool");
                 String strkey = ConstantInterface.REDIS_BALLKEY_LOTTERY_PREFIX + matchId;
                 Jedis jedis = jedisPool.getResource();
                 if (jedis.exists(strkey.getBytes())) {
                     jedis.del(strkey.getBytes());
                 }
                 jedisPool.getResource().setex(strkey, (int) expire, String.format("待开奖任务 %s", matchId));
                 LOTTERY_LOGGER.info(String.format("竞猜项目【%s】 成功加入倒计时开奖队列，过期时间%s秒", matchId, expire));
             } else if (matchesEntity.getMatchesStatusEnum().getCode() == MatchesStatusEnum.Underway.getCode()) {
                 //已开赛进来
                 BallUtil.MatchBallIsOk(matchId);
             }else{
                 //已结束不做操作

             }
         }catch (Exception e){
             e.printStackTrace();
         }
     }













    /**
     * 更新redis中的球赛----缓存
     * @param matchType 1-篮球，2-足球
     */
     public static  void changeRedisBallList(String matchType){
        try{
            //发布成功提交redis缓存
            List<MatchesVo> matchesVoList=new ArrayList<MatchesVo>();
            MatchesEntity matchesEntity=new MatchesEntity();
            matchesEntity.setMatchesStatusEnum(MatchesStatusEnum.NotStarted);
            String strkey="";
            if(matchType.equals(String.valueOf(MatchesTypeEnum.Basketball.getCode()))){
                matchesEntity.setMatchesTypeEnum(MatchesTypeEnum.Basketball);
                strkey=basketball_rediskey;
            }else{
                matchesEntity.setMatchesTypeEnum(MatchesTypeEnum.Football);
                strkey=football_rediskey;
            }
            EntityWrapper<MatchesEntity> wrapper = new EntityWrapper<MatchesEntity>(matchesEntity);
            List<MatchesEntity>  selectList3 =  ((MatchesServiceImpl)SpringContextUtil.getBean("matchesServiceImpl")).selectList(wrapper);
            //默认时间升序，添加.reversed()倒叙
            Collections.sort(selectList3,Comparator.comparing(MatchesEntity::getOpenTime));

            MatchesVo matchesVo;
            TeamEntity teamEntity;
            for (MatchesEntity matchesEntity1 : selectList3) {
                matchesVo=new MatchesVo();
                //判断是最近几天
                String open_time=matchesEntity1.getOpenTime().toString();
                String lock_time=matchesEntity1.getLockTime().toString();
                String settleTime=matchesEntity1.getSettleTime().toString();
                String now_time=DateUtil.getTime();
                long lockn=DateUtil.fomatDate2(lock_time).getTime();
                long nown=DateUtil.fomatDate2(now_time).getTime();
                long chajian=lockn-nown;
                if(chajian <= 0){
                    continue;
                }
                long cha_number=DateUtil.getDaySub(now_time,open_time);
                String dayName="";
                if(cha_number > 7 ){
                    continue;
                }else if(cha_number == 0){
                    dayName="今天";
                }else if(cha_number == 1){
                    dayName="明天";
                }else{
                    dayName="";
                 }
                matchesVo.setDayName(dayName);
                matchesVo.setMatchId(matchesEntity1.getMatchId());
                matchesVo.setTitle(matchesEntity1.getTitle());
                matchesVo.setDayDate(matchesEntity1.getDayDate());
                matchesVo.setDayWeek(matchesEntity1.getDayWeek());
                matchesVo.setDayTime(matchesEntity1.getDayTime());
                matchesVo.setLockTime(matchesEntity1.getLockTime().toString().substring(0,matchesEntity1.getLockTime().toString().length()-2));
                matchesVo.setOpenTime(matchesEntity1.getOpenTime().toString().substring(0,matchesEntity1.getLockTime().toString().length()-2));
                matchesVo.setSettleTime(matchesEntity1.getSettleTime().toString().substring(0,matchesEntity1.getSettleTime().toString().length()-2));
                matchesVo.setStatus(matchesEntity1.getMatchesStatusEnum().getCode());
                int matchtype=matchesEntity1.getMatchesTypeEnum().getCode();//球赛类型
                if(matchtype == MatchesTypeEnum.Basketball.getCode()){
                    matchesVo.setTaskType(TaskTypeEnum.NBA.getCode());
                }else if(matchtype == MatchesTypeEnum.Football.getCode()){
                    matchesVo.setTaskType(TaskTypeEnum.FOOTBALL.getCode());
                }else{
                    //
                }
                matchesVo.setMatchType(matchtype);
                teamEntity=((TeamServiceImpl)SpringContextUtil.getBean("teamServiceImpl")).selectById(matchesEntity1.getHomeTeamId());
                if(teamEntity == null){
                    continue;
                }else{
                    matchesVo.setHomeTeamId(teamEntity.getTeamId());
                    matchesVo.setHomeTeamLogo(imgBeforStr+teamEntity.getTeamLogo());
                    matchesVo.setHomeTeamName(teamEntity.getTeamName());
                }
                teamEntity=((TeamServiceImpl)SpringContextUtil.getBean("teamServiceImpl")).selectById(matchesEntity1.getAwayTeamId());
                if(teamEntity == null){
                    continue;
                }else{
                    matchesVo.setAwayTeamId(teamEntity.getTeamId());
                    matchesVo.setAwayTeamLogo(imgBeforStr+teamEntity.getTeamLogo());
                    matchesVo.setAwayTeamName(teamEntity.getTeamName());
                }
                //获取赔率
                PlayOddsEntity playOddsEntity=new PlayOddsEntity();
                playOddsEntity.setMatchId(matchesEntity1.getMatchId());
                EntityWrapper<PlayOddsEntity> wrapper4 = new EntityWrapper<PlayOddsEntity>(playOddsEntity);
                List<PlayOddsEntity>  selectList4 =  ((PlayOddsServiceImpl)SpringContextUtil.getBean("playOddsServiceImpl")).selectList(wrapper4);
                if(selectList4.size() == 0){
                    playOddsEntity.setMatchId(Long.parseLong("0"));
                    wrapper4 = new EntityWrapper<PlayOddsEntity>(playOddsEntity);
                    selectList4 =  ((PlayOddsServiceImpl)SpringContextUtil.getBean("playOddsServiceImpl")).selectList(wrapper4);
                };
                //1.标准盘 2.大小球 3.让球
                List<PlayOddsEntity>  standardPlate=new ArrayList<PlayOddsEntity>();
                List<PlayOddsEntity>  ballSize=new ArrayList<PlayOddsEntity>();
                List<PlayOddsEntity>  letTheBall=new ArrayList<PlayOddsEntity>();
                PlayOddsEntity poentity=null;
                for (int i = 0; i < selectList4.size() ; i++) {
                    poentity=selectList4.get(i);
                    int play_id=poentity.getMatchesPlayTypeEnum().getCode();
                    if(play_id== MatchesPlayTypeEnum.LetTheBall.getCode()){
                        letTheBall.add(poentity);
                    }else if(play_id == MatchesPlayTypeEnum.BallSize.getCode()){
                        ballSize.add(poentity);
                    }else{
                        standardPlate.add(poentity);
                    }
                    poentity=null;
                }
                matchesVo.setStandardPlate(standardPlate);
                matchesVo.setBallSize(ballSize);
                matchesVo.setLetTheBall(letTheBall);
                 //=============================================
                matchesVoList.add(matchesVo);
                //根据球赛开始结束时间定时操作
                TimerBall(open_time,  settleTime, matchesEntity.getMatchId());
            }
            //开始存储
            JedisPool jedisPool = (JedisPool)SpringContextUtil.getBean("jedisPool");
            Jedis jedis = jedisPool.getResource();
            if(jedis.exists(strkey)){
                 jedis.del(strkey);
            }
            //循环比赛---缓存到rpush-分页
            MatchesVo matchesVo1=null;
            for (int i = 0; i < matchesVoList.size(); i++) {
                matchesVo1=matchesVoList.get(i);
                //锁定时间不加入缓存
                String lock_time=matchesVo1.getLockTime().toString();
                String now_time=DateUtil.getTime();
                long lockn=DateUtil.fomatDate2(lock_time).getTime();
                long nown=DateUtil.fomatDate2(now_time).getTime();
                long chajian=lockn-nown;
                if(chajian <= 0){
                    continue;
                }
//                System.out.println("matchjsonStr="+matchesVo1.toString());
                String matchjsonStr=JSONObject.fromObject(matchesVo1).toString();
                jedis.rpush( strkey , matchjsonStr );
            }
//            //展示数据s
//            List<String> results = jedis.lrange( strkey, 0, 10);// 从start算起，start算一个元素，到结束那个元素
//            JSONObject jsonObject=null;
//            for  (String str1 : results) {
//                 System.out.println("分页出来数据：str1="+str1);
//                 jsonObject=JSONObject.fromObject(str1);
//                 System.out.println("分页出来数据：jsonObject="+jsonObject.toString());
//            }
//
//            //不分页
//            String matchjsonStr=JSONArray.fromObject(matchesVoList).toString();
//            System.out.println(matchjsonStr);
//            jedis.set(strkey,matchjsonStr);
             //验证
            //转json
//            String backjson=jedis.get(strkey);
//            JSONArray jsonArray= JSONArray.fromObject(backjson) ;
//            for (int i = 0; i <jsonArray.size() ; i++) {
//                    JSONObject jsonObject=jsonArray.getJSONObject(i);
//                    System.out.println("homeScore="+jsonObject.getString("homeScore"));
//                    JSONArray jsonArray1=jsonObject.getJSONArray("letTheBall");
//                    for (int j = 0; j <jsonArray1.size() ; j++) {
//                        JSONObject jsonObject2=jsonArray1.getJSONObject(i);
//                        System.out.println("jsonObject2="+jsonObject2.toString());
//                    }
//            }
            //转实体类
//            ObjectMapper mapper = new ObjectMapper();
//            List<MatchesVo> list = mapper.readValue(backjson, new TypeReference<List<MatchesVo>>() {});
//            for(MatchesVo matchesVo1 : list){
//                 List<PlayOddsEntity> lists=matchesVo1.getStandardPlate();
//                for (PlayOddsEntity ss: lists) {
//                    System.out.println(ss.toString());
//                }
//            }
        }catch (Exception e){
            e.printStackTrace();
        }
      }


    /**
     * 球赛ID--定时操作判断当前球赛是否已经结束
     * @param matchId
     */
     public static  void MatchBallIsOk(long matchId){
         MatchesEntity matchesEntity= ((MatchesServiceImpl)SpringContextUtil.getBean("matchesServiceImpl")).selectById(matchId);
         int matchType=matchesEntity.getMatchesTypeEnum().getCode();
         int home_team_id=matchesEntity.getHomeTeamId();
         int away_team_id=matchesEntity.getAwayTeamId();
         String home_team_name=((TeamServiceImpl)SpringContextUtil.getBean("teamServiceImpl")).selectById(home_team_id).getTeamName();
         String away_team_name=((TeamServiceImpl)SpringContextUtil.getBean("teamServiceImpl")).selectById(away_team_id).getTeamName();
         String day_date=matchesEntity.getDayDate();
         String day_time=matchesEntity.getDayTime();
         boolean flag=false;
         if(matchType == MatchesTypeEnum.Basketball.getCode()){
             flag=BasketballMatchUtil.flagIsOver(  matchId,  home_team_name,  away_team_name,  day_date,  day_time);
         }else{
             flag=FootBallMatchUtil.flagIsOver(  matchId,  home_team_name,  away_team_name,  day_date,  day_time);
         }
         //flag：true表示比赛结束，false表示未结束，扔回倒计时
        if(!flag){
            JedisPool jedisPool = (JedisPool)SpringContextUtil.getBean("jedisPool");
            String key = ConstantInterface.REDIS_BALLKEY_LOTTERY_PREFIX + String.valueOf(matchId);
            int expire=300;
            jedisPool.getResource().setex(key, (int) expire, String.format("待开奖任务 %s", matchId));
            LOTTERY_LOGGER.info(String.format("竞猜项目【%s】 成功加入倒计时开奖队列，过期时间%s秒", matchId,expire));
        }
     }





    /**
     *
     * 处理赛事结果
     * @param matchId
     */
    public static void ProcessingMatch(String matchId){
        //查看当前赛事详情

        //判断当前赛事是篮球还是足球-分别调用不同的util


        //返回结果true则表示赛事结束，否则表示还未开始或者正在进行



    }


    public static void main(String[] str){

    }



}
