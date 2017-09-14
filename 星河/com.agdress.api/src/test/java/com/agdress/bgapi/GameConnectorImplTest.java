package com.agdress.bgapi;

import com.agdress.SpringTestBase;
import com.agdress.commons.utils.JacksonSerializer;
import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import static org.junit.Assert.*;

/**
 * Created by Administrator on 2017/8/3.
 * Description: *_*
 */
public class GameConnectorImplTest extends SpringTestBase {
    Logger logger = LoggerFactory.getLogger(GameConnectorImplTest.class);

    @Autowired
    private IGameConnector gameConnector;

    @Autowired
    private JacksonSerializer jacksonSerializer;

    @Test
    public void agentCreateTest() throws Exception {
        GameRsp rsp = gameConnector.openAgentCreate("bgdressagenttest101", "bgdressagentpwd");
        assertNotNull(rsp);
    }

    @Test
    public void userCreateTest() throws Exception {
        GameRsp rsp = gameConnector.openUserCreate("bgdressagenttest101", "bgdressagentpwd", "bgdresstest101", "test101");
        assertNotNull(rsp);
    }

    @Test
    public void videoGameUrlTest() throws Exception {
        GameRsp rsp = gameConnector.openVideoGameUrl("bgdressagentpwd", "bgdresstest101", 0, null);
        assertNotNull(rsp);
    }

    @Test
    public void videoRoundQuery() throws Exception {
        GameRsp rsp = gameConnector.openVideoRoundQuery(0, null, 0, null, null, 0, 0, null);
        assertNotNull(rsp);
    }
}