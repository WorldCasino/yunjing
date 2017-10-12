package com.cicada.job;


import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.cicada.commons.utils.ConstantInterface;
import com.cicada.commons.utils.DateFormatUtil;
import com.cicada.commons.utils.DateUtil;
import com.cicada.commons.utils.SpringContextUtil;
import com.cicada.enums.MatchesStatusEnum;
import com.cicada.enums.MatchesTypeEnum;
import com.cicada.job.Ball.BallUtil;
import com.cicada.job.Ball.BasketballMatchUtil;
import com.cicada.job.Ball.BasketballMatchUtil2;
import com.cicada.job.Ball.FootBallMatchUtil;
import com.cicada.pojo.MatchesEntity;
import com.cicada.redis.RedisHelper;
import com.cicada.service.IMatchesService;
import com.cicada.service.ITaskAnswerService;
import com.cicada.service.impl.MatchesServiceImpl;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import redis.clients.jedis.Jedis;

import java.util.Date;
import java.util.List;


/**
 *
* 类名称：BallMatchJob
* 类描述：  球赛事定时器
* 创建人：魏汉文
 "0 0 12 * * ?"    每天中午十二点触发
 "0 15 10 ? * *"    每天早上10：15触发
 "0 15 10 * * ?"    每天早上10：15触发
 "0 15 10 * * ? *"    每天早上10：15触发
 "0 15 10 * * ? 2005"    2005年的每天早上10：15触发
 "0 * 14 * * ?"    每天从下午2点开始到2点59分每分钟一次触发
 "0 0/5 14 * * ?"    每天从下午2点开始到2：55分结束每5分钟一次触发
 "0 0/5 14,18 * * ?"    每天的下午2点至2：55和6点至6点55分两个时间段内每5分钟一次触发
 "0 0-5 14 * * ?"    每天14:00至14:05每分钟一次触发
 "0 10,44 14 ? 3 WED"    三月的每周三的14：10和14：44触发
 "0 15 10 ? * MON-FRI"    每个周一、周二、周三、周四、周五的10：15触发
 */
@Component("ballMatchJob")
public class BallMatchJob {

	private static final Logger LOTTERY_LOGGER = LogManager.getLogger("ball");


	@Autowired
	private IMatchesService iMatchesService;

 	@Scheduled(cron = "0 10 0 * * *")
 	public  void overGoodsFee() {
 		try {
			LOTTERY_LOGGER.info("ball------更新赛事"+ DateFormatUtil.dateToString(new Date()));
			BasketballMatchUtil.setBallList();
 		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			LOTTERY_LOGGER.info(String.format("ball-获取赛事报错",e.toString()));
 		}
	}

	@Scheduled(cron = "0 15 0 * * *")
	public  void overGoodsFeeTwo() {
		try {
			LOTTERY_LOGGER.info("ball------更新赛事"+ DateFormatUtil.dateToString(new Date()));
			FootBallMatchUtil.setBallList();
			//处理重复的数据
			deleteBalForTwo();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			LOTTERY_LOGGER.info(String.format("ball-获取赛事报错",e.toString()));
		}
	}



	@Scheduled(fixedDelay = 1200000)//20分钟
	public  void changeRedisBallListTwo() {
		try {
			LOTTERY_LOGGER.info("ball-----蓝球更新缓存数据"+ DateFormatUtil.dateToString(new Date()));
			//开始redis存储
			BallUtil.changeRedisBallList(MatchesTypeEnum.Basketball.getCode()+"");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			LOTTERY_LOGGER.info(String.format("ball-获取赛事报错",e.toString()));
		}
	}



	@Scheduled(fixedDelay = 1800000)//半个小时
	public  void changeRedisBallList() {
		try {
			LOTTERY_LOGGER.info("ball------足球更新缓存数据"+ DateFormatUtil.dateToString(new Date()));
			//开始存储
			BallUtil.changeRedisBallList(MatchesTypeEnum.Football.getCode()+"");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			LOTTERY_LOGGER.info(String.format("ball-获取赛事报错",e.toString()));
		}
	}




	@Scheduled(fixedDelay = 720000)//12分钟
	public  void changeMatchOne() {
		Jedis jedis = null;
		try {
			LOTTERY_LOGGER.info("ball----未开赛是否存在redis中"+ DateFormatUtil.dateToString(new Date()));
			MatchesEntity matchesEntity=new MatchesEntity();
			//获取今天未开赛的所有比赛
			matchesEntity.setMatchesStatusEnum(MatchesStatusEnum.NotStarted);
			matchesEntity.setDayDate(DateUtil.getDay2());
			EntityWrapper<MatchesEntity> wrapper = new EntityWrapper<MatchesEntity>(matchesEntity);
			List<MatchesEntity> selectList =  iMatchesService.selectList(wrapper);
			for (MatchesEntity matchesEntity1   : selectList ) {
				String strkey = ConstantInterface.REDIS_BALLKEY_LOTTERY_PREFIX +matchesEntity1.getMatchId();
				jedis = RedisHelper.getJedis();
				if(jedis.exists(strkey)){
					continue;
				}
				//设置定时器----修改开始时间
				long opentime= matchesEntity1.getOpenTime().getTime();
				long nowtime=new Date().getTime();
				long open_n=(opentime-nowtime)/1000;
				if(open_n < 0){
					open_n=5;
				}
				jedis.setex(strkey,(int) open_n,String.format("待开赛任务 %s", matchesEntity1.getMatchId()));
				LOTTERY_LOGGER.info(String.format("ball-竞猜项目【%s】 成功加入倒计时开赛队列，过期时间%s秒",matchesEntity1.getMatchId(),open_n));
			}
 		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			RedisHelper.returnBrokenResource(jedis);
			LOTTERY_LOGGER.info(String.format("ball-更新赛果报错",e.toString()));
		}finally {
			RedisHelper.returnResource(jedis);
		}
	}


	@Scheduled(fixedDelay = 780000)//13分钟
	public  void changeMatchTwo() {
		Jedis jedis = null;
		try {
			LOTTERY_LOGGER.info("ball----正在比赛是否存在redis中"+ DateFormatUtil.dateToString(new Date()));
			MatchesEntity matchesEntity=new MatchesEntity();
			//获取今天正在进行的所有比赛
			matchesEntity.setMatchesStatusEnum(MatchesStatusEnum.Underway);
			EntityWrapper<MatchesEntity> wrapper = new EntityWrapper<MatchesEntity>(matchesEntity);
			List<MatchesEntity> selectList =  iMatchesService.selectList(wrapper);
			for (MatchesEntity matchesEntity1   : selectList ) {
				String strkey = ConstantInterface.REDIS_BALLKEY_LOTTERY_PREFIX +matchesEntity1.getMatchId();
				jedis = RedisHelper.getJedis();
				if(jedis.exists(strkey)){
					continue;
				}
				//设置定时器----修改开始时间
				long settletime= matchesEntity1.getSettleTime().getTime();
				long nowtime=new Date().getTime();
				long open_n=(settletime-nowtime)/1000;
				if(open_n < 0){
					open_n=5;
				}
				jedis.setex(strkey,(int) open_n,String.format("待开赛任务 %s", matchesEntity1.getMatchId()));
				LOTTERY_LOGGER.info(String.format("ball-竞猜项目【%s】 成功加入倒计时赛果队列，过期时间%s秒",matchesEntity1.getMatchId(),open_n));
			}
 		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			RedisHelper.returnBrokenResource(jedis);
			LOTTERY_LOGGER.info(String.format("ball-更新赛果报错",e.toString()));
		}finally {
			RedisHelper.returnResource(jedis);
		}
	}





	/**
	 * 处理重复数据
	 */
	public synchronized static void deleteBalForTwo(){
		//获取今天的所有比赛
		EntityWrapper ew = new EntityWrapper();
		ew.where("open_time >= {0}",DateUtil.getTime());
		ew.orderBy("match_id");
		List<MatchesEntity> selectList =  ((IMatchesService)SpringContextUtil.getBean("matchesServiceImpl")).selectList(ew);
		for ( MatchesEntity _match : selectList ) {
			long l1=_match.getMatchId();
//			if(l1 == 849){
//				System.out.println("");
//			}
//			if(l1 == 833){
//				System.out.println("");
//			}
			if(((IMatchesService) SpringContextUtil.getBean("matchesServiceImpl")).selectById(l1) == null  ){
				continue;
			}
			ew = new EntityWrapper();
			ew.where("home_team_id = {0}",_match.getHomeTeamId())
					.andNew("away_team_id = {0} ",_match.getAwayTeamId())
					.andNew("day_date  = {0}",_match.getDayDate())
					.andNew("day_time  = {0}",_match.getDayTime());
			ew.orderBy("match_id");
			List<MatchesEntity> selectList2 =((IMatchesService)SpringContextUtil.getBean("matchesServiceImpl")).selectList(ew);
			for ( MatchesEntity _match2 : selectList2 ) {
				long l2=_match2.getMatchId();
				if(l1 != l2){
  					((IMatchesService)SpringContextUtil.getBean("matchesServiceImpl")).deleteById(_match2.getMatchId());
				}
			}
		}
	}



 }
