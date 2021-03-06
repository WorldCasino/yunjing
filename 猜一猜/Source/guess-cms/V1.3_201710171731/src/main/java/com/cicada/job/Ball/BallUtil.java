package com.cicada.job.Ball;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.cicada.commons.Exception.ApiException;
import com.cicada.commons.utils.*;
import com.cicada.enums.*;
import com.cicada.pojo.MatchesEntity;
import com.cicada.pojo.PlayOddsEntity;
import com.cicada.pojo.TeamEntity;
import com.cicada.pojo.vo.MatchesVo;
import com.cicada.redis.RedisHelper;
import com.cicada.service.IMatchesService;
import com.cicada.service.IPlayOddsService;
import com.cicada.service.ITeamService;
import com.cicada.service.impl.MatchesServiceImpl;
import com.cicada.service.impl.PlayOddsServiceImpl;
import com.cicada.service.impl.TeamServiceImpl;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import redis.clients.jedis.Jedis;

import java.sql.Timestamp;
import java.text.NumberFormat;
import java.util.*;

/**
 * 球类赛事的通用util
 */
public class BallUtil {

    @Autowired
    private IPlayOddsService iPlayOddsService;

    private static final long serialVersionUID = -1L;

    private  static String   basketball_rediskey="ball_matches:basketball";//篮球球赛redistribution缓存的key
    private static int basketBall_settletime=150;//篮球比赛结束时间定时（分）

    private  static String  football_rediskey="ball_matches:football";//足球球赛redistribution缓存的key
    private static int footBall_settletime=120;//足球比赛结束时间定时（分

    private static int open_beforlocktime=-15;//比赛开始之前多少分钟锁定


    private static int search_time=15;//（分）没过几分钟查询一下比赛结果
    private static int overnot_searchtime=90;//(分)比赛结束后的多少时间就不查询结果；


    private static final Logger LOTTERY_LOGGER = LogManager.getLogger("ball");



    /**
     * 新增赛事
     * @param home_team_name
     * @param away_team_name
     * @param title
     * @param balltype
     */
    public synchronized static void SaveMatch(String home_team_name,String  away_team_name,String open_time,String title,String balltype,String gl_match_id){
        RedisTemplate<String, Object> redisTemplate = (RedisTemplate<String, Object>) SpringContextUtil.getBean("redisTemplate");
        String md5str=MD5Util.getMD5Str(home_team_name+away_team_name+open_time);
        RedisLockUtil redisLock = new RedisLockUtil(redisTemplate, "BALL_LOCK:ADD_"+md5str, 10000, 20000);
        try{
            //当前比赛是否正在添加
            if (redisLock.lock()) {
                String day_week=StringUtils.getWeekOfDate(DateUtil.fomatDate1(open_time));
                String day_date=DateUtil.formatDateChange3(open_time);
                String day_time=DateUtil.formatDateChange2(open_time);

                int home_team_id=0;
                int away_team_id=0;
                //判断是否有主队球队信息
                EntityWrapper ew = new EntityWrapper();
                ew.where("team_name = {0}",home_team_name);
                List<TeamEntity> selectList =  ((TeamServiceImpl) SpringContextUtil.getBean("teamServiceImpl")).selectList(ew);
                if(selectList.size() == 0){
                    TeamEntity teamEntity=new TeamEntity();
                    teamEntity.setTeamName(home_team_name);
                    ((ITeamService)SpringContextUtil.getBean("teamServiceImpl")).insert(teamEntity);
                    home_team_id=teamEntity.getTeamId();
                }else{
                    home_team_id=selectList.get(0).getTeamId();
                }
                //判断是否有客队球队信息
                ew = new EntityWrapper();
                ew.where("team_name = {0}",away_team_name);
                List<TeamEntity>   selectList2 =  ((ITeamService)SpringContextUtil.getBean("teamServiceImpl")).selectList(ew);
                if(selectList2.size() == 0){
                    TeamEntity teamEntity=new TeamEntity();
                    teamEntity.setTeamName(away_team_name);
                    ((ITeamService)SpringContextUtil.getBean("teamServiceImpl")).insert(teamEntity);
                    away_team_id=teamEntity.getTeamId();
                }else{
                    away_team_id=selectList2.get(0).getTeamId();
                }
                MatchesEntity matchesEntity=new MatchesEntity();
                if(!gl_match_id.equals("")){
                    matchesEntity.setGlMatchId(Long.parseLong(gl_match_id));
                }
                if(balltype.equals(String.valueOf(MatchesTypeEnum.Basketball.getCode()))){
                    matchesEntity.setMatchesTypeEnum(MatchesTypeEnum.Basketball);
                }else{
                    matchesEntity.setMatchesTypeEnum(MatchesTypeEnum.Football);
                }
                matchesEntity.setHomeTeamId(home_team_id);
                matchesEntity.setAwayTeamId(away_team_id);
                matchesEntity.setDayDate(day_date);
                matchesEntity.setDayTime(day_time);
                matchesEntity.setTitle(title);
                matchesEntity.setMatchesStatusEnum(MatchesStatusEnum.NotStarted);
                matchesEntity.setDayWeek(day_week);
                matchesEntity.setOpenTime(Timestamp.valueOf(open_time));
                //设置---锁定时间
                String lock_time= DateUtil.getAfterMinuteDate(open_time,open_beforlocktime);
                matchesEntity.setLockTime(Timestamp.valueOf(lock_time));
                //设置---结束时间
                String settleTime=DateUtil.getAfterMinuteDate(open_time,footBall_settletime);//足球
                if(balltype.equals(String.valueOf(MatchesTypeEnum.Basketball.getCode()))){//篮球
                    settleTime=DateUtil.getAfterMinuteDate(open_time,basketBall_settletime);
                }
                matchesEntity.setSettleTime(Timestamp.valueOf(settleTime));
                matchesEntity.setUpdateTime(new Timestamp(System.currentTimeMillis()));
                //判断当前球队是否已经加入
                ew = new EntityWrapper();
                ew.where("home_team_id = {0}",home_team_id)
                        .andNew("away_team_id = {0} ",away_team_id)
                        .andNew("day_date  = {0}",day_date)
                        .andNew("day_time  = {0}",day_time);
                if(((IMatchesService)SpringContextUtil.getBean("matchesServiceImpl")).selectList(ew).size() == 0){
                    ((IMatchesService)SpringContextUtil.getBean("matchesServiceImpl")).insert(matchesEntity);
                    TimerBall(  open_time, matchesEntity.getMatchId()); //根据球赛开始结束时间定时操作
                }

            }
        }catch (Exception e){
            e.printStackTrace();
            LOTTERY_LOGGER.error("新增球赛赛事失败",e);
        }finally {
            redisLock.unlock();
        }

     }


    /**
     * redis开赛定时器
     */
    public static void TimerBall(String open_time,Long matchId){
        Jedis jedis = null;
        try{
            //设置定时器----修改开始时间
            long opentime= DateUtil.fomatDate1(open_time).getTime();
            long nowtime=new Date().getTime();
            long open_n=(opentime-nowtime)/1000;
            if(open_n < 0){
                open_n=5;
            }
            String strkey = ConstantInterface.REDIS_BALLKEY_LOTTERY_PREFIX +matchId;
            jedis = RedisHelper.getJedis();
            if(jedis.exists(strkey)){
                jedis.del(strkey);
            }
            jedis.setex(strkey,(int) open_n,String.format("待开赛任务 %s", matchId));

            LOTTERY_LOGGER.info(String.format("竞猜项目【%s】 成功加入倒计时开赛队列，过期时间%s秒",matchId,open_n));
        }catch (Exception e){
            e.printStackTrace();
            RedisHelper.returnBrokenResource(jedis);
            LOTTERY_LOGGER.error("开赛时间【"+matchId+"】定时失败",e);
        }finally {
            RedisHelper.returnResource(jedis);
        }

     }


    /**
     * 修改开赛时间锁定时间
     * @param matchId
     */
     public static void updateMatchTime(long matchId){
         Jedis jedis = null;
         try{
             MatchesEntity matchesEntity = ((IMatchesService) SpringContextUtil.getBean("matchesServiceImpl")).selectById(matchId);
             if (matchesEntity.getMatchesStatusEnum().getCode() == MatchesStatusEnum.NotStarted.getCode()) {
                 //未开赛进来
                 matchesEntity.setMatchesStatusEnum(MatchesStatusEnum.Underway);
                 ((MatchesServiceImpl) SpringContextUtil.getBean("matchesServiceImpl")).updateById(matchesEntity);
                 //结束监听事件---发布成功提交REDIS，倒计时开奖
                 long settletime = matchesEntity.getSettleTime().getTime();
                 long nowtime = new Date().getTime();
                 long expire = (settletime - nowtime) / 1000 ;
                 if (expire <= 0) {
                     expire = 5;
                 }
                 String strkey = ConstantInterface.REDIS_BALLKEY_LOTTERY_PREFIX + matchId;
                 jedis = RedisHelper.getJedis();
                 if(jedis.exists(strkey)){
                     jedis.del(strkey);
                 }
                 jedis.setex(strkey,(int)expire,String.format("待开奖任务 %s", matchId));

                 LOTTERY_LOGGER.info(String.format("竞猜项目【%s】 成功加入倒计时开奖队列，过期时间%s秒", matchId, expire));
             } else if (matchesEntity.getMatchesStatusEnum().getCode() == MatchesStatusEnum.Underway.getCode()) {
                 //已开赛进来
                 BallUtil.MatchBallIsOk(matchId);
             }else{
                 //已结束不做操作
                 LOTTERY_LOGGER.info(matchesEntity.getMatchesTypeEnum().getDesc()+"已结束开奖【"+matchId+"】比较结束");
             }
         }catch (Exception e){
             e.printStackTrace();
             RedisHelper.returnBrokenResource(jedis);
             LOTTERY_LOGGER.error("开赛锁定时间更改【"+matchId+"】出错",e);
         }finally {
             RedisHelper.returnResource(jedis);
         }
     }



    /**
     * 球赛ID--定时操作判断当前球赛是否已经结束
     * @param matchId
     */
    public synchronized static  void MatchBallIsOk(long matchId){
        LOTTERY_LOGGER.info("赛程【"+matchId+"】结束，获取比赛结果"+DateUtil.getTime());
        int time=search_time;//以分钟结束
        Jedis jedis = null;
        try {
            MatchesEntity matchesEntity= ((IMatchesService)SpringContextUtil.getBean("matchesServiceImpl")).selectById(matchId);
            int matchType=matchesEntity.getMatchesTypeEnum().getCode();
            String home_team_name=((ITeamService)SpringContextUtil.getBean("teamServiceImpl")).selectById(matchesEntity.getHomeTeamId()).getTeamName();
            String away_team_name=((ITeamService)SpringContextUtil.getBean("teamServiceImpl")).selectById(matchesEntity.getAwayTeamId()).getTeamName();
            boolean flag=false;
            long jhminute=DateUtil.getDayMinute(matchesEntity.getSettleTime().toString(),DateUtil.getTime());//现在的时间-结束时间
            if(jhminute >= overnot_searchtime){
                if(matchesEntity.getMatchesTypeEnum().getCode() == MatchesTypeEnum.Basketball.getCode()){
                    time=360;
                }
                LOTTERY_LOGGER.info(matchesEntity.getMatchesTypeEnum().getDesc()+"竞猜项目【"+matchId+"】未开奖，现在差距时间【"+jhminute+"】，超时【"+time+"】分钟====="+DateUtil.getTime());
            }
            if(matchType == MatchesTypeEnum.Basketball.getCode()){
                if(matchesEntity.getGlMatchId() == null){
                    matchesEntity.setGlMatchId(0L);
                }
                flag=BasketballMatchUtil.flagIsOver(  matchId,  home_team_name,  away_team_name,  matchesEntity.getDayDate(),  matchesEntity.getDayTime(),matchesEntity.getGlMatchId());
            }else{
                flag=FootBallMatchUtil.flagIsOver(matchId,home_team_name,away_team_name,matchesEntity.getDayDate(),matchesEntity.getDayTime() , matchesEntity.getTitle());
            }
            //flag：true表示比赛结束，false表示未结束，扔回倒计时
            if(!flag){
                  String key = ConstantInterface.REDIS_BALLKEY_LOTTERY_PREFIX + String.valueOf(matchId);
                  int expire=time*60;//15分钟
                  jedis = RedisHelper.getJedis();

                  jedis.setex(key, expire, String.format(matchesEntity.getMatchesTypeEnum().getDesc()+"待开奖任务 %s", matchId));

                  LOTTERY_LOGGER.info(String.format(matchesEntity.getMatchesTypeEnum().getDesc()+"竞猜项目【%s】 成功加入倒计时开奖队列，过期时间%s秒", matchId,expire));
              }else{
                  LOTTERY_LOGGER.info(matchesEntity.getMatchesTypeEnum().getDesc()+"竞猜项目【"+matchId+"】已成功开奖");
              }
         }catch (Exception e){
            e.printStackTrace();
            RedisHelper.returnBrokenResource(jedis);
            LOTTERY_LOGGER.error("判断球赛结果出错【"+matchId+"】",e);
        }finally {
            RedisHelper.returnResource(jedis);
        }

    }


    /**
     * 更新redis中的球赛----缓存
     * @param matchType 1-篮球，2-足球
     */
     public synchronized static  void changeRedisBallList(String matchType){
         Jedis jedis = null;
         try{
             //发布成功提交redis缓存
             List<MatchesVo> matchesVoList=new ArrayList<MatchesVo>();
             MatchesEntity matchesEntity=new MatchesEntity();
             matchesEntity.setMatchesStatusEnum(MatchesStatusEnum.NotStarted);
             String strkey=football_rediskey;
             if(matchType.equals(String.valueOf(MatchesTypeEnum.Basketball.getCode()))){
                 matchesEntity.setMatchesTypeEnum(MatchesTypeEnum.Basketball);
                 strkey=basketball_rediskey;
             }else{
                 matchesEntity.setMatchesTypeEnum(MatchesTypeEnum.Football);
                 strkey=football_rediskey;
             }
             EntityWrapper<MatchesEntity> wrapper = new EntityWrapper<MatchesEntity>(matchesEntity);
             List<MatchesEntity>  selectList3 =  ((IMatchesService)SpringContextUtil.getBean("matchesServiceImpl")).selectList(wrapper);
             //默认时间升序，添加.reversed()倒叙
             Comparator<MatchesEntity> comparator = (h1, h2) -> String.valueOf(h1.getOpenTime().getTime()).compareTo(String.valueOf(h2.getOpenTime().getTime()));
             selectList3.sort(comparator);
             MatchesVo matchesVo;
             TeamEntity teamEntity;
             for (MatchesEntity matchesEntity1 : selectList3) {
                 matchesVo=new MatchesVo();
                 //判断是最近几天
                 String open_time=matchesEntity1.getOpenTime().toString();
                 String lock_time=matchesEntity1.getLockTime().toString();
                 String now_time=DateUtil.getTime();
                 //设置---锁定时间
                 long lockn=DateUtil.fomatDate2(lock_time).getTime();
                 long nown=DateUtil.fomatDate2(now_time).getTime();
                 long chajian=lockn-nown;
                 if(chajian <= 0){
                     //时间已过期，但是未得到结果的比赛进行缓存
                     TimerBall(open_time,  matchesEntity1.getMatchId());
                     continue;
                 }
                 long cha_number=DateUtil.getDaySub(now_time,open_time);
                 String dayName="";
                 if(cha_number > 7 ){
                     continue;//测试先注释
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
                 teamEntity=((ITeamService)SpringContextUtil.getBean("teamServiceImpl")).selectById(matchesEntity1.getHomeTeamId());
                 if(teamEntity == null){
                     continue;
                 }else{
                     matchesVo.setHomeTeamId(teamEntity.getTeamId());
                     if(teamEntity.getTeamLogo() != null && teamEntity.getTeamLogo().contains("http")){
                         matchesVo.setHomeTeamLogo(teamEntity.getTeamLogo());
                     }else{
                         matchesVo.setHomeTeamLogo(SystemConfig.getInstance().getBALL_MATCH_LOGO()+teamEntity.getTeamLogo());
                     }
                     matchesVo.setHomeTeamName(teamEntity.getTeamName());
                 }
                 teamEntity=((ITeamService)SpringContextUtil.getBean("teamServiceImpl")).selectById(matchesEntity1.getAwayTeamId());
                 if(teamEntity == null){
                     continue;
                 }else{
                     matchesVo.setAwayTeamId(teamEntity.getTeamId());
                     if(teamEntity.getTeamLogo() != null && teamEntity.getTeamLogo().contains("http")){
                         matchesVo.setAwayTeamLogo(teamEntity.getTeamLogo());
                     }else{
                         matchesVo.setAwayTeamLogo(SystemConfig.getInstance().getBALL_MATCH_LOGO()+teamEntity.getTeamLogo());
                     }
                     matchesVo.setAwayTeamName(teamEntity.getTeamName());
                 }
                 //标准盘
                 long matchId=matchesEntity1.getMatchId();
                 List<PlayOddsEntity>  standardPlate =getList(1, (int) matchId);
                 List<PlayOddsEntity>  letTheBall =  getList(2, (int) matchId);
                 List<PlayOddsEntity>  ballSize =  getList(3, (int) matchId);

                 matchesVo.setStandardPlate(standardPlate);
                 matchesVo.setBallSize(ballSize);
                 matchesVo.setLetTheBall(letTheBall);
                 //=============================================
                 matchesVoList.add(matchesVo);
             }
             RedisTemplate<String, Object> redisTemplate = (RedisTemplate<String, Object>) SpringContextUtil.getBean("redisTemplate");
             RedisLockUtil redisLock = new RedisLockUtil(redisTemplate, "BALL_LOCK:UPDATE_"+strkey+matchType, 10000, 20000);
             try {
                 if (redisLock.lock()) {
                    //获取jedis
                     jedis = RedisHelper.getJedis();
                     //记录每一天的
                     String timekey=strkey+DateFormatUtil.getYYYY_MM_DD();
                     if(!jedis.exists(timekey)){
                         String dayRedis = ((JacksonSerializer)SpringContextUtil.getBean("jacksonSerializer")).toJson(matchesVoList);
                         jedis.set( timekey , dayRedis );
                     }
                     if(jedis.exists(strkey)){
                         jedis.del( strkey );
                     }
                     //循环比赛---缓存到rpush-分页
                     MatchesVo matchesVo1=null;
                     for (int i = 0; i < matchesVoList.size(); i++) {
                         matchesVo1=matchesVoList.get(i);
                         //锁定时间不加入缓存
                         String open_time=matchesVo1.getOpenTime().toString();
                         String lock_time=matchesVo1.getLockTime().toString();
                         String now_time=DateUtil.getTime();
                         long lockn=DateUtil.fomatDate2(lock_time).getTime();
                         long nown=DateUtil.fomatDate2(now_time).getTime();
                         long chajian=lockn-nown;
                         if(chajian <= 0){
                             continue;
                         }
                         String matchjsonStr = ((JacksonSerializer)SpringContextUtil.getBean("jacksonSerializer")).toJson(matchesVo1);
                         //开始存储
                         jedis.rpush( strkey , matchjsonStr );
//                 添加缓存成功之后----根据球赛开始结束时间定时操作
                         TimerBall(open_time,matchesVo1.getMatchId());
                     }
                 }
             }catch (Exception e){
                 e.printStackTrace();
             }finally {
                 redisLock.unlock();
             }

         }catch (Exception e){
             e.printStackTrace();
             RedisHelper.returnBrokenResource(jedis);
             LOTTERY_LOGGER.error("更新赛事缓存出错【"+matchType+"】",e);
         }finally {
             RedisHelper.returnResource(jedis);
         }
      }


    /**
     * 获取赔率列表
     * @param play_id
     * @param matchId
     * @return
     */
      public static   List<PlayOddsEntity> getList(int play_id,int matchId){
          //play_id:  1-标准盘 ，2-让球 ，3-大小球
          List<PlayOddsEntity> list=((IPlayOddsService)SpringContextUtil.getBean("playOddsServiceImpl")).getMatchOddsList(play_id,matchId);
          int count=((IPlayOddsService)SpringContextUtil.getBean("playOddsServiceImpl")).countDefault(play_id,matchId);
          if(list.size() == 0){
              list=((IPlayOddsService)SpringContextUtil.getBean("playOddsServiceImpl")).getMatchOddsList(play_id,0);
              count=((IPlayOddsService)SpringContextUtil.getBean("playOddsServiceImpl")).countDefault(play_id,0);
          }
          if(count == 0 && list.size() >0){
              list.get(0).setIsDefault(1);
          }
          return list;
      }


    public static void main(String[] str){
        String title="德甲第25轮";
        System.out.println(title.substring(0,2));
        System.out.println(title.substring(2,title.length()));
    }



}
