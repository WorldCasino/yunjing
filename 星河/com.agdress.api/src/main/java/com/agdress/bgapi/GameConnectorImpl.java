package com.agdress.bgapi;

import com.agdress.bgapi.req.*;
import com.agdress.bgapi.rsp.*;
import com.agdress.commons.utils.JacksonSerializer;
import com.agdress.commons.utils.SystemConfig;
import com.fasterxml.jackson.core.type.TypeReference;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.UUID;

/**
 * Created by Administrator on 2017/8/2.
 * Description: *_*
 */
@Component
public class GameConnectorImpl implements IGameConnector {

    private final static String JSON_RPC = "2.0";

    private JacksonSerializer serializer;
    private SystemConfig systemConfig;

    @Autowired
    public GameConnectorImpl(JacksonSerializer serializer, SystemConfig config) {
        this.serializer = serializer;
        this.systemConfig = config;
    }

    @SuppressWarnings("unchecked")
    @Override
    public GameRsp<Long> openAgentCreate(String loginId, String password) throws IOException {

        String random = UUID.randomUUID().toString();

        String sign = HashUtil.md5Hex(random + systemConfig.getGAME_SN() + loginId + systemConfig.getGAME_SECRETKEY());
        AgentCreateReq params = new AgentCreateReq(random, sign, systemConfig.getGAME_SN(), loginId, password);

        String method = "open.agent.create";
        String url = systemConfig.getGAME_API() + method;

        return gameRequest(url, new GameReq(random, method, params, JSON_RPC), new TypeReference<GameRsp<Long>>() {});
    }

    @SuppressWarnings("unchecked")
    @Override
    public GameRsp<UserCreate> openUserCreate(String agentLoginId, String agentPassword, String loginId, String nickname) throws IOException {
        String random = UUID.randomUUID().toString();

        String secretCode = HashUtil.sha1Base64(agentPassword);
        String digest = HashUtil.md5Hex(random + systemConfig.getGAME_SN() + secretCode);
        UserCreateReq params = new UserCreateReq(random, digest, systemConfig.getGAME_SN(), loginId, nickname, agentLoginId);

        String method = "open.user.create";
        String url = systemConfig.getGAME_API() + method;

        return gameRequest(url, new GameReq(random, method, params, JSON_RPC), new TypeReference<GameRsp<UserCreate>>() {});
    }

    @SuppressWarnings("unchecked")
    @Override
    public GameRsp<UserGet> openUserGet(String agentPassword, String loginId) throws IOException {
        String random = UUID.randomUUID().toString();

        String secretCode = HashUtil.sha1Base64(agentPassword);
        String digest = HashUtil.md5Hex(random + systemConfig.getGAME_SN() + loginId+  secretCode);
        UserOperateReq params = new UserOperateReq(random, digest, systemConfig.getGAME_SN(), loginId);

        String method = "open.user.get";
        String url = systemConfig.getGAME_API() + method;
        return gameRequest(url, new GameReq(random, method, params, JSON_RPC), new TypeReference<GameRsp<UserGet>>() {});
    }

    @SuppressWarnings("unchecked")
    @Override
    public GameRsp<Integer> openUserEnable(String agentPassword, String loginId) throws IOException {
        String random = UUID.randomUUID().toString();

        String secretCode = HashUtil.sha1Base64(agentPassword);
        String digest = HashUtil.md5Hex(random + systemConfig.getGAME_SN() + loginId+  secretCode);
        UserOperateReq params = new UserOperateReq(random, digest, systemConfig.getGAME_SN(), loginId);

        String method = "open.user.enable";
        String url = systemConfig.getGAME_API() + method;
        return gameRequest(url, new GameReq(random, method, params, JSON_RPC), new TypeReference<GameRsp<Integer>>() {});
    }

    @SuppressWarnings("unchecked")
    @Override
    public GameRsp<Integer> openUserDisable(String agentPassword, String loginId) throws IOException  {
        String random = UUID.randomUUID().toString();

        String secretCode = HashUtil.sha1Base64(agentPassword);
        String digest = HashUtil.md5Hex(random + systemConfig.getGAME_SN() + loginId+  secretCode);
        UserOperateReq params = new UserOperateReq(random, digest, systemConfig.getGAME_SN(), loginId);

        String method = "open.user.disable";
        String url = systemConfig.getGAME_API() + method;
        return gameRequest(url, new GameReq(random, method, params, JSON_RPC), new TypeReference<GameRsp<Integer>>() {});
    }

    @SuppressWarnings("unchecked")
    @Override
    public GameRsp<Float> openBalanceGet(String agentPassword, String loginId) throws IOException  {
        String random = UUID.randomUUID().toString();

        String secretCode = HashUtil.sha1Base64(agentPassword);
        String digest = HashUtil.md5Hex(random + systemConfig.getGAME_SN() + loginId+  secretCode);
        UserOperateReq params = new UserOperateReq(random, digest, systemConfig.getGAME_SN(), loginId);

        String method = "open.balance.get";
        String url = systemConfig.getGAME_API() + method;
        return gameRequest(url, new GameReq(random, method, params, JSON_RPC), new TypeReference<GameRsp<Float>>() {});
    }

    @SuppressWarnings("unchecked")
    @Override
    public GameRsp<Float> openBalanceTransfer(String agentPassword, String loginId, String amount, long bizId, String checkBizId) throws IOException {
        String random = UUID.randomUUID().toString();

        String secretCode = HashUtil.sha1Base64(agentPassword);
        String digest = HashUtil.md5Hex(random + systemConfig.getGAME_SN() + loginId + amount + secretCode);
        BalanceTransferReq params = new BalanceTransferReq(random, digest, systemConfig.getGAME_SN(), loginId, amount, bizId, checkBizId);

        String method = "open.balance.transfer";
        String url = systemConfig.getGAME_API() + method;
        return gameRequest(url, new GameReq<>(random, method, params, JSON_RPC), new TypeReference<GameRsp<Float>>() {});
    }

    @SuppressWarnings("unchecked")
    @Override
    public GameRsp<OrderQuery> openOrderQuery(List<Long> userIds, List<String> loginIds,
                                              long agentId, String agentLoginId, String startTime, String endTime, int moduleId,
                                              int gameId, int issueId, String playerId, int pageIndex, int pageSize, String etag) throws IOException {
        String random = UUID.randomUUID().toString();

        String sign = HashUtil.md5Hex(random + systemConfig.getGAME_SN()  + systemConfig.getGAME_SECRETKEY());
        OrderQueryReq params = new OrderQueryReq(random, sign, systemConfig.getGAME_SN(), userIds, loginIds,
                agentId, agentLoginId, startTime, endTime, moduleId, gameId, issueId, playerId, pageIndex, pageSize, etag);

        String method = "open.order.query";
        String url = systemConfig.getGAME_API() + method;
        return gameRequest(url, new GameReq<>(random, method, params, JSON_RPC), new TypeReference<GameRsp<OrderQuery>>() {});
    }

    @SuppressWarnings("unchecked")
    @Override
    public GameRsp<String> openVideoGameUrl(String agentPassword, String loginId, int isMobileUrl, String returnUrl) throws IOException {
        String random = UUID.randomUUID().toString();

        String secretCode = HashUtil.sha1Base64(agentPassword);
        String digest = HashUtil.md5Hex(random + systemConfig.getGAME_SN() + loginId+  secretCode);
        VideoGameUrlReq params = new VideoGameUrlReq(random, digest, systemConfig.getGAME_SN(), loginId, isMobileUrl, 1, returnUrl);

        String method = "open.video.game.url";
        String url = systemConfig.getGAME_API() + method;
        return gameRequest(url, new GameReq(random, method, params, JSON_RPC), new TypeReference<GameRsp<String>>() {});
    }

    @SuppressWarnings("unchecked")
    @Override
    public GameRsp<String> openUserLogout(String agentPassword, String loginId) throws IOException {
        String random = UUID.randomUUID().toString();

        String secretCode = HashUtil.sha1Base64(agentPassword);
        String digest = HashUtil.md5Hex(random + systemConfig.getGAME_SN() + loginId+  secretCode);
        UserOperateReq params = new UserOperateReq(random, digest, systemConfig.getGAME_SN(), loginId);

        String method = "open.user.logout";
        String url = systemConfig.getGAME_API() + method;
        return gameRequest(url, new GameReq(random, method, params, JSON_RPC), new TypeReference<GameRsp<String>>() {});
    }

    @SuppressWarnings("unchecked")
    @Override
    public GameRsp<BalanceTransferQuery> openBalanceTransferQuery(String loginId, long agentId, String agentLoginId,
                                                                  Date startTime, Date endTime, long bizId, String sortHint, int pageIndex, int pageSize) throws IOException {
        String random = UUID.randomUUID().toString();

        String sign = HashUtil.md5Hex(random + systemConfig.getGAME_SN()  + systemConfig.getGAME_SECRETKEY());
        BalanceTransferQueryReq params = new BalanceTransferQueryReq(random, sign, systemConfig.getGAME_SN(), loginId, agentId, agentLoginId, startTime, endTime, bizId, sortHint, pageIndex, pageSize);

        String method = "open.balance.transfer.query";
        String url = systemConfig.getGAME_API() + method;
        return gameRequest(url, new GameReq(random, method, params, JSON_RPC), new TypeReference<GameRsp<BalanceTransferQuery>>() {});
    }

    @SuppressWarnings("unchecked")
    @Override
    public GameRsp<VideoRoundQuery> openVideoRoundQuery(int gameType, String round, int status, Date startTime, Date endTime, int pageIndex, int pageSize, String etag) throws IOException {
        String random = UUID.randomUUID().toString();

        String sign = HashUtil.md5Hex(random + systemConfig.getGAME_SN()  + systemConfig.getGAME_SECRETKEY());
        VideoRoundQueryReq params = new VideoRoundQueryReq(random, sign, systemConfig.getGAME_SN(), gameType, round, status, startTime, endTime, pageIndex, pageSize, etag);

        String method = "open.video.round.query";
        String url = systemConfig.getGAME_API() + method;
        return gameRequest(url, new GameReq(random, method, params, JSON_RPC), new TypeReference<GameRsp<VideoRoundQuery>>() {});
    }

    @Override
    public GameRsp<String> openVideoTrialGameUrl(int isMobileUrl, String returnUrl) throws IOException {
        String random = UUID.randomUUID().toString();

        String sign = HashUtil.md5Hex(random + systemConfig.getGAME_SN()  + systemConfig.getGAME_SECRETKEY());
        VideoTrialGameUrlReq params = new VideoTrialGameUrlReq(random, sign, systemConfig.getGAME_SN(), isMobileUrl, 1, returnUrl);

        String method = "open.video.trial.game.url";
        String url = systemConfig.getGAME_API() + method;
        return gameRequest(url, new GameReq<>(random, method, params, JSON_RPC), new TypeReference<GameRsp<String>>() {});
    }

    private <P, R> GameRsp<R> gameRequest(String url, P p, TypeReference<GameRsp<R>> valueTypeRef) throws IOException {
        String content = "json=" + serializer.toJson(p);
        String response = HttpClientUtil.post(url, content);
        return serializer.fromJson(response, valueTypeRef);
    }
}
