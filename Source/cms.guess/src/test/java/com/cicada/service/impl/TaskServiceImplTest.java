package com.cicada.service.impl;

import com.cicada.SpringTestBase;
import com.cicada.pojo.vo.LotteryResultVo;
import com.cicada.service.ITaskService;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import javax.xml.ws.soap.Addressing;

import static org.junit.Assert.*;

/**
 * Created by Administrator on 2017/9/6.
 */
public class TaskServiceImplTest extends SpringTestBase{

    @Autowired
    private ITaskService taskService;

    @Test
    public void runLotteryProcess() throws Exception {
        LotteryResultVo vo = taskService.runLotteryProcess(402,true);

        System.out.println(vo);
    }

}