package com.cicada.controller;

import com.cicada.pojo.Task;
import com.cicada.service.ITaskService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.List;

/**
 * Created by Administrator on 2017/5/10.
 * ~!@#$%^&*()_+
 */
@Controller
@RequestMapping("/mental")
public class MentalController extends BaseController {

    @Autowired
    private ITaskService taskService;

    @RequestMapping(value = "/tasks", method = RequestMethod.GET)
    public ResponseEntity<List<Task>> getTasks() {

        List<Task> tasks = taskService.getInProgressTasks();
        try {
            return ResponseEntity.ok(tasks);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
    }
}
