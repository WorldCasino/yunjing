package com.cicada.service.impl;

import com.cicada.pojo.vo.NewUserVo;
import org.junit.Test;

/**
 * Created by Administrator on 2017/5/19.
 */
public class ClientServiceImplTest {
    @Test
    public void fastLogin() throws Exception {
        ClientServiceImpl svc= new ClientServiceImpl();
        NewUserVo u = svc.fastLogin("15901794296","1234","阳光",1);
    }

}