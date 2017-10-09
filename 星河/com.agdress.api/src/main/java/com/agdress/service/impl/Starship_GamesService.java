package com.agdress.service.impl;

import com.agdress.bgapi.GameRsp;
import com.agdress.bgapi.IGameConnector;
import com.agdress.bgapi.rsp.OrderQuery;
import com.agdress.bgapi.rsp.OrderQueryItem;
import com.agdress.bgapi.rsp.VideoRoundQuery;
import com.agdress.bgapi.rsp.VideoRoundQueryItem;
import com.agdress.commons.Exception.ApiException;
import com.agdress.commons.utils.Base64Util;
import com.agdress.commons.utils.DateFormatUtil;
import com.agdress.commons.utils.DateUtil;
import com.agdress.commons.utils.cmsUtil;
import com.agdress.entity.AgentEntity;
import com.agdress.entity.Starship_AgentEntity;
import com.agdress.entity.vo.Starship_AgentrVo;
import com.agdress.entity.vo.Starship_UserlistVo;
import com.agdress.enums.GamesIdEnum;
import com.agdress.enums.GamesStatusEnum;
import com.agdress.enums.GamesVideoStatusEnum;
import com.agdress.mapper.AgentMapper;
import com.agdress.mongodb.DBOrderGamesDao;
import com.agdress.mongodb.model.DBOrderGames;
import com.agdress.result.DatatablesResult;
import com.agdress.service.IAgentService;
import com.agdress.service.IUserService;
import com.agdress.service.Starship_IGamesService;
import com.agdress.service.Starship_IUserService;
import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.apache.log4j.LogManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/8/17.
 */

@Service
@Transactional
public class Starship_GamesService  implements Starship_IGamesService {


    @Autowired
    private IGameConnector gameConnector;


    @Autowired
    private Starship_IUserService userService;

    @Autowired
    private DBOrderGamesDao dbOrderGamesDao;

    private static final org.apache.log4j.Logger GAMES = LogManager.getLogger("games");


    /**
     * 获取游戏列表
     * @param params
     * @param page
     * @param rows
     * @param draw
     * @return
     */
    @Override
    public DatatablesResult<OrderQueryItem> selectGames(JSONObject params, Integer page, Integer rows, Integer draw) {
        PageHelper.startPage(page, rows);
        Map<String,String> whereMap = cmsUtil.toHashMap(params);
        List<DBOrderGames> dbOrderGamesList=new ArrayList<DBOrderGames>();
        int total=10;
        Double allcome_onmoney=0.00;//入金总额
        Double allexpendmoney=0.00;//出金总额
        Double allzhuanmoney=0.00;//转码总量
        try{
            DBOrderGames dbOrderGames=new DBOrderGames();
            if(whereMap.get("loginId") != null && !whereMap.get("loginId").toString().equals("")){
                dbOrderGames.setLoginId(whereMap.get("loginId"));
            }
            if(whereMap.get("uid") != null && !whereMap.get("uid").toString().equals("")){
                dbOrderGames.setUid(Long.parseLong(whereMap.get("uid")));
            }
            if(whereMap.get("loginagentId") != null && !whereMap.get("loginagentId").toString().equals("")){
                dbOrderGames.setAgentId(whereMap.get("loginagentId"));
            }else{
                if(whereMap.get("agentId") != null && !whereMap.get("agentId").toString().equals("")){
                    dbOrderGames.setAgentId(whereMap.get("agentId"));
                }
            }
            if(whereMap.get("fromIp") != null && !whereMap.get("fromIp").toString().equals("")){
                dbOrderGames.setFromIp(whereMap.get("fromIp"));
            }
            if(whereMap.get("orderStatus") != null && !whereMap.get("orderStatus").toString().equals("")){
                dbOrderGames.setShowOrderStatus(Integer.parseInt(whereMap.get("orderStatus")));
            }
            if(whereMap.get("showStarttime") != null && !whereMap.get("showStarttime").toString().equals("")){
                dbOrderGames.setStarttime(DateUtil.fomatDate(whereMap.get("showStarttime")));
            }
            if(whereMap.get("showEndtime") != null && !whereMap.get("showEndtime").toString().equals("")){
                dbOrderGames.setEndtime(DateUtil.fomatDate(whereMap.get("showEndtime")));
            }

            if(whereMap.get("gameId") != null && !whereMap.get("gameId").toString().equals("")){
                dbOrderGames.setShowGameId(Integer.parseInt(whereMap.get("gameId")));
            }
            int skip=(page-1)*10-1;
            dbOrderGamesList=dbOrderGamesDao.findList(dbOrderGames,skip,rows);//分页数据
            //统计数据
            Map<String,String> map=dbOrderGamesDao.countSum(dbOrderGames);
            total=Integer.parseInt(map.get("countAll"));
            allcome_onmoney=Double.parseDouble(map.get("allcome_onmoney"));
            allexpendmoney=Double.parseDouble(map.get("allexpendmoney"));
            allzhuanmoney=Double.parseDouble(map.get("allzhuanmoney"));

        }catch (Exception e){
            e.printStackTrace();
        }
        PageInfo<DBOrderGames> pageInfo = new PageInfo<DBOrderGames>(dbOrderGamesList);
        DatatablesResult pageResult = new DatatablesResult<DBOrderGames>();
        pageResult.setData(dbOrderGamesList);
        pageResult.setDraw(draw);
        pageResult.setRecordsTotal(total);
        pageResult.setAllcome_onmoney(allcome_onmoney);
        pageResult.setAllexpendmoney(allexpendmoney);
        pageResult.setAllzhuanmoney(allzhuanmoney);
        pageResult.setRecordsFiltered(pageResult.getRecordsTotal());
        return pageResult;
    }


    /**
     * 获取游戏记录从第三方
     * @param userIds
     * @param loginIds
     * @param agentId
     * @param agentLoginId
     * @param starttime
     * @param endtime
     * @param moduleId
     * @param gameId
     * @param issueId
     * @param playerId
     * @param pageIndex
     * @param pageSize
     * @param etag
     */
    @Override
    public  void getThreeGamesList(List<Long> userIds, List<String> loginIds,
                                  long agentId, String agentLoginId, String starttime, String endtime, int moduleId,
                                  int gameId, int issueId, String playerId, int pageIndex, int pageSize, String etag) {
        try {
            GameRsp gameRsp = gameConnector.openOrderQuery(userIds, loginIds, agentId, agentLoginId,
                    starttime, endtime, moduleId, gameId, issueId, playerId, pageIndex, pageSize, etag);
            if (gameRsp.getError() == null) {
                OrderQuery orderQuery= (OrderQuery) gameRsp.getResult();
                List<OrderQueryItem> list=orderQuery.getItems();
                DBOrderGames dbOrderGames=null;
                OrderQueryItem orderQueryItem=null;
                for (int i = 0; i < list.size(); i++) {
                    orderQueryItem=list.get(i);
//                    System.out.println(i+"=="+orderQueryItem.toString());
                    dbOrderGames=dbOrderGamesDao.findOne(orderQueryItem.getOrderId());
                    if(dbOrderGames == null){
                        dbOrderGames=new DBOrderGames();
                    }else{
                        continue;
                    }
                    dbOrderGames.setOrderId(orderQueryItem.getOrderId());
                    dbOrderGames.setUid(orderQueryItem.getUid());
                    dbOrderGames.setLoginId(orderQueryItem.getLoginId());
                    Starship_AgentrVo starship_agentrVo=userService.getAgentLoginId(orderQueryItem.getLoginId());
                    if(starship_agentrVo == null || starship_agentrVo.getAgentId() == null){
                        dbOrderGames.setAgentId("0");
                        dbOrderGames.setAgentNumber("0");
                        dbOrderGames.setBgAgentId("0");
                    }else{
                        dbOrderGames.setAgentId(String.valueOf(starship_agentrVo.getAgentId()));
                        dbOrderGames.setAgentNumber(String.valueOf(starship_agentrVo.getAgentNumber()));
                        dbOrderGames.setBgAgentId(String.valueOf(starship_agentrVo.getBgAgentId()));
                    }
                    dbOrderGames.setTableId(String.valueOf(orderQueryItem.getTranId()));
                    dbOrderGames.setSn(orderQueryItem.getSn());
                    dbOrderGames.setModuleId(orderQueryItem.getModuleId());
                    dbOrderGames.setModuleName(orderQueryItem.getModuleName());
                    dbOrderGames.setaAmount(orderQueryItem.getaAmount());
                    dbOrderGames.setbAmount(orderQueryItem.getbAmount());
                    //判断转码总量：输赢是0，显示投注数，输赢不是0，显示0
                    if(orderQueryItem.getaAmount() == 0){
                        dbOrderGames.setZmAmount(orderQueryItem.getbAmount());
                    }else{
                        dbOrderGames.setZmAmount(0F);
                    }
                    dbOrderGames.setFromIp(orderQueryItem.getFromIp());
                    dbOrderGames.setShowGameId(orderQueryItem.getGameId());
                    dbOrderGames.setShowOrderStatus(orderQueryItem.getOrderStatus());
                    if( orderQueryItem.getGameId() == GamesIdEnum.BJL.getCode() ){
                        dbOrderGames.setGameId(GamesIdEnum.BJL);
                    }else if( orderQueryItem.getGameId() == GamesIdEnum.LP.getCode() ){
                        dbOrderGames.setGameId(GamesIdEnum.LP);
                    }else if( orderQueryItem.getGameId() == GamesIdEnum.SB.getCode() ){
                        dbOrderGames.setGameId(GamesIdEnum.SB);
                    }else if( orderQueryItem.getGameId() == GamesIdEnum.LHD.getCode() ){
                        dbOrderGames.setGameId(GamesIdEnum.LHD);
                    }else if( orderQueryItem.getGameId() == GamesIdEnum.MYBJL.getCode() ){
                        dbOrderGames.setGameId(GamesIdEnum.MYBJL);
                    }else if( orderQueryItem.getGameId() == GamesIdEnum.CJL.getCode() ){
                        dbOrderGames.setGameId(GamesIdEnum.CJL);
                    }else if( orderQueryItem.getGameId() == GamesIdEnum.JSBJL.getCode() ){
                        dbOrderGames.setGameId(GamesIdEnum.JSBJL);
                    }else if( orderQueryItem.getGameId() == GamesIdEnum.GMBJL.getCode() ){
                        dbOrderGames.setGameId(GamesIdEnum.GMBJL);
                    }else if( orderQueryItem.getGameId() == GamesIdEnum.NN.getCode() ){
                        dbOrderGames.setGameId(GamesIdEnum.NN);
                    }else if( orderQueryItem.getGameId() == GamesIdEnum.BXBJL.getCode() ){
                        dbOrderGames.setGameId(GamesIdEnum.BXBJL);
                    }
                    dbOrderGames.setGameName(orderQueryItem.getGameName());
                    dbOrderGames.setIssueId(orderQueryItem.getIssueId());
                    dbOrderGames.setPlayId(orderQueryItem.getPlayId());
                    //对时间进行处理
                    Date date=orderQueryItem.getOrderTime();
                    dbOrderGames.setOrderTime(date);
                    if( orderQueryItem.getOrderStatus() == GamesStatusEnum.Unsettled.getCode() ){
                        dbOrderGames.setOrderStatus(GamesStatusEnum.Unsettled);
                    }else if( orderQueryItem.getOrderStatus() == GamesStatusEnum.WinSettled.getCode() ){
                        dbOrderGames.setOrderStatus(GamesStatusEnum.WinSettled);
                    }else if( orderQueryItem.getOrderStatus() == GamesStatusEnum.SettlementAnd.getCode() ){
                        dbOrderGames.setOrderStatus(GamesStatusEnum.SettlementAnd);
                    }else if( orderQueryItem.getOrderStatus() == GamesStatusEnum.SettleTransfer.getCode() ){
                        dbOrderGames.setOrderStatus(GamesStatusEnum.SettleTransfer);
                    }else if( orderQueryItem.getOrderStatus() == GamesStatusEnum.Cancel.getCode() ){
                        dbOrderGames.setOrderStatus(GamesStatusEnum.Cancel);
                    }else if( orderQueryItem.getOrderStatus() == GamesStatusEnum.BeOverdue.getCode() ){
                        dbOrderGames.setOrderStatus(GamesStatusEnum.BeOverdue);
                    }else if( orderQueryItem.getOrderStatus() == GamesStatusEnum.SystemCancel.getCode() ){
                        dbOrderGames.setOrderStatus(GamesStatusEnum.SystemCancel);
                    }
                    GameRsp rsp = gameConnector.openVideoRoundQuery(0, list.get(i).getIssueId(), 0, null, null, 0, 0, null);
                    if (rsp.getError() == null) {
                        VideoRoundQuery videoRoundQuery= (VideoRoundQuery) rsp.getResult();
                        List<VideoRoundQueryItem> list2=videoRoundQuery.getItems();
                        for (int j = 0; j < list2.size(); j++) {
                            VideoRoundQueryItem videoRoundQueryItem=list2.get(j);
//                            System.out.println("videoRoundQueryItem=="+videoRoundQueryItem.toString());
                            dbOrderGames.setTableId(videoRoundQueryItem.getTableId());
                            if( videoRoundQueryItem.getStatus()== GamesVideoStatusEnum.Unsettled.getCode() ){
                                dbOrderGames.setGamesVideoStatusEnum(GamesVideoStatusEnum.Unsettled);
                            }else if( videoRoundQueryItem.getStatus() == GamesVideoStatusEnum.Settled.getCode() ){
                                dbOrderGames.setGamesVideoStatusEnum(GamesVideoStatusEnum.Settled);
                            }else if( videoRoundQueryItem.getStatus() == GamesVideoStatusEnum.SettledError.getCode() ){
                                dbOrderGames.setGamesVideoStatusEnum(GamesVideoStatusEnum.SettledError);
                            }else if( videoRoundQueryItem.getStatus() == GamesVideoStatusEnum.GamesError.getCode() ){
                                dbOrderGames.setGamesVideoStatusEnum(GamesVideoStatusEnum.GamesError);
                            }else if( videoRoundQueryItem.getStatus() == GamesVideoStatusEnum.AdministratorInterrupt.getCode() ){
                                dbOrderGames.setGamesVideoStatusEnum(GamesVideoStatusEnum.AdministratorInterrupt);
                            }
                            //对时间进行处理
                            Date date2=videoRoundQueryItem.getOpenTime();
                            dbOrderGames.setOpenTime(date2);
                            //对时间进行处理
                            Date date3=videoRoundQueryItem.getCalcTime();
                            dbOrderGames.setCalcTime(date3);
                            dbOrderGames.setResult(videoRoundQueryItem.getResult());
                            dbOrderGames.setBetAmount(videoRoundQueryItem.getBetAmount());
                            dbOrderGames.setBetResult(videoRoundQueryItem.getBetResult());
                            dbOrderGames.setBaccarat(videoRoundQueryItem.getBaccarat());
                            dbOrderGames.setBaccarat64(videoRoundQueryItem.getBaccarat64());
                            String result_content="0";//处理游戏结果
                            String licensingInfor="0";//处理发牌资料
                            int gametype=videoRoundQueryItem.getGameType();
                            if(gametype == GamesIdEnum.BJL.getCode() || gametype ==  GamesIdEnum.JSBJL.getCode() || gametype ==  GamesIdEnum.BXBJL.getCode() || gametype ==  GamesIdEnum.DCBJL.getCode() || gametype ==  GamesIdEnum.GMBJL.getCode()
                                    ){
                                //根据解码的getBaccarat64
                                if(videoRoundQueryItem.getBaccarat64() != null){
                                    dbOrderGames.setBaccarat64_back(Base64Util.decode(videoRoundQueryItem.getBaccarat64()));
                                }


                            }else{
                                //根据result


                            }
                            dbOrderGames.setResultContent(result_content);
                            dbOrderGames.setLicensingInfor(licensingInfor);
                            //==============
                            dbOrderGames.setDealer(videoRoundQueryItem.getDealer());
                            dbOrderGames.setDealerId(videoRoundQueryItem.getDealerId());
                            dbOrderGames.setSerialNo(videoRoundQueryItem.getSerialNo());
                        }
                    } else {
                        GAMES.error("games-请求游戏数据失败!"+-1);
                    }
                    System.out.println(i+"=====存入数据"+dbOrderGames.toString());
                    dbOrderGamesDao.save(dbOrderGames);
                }
            } else {
                // TODO: 2017/8/14 整理游戏错误
                GAMES.error("games-请求游戏数据失败!"+-1);
            }
        }catch (Exception e){
            e.printStackTrace();
            GAMES.error("games-获取游戏记录失败"+e.toString());
        }
    }





}
