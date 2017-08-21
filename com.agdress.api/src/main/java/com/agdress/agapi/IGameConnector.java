package com.agdress.agapi;

import io.reactivex.Single;

/**
 * Created by Administrator on 2017/7/25.
 * Description: *_*
 * game connector interface
 */

@Deprecated
public interface IGameConnector {

    GameResp checkOrCreateGameAccount(String cagent, String loginname, String method, String actype,
                                    String password, String oddtype, String cur);

    GameResp getBalance(String cagent, String loginname, String method, String actype,
                    String password, String cur);

    GameResp prepareTransferCredit(String cagent, String loginname, String method, String billno,
                               String type, String credit, String actype, String password,
                               String fixcredit, String gameCategory, String cur);

    GameResp transferCreditConfirm(String cagent, String loginname, String method, String billno,
                               String type, String credit, String actype, String flag,
                               String password, String fixcredit, String gameCategory, String cur);

    GameResp queryOrderStatus(String cagent, String billno, String method, String actype,
                          String cur);

    GameResp forwardGame(String cagent, String loginname, String password, String dm,
                     String sid, String actype, String lang, String gameType,
                     String oddtype, String cur, String mh5, String session_token);
}
