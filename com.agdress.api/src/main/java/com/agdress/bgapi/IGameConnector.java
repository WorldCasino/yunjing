package com.agdress.bgapi;

import com.agdress.bgapi.req.*;
import com.agdress.bgapi.rsp.*;

import java.io.IOException;
import java.util.Date;
import java.util.List;

/**
 * Created by Administrator on 2017/8/1.
 * Description: *_*
 */
public interface IGameConnector {

    GameRsp<Long> openAgentCreate(String loginId, String password) throws IOException;

    /**
     * @param nickname 非必须
     */
    GameRsp<UserCreate> openUserCreate(String agentLoginId, String agentPassword, String loginId, String nickname) throws IOException;

    GameRsp<UserGet> openUserGet(String agentPassword, String loginId) throws IOException;

    GameRsp<Integer> openUserEnable(String agentPassword, String loginId) throws IOException;

    GameRsp<Integer> openUserDisable(String agentPassword, String loginId) throws IOException;

    GameRsp<Float> openBalanceGet(String agentPassword, String loginId) throws IOException;

    /**
     *
     * @param bizId 非必须
     * @param checkBizId 非必须
     */
    GameRsp<Float> openBalanceTransfer(String agentPassword, String loginId, String amount, long bizId, String checkBizId) throws IOException;

    /**
     * 参数都是非必须参数
     * 时间参数格式 yyyy-MM-dd hh:mm:ss
     */
    GameRsp<OrderQuery> openOrderQuery(List<Long> userIds, List<String> loginIds,
                                       long agentId, String agentLoginId, Date startTime, Date endTime, int moduleId,
                                       int gameId, int issueId, String playerId, int pageIndex, int pageSize, String etag) throws IOException;

    /**
     * @param isMobileUrl 非必须
     * @param returnUrl 非必须
     */
    GameRsp<String> openVideoGameUrl(String agentPassword, String loginId, int isMobileUrl, String returnUrl) throws IOException;

    GameRsp<String> openUserLogout(String agentPassword, String loginId) throws IOException;

    GameRsp<BalanceTransferQuery> openBalanceTransferQuery(String loginId, long agentId, String agentLoginId,
                                                           Date startTime, Date endTime, long bizId, String sortHint, int pageIndex, int pageSize) throws IOException;

    GameRsp<VideoRoundQuery> openVideoRoundQuery(int gameType, String round, int status, Date startTime, Date endTime, int pageIndex, int pageSize, String etag) throws IOException;

    GameRsp<String> openVideoTrialGameUrl(int isMobileUrl, String returnUrl) throws IOException;
}
