package com.cicada.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.cicada.commons.Exception.ApiException;
import com.cicada.commons.utils.*;
import com.cicada.enums.ErrorCodeEnum;
import com.cicada.pojo.ClientEntity;
import com.cicada.pojo.Task;
import com.cicada.pojo.Token;
import com.cicada.pojo.form.TaskPublishForm;
import com.cicada.pojo.vo.LotteryResultVo;
import com.cicada.pojo.vo.TaskVo;
import com.cicada.result.DatatablesResult;
import com.cicada.result.PicUploadResult;
import com.cicada.service.IClientService;
import com.cicada.service.ITaskService;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.Executor;
import java.util.concurrent.Executors;

/**
 * 竞猜项目管理
 * Created by Administrator on 2017/5/22.
 */
@Controller
@RequestMapping(value = "/api/task")
public class TaskController extends BaseController {

    @Autowired
    private IClientService clientService;
    @Autowired
    private ITaskService taskService;

    @Autowired
    private JacksonSerializer jacksonSerializer;

    private static final Logger LOGGER = LogManager.getLogger("lottery");

    /**
     * 竞猜列表数据
     * @return
     */
    @RequestMapping(value = "/list",method = RequestMethod.POST)
    public ResponseEntity<DatatablesResult> queryTaskList(
            @RequestBody JSONObject params) {
        int rows = params.getIntValue("length");
        int start = params.getIntValue("start");
        int draw = params.getIntValue("draw");
        int page = (start / rows) + 1;
        try {
            DatatablesResult result = this.taskService.selectTaskVoByPage(params, page, rows, draw);
            return ResponseEntity.ok(result);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
    }

    /**
     * 发布竞猜
     * @return
     * @throws IOException
     */
    /*
    @RequestMapping(value = "/publish")
    @ResponseBody
    public ResponseEntity taskPublish(TaskPublishForm form,
                                      @RequestParam(value = "img_right" ,required = false) MultipartFile imgRight,
                                      @RequestParam(value = "img_others" ,required = false) MultipartFile[] imgOthers) throws IOException{

        ResponseWrapper result;

        try{
            JSONObject params = new JSONObject();
            params.put("shiro_user",super.getUserId());

            //发布竞猜
            result = this.publish(params,imgRight,imgOthers);

        }catch (Exception e){
            LOGGER.error("竞猜发布失败",e);
            result = ResponseWrapper.failed(ErrorCodeEnum.SystemError.getCode(), ErrorCodeEnum.SystemError.getDesc());
        }

        return ResponseEntity.ok(jacksonSerializer.toJson(result));
    }
    */

    /**
     * 发布竞猜
     * TODO 这种方式比较傻，一个个字段写上去。。。有时间再换成上面的方式 用TaskPublishForm接收
     * @return
     * @throws IOException
     */
    @RequestMapping(value = "/publish")
    @ResponseBody
    public ResponseEntity taskPublish(@RequestParam("task_id") int taskId,
                                      @RequestParam("user_id") int userId,
                                      @RequestParam("task_type") int taskType,
                                      @RequestParam("task_content") String taskContent,
                                      @RequestParam("answer_right_id") int answerRightId,
                                      @RequestParam("answer_right") String answerRight,
                                      @RequestParam("answer_right_odds") double rightOdds,
                                      @RequestParam("answer_err_id") int answerErrId,
                                      @RequestParam("answer_err") String answerErr,
                                      @RequestParam("answer_err_odds") double errOdds,
                                      @RequestParam("sale_price") int salePrice,
                                      @RequestParam("quantity") int quantity,
                                      @RequestParam("lock_time") String lockTime,
                                      @RequestParam("settle_time") String settleTime,
                                      @RequestParam("hot") int hot,
                                      @RequestParam("team_name_a") String teamNameA,
                                      @RequestParam("team_name_b") String teamNameB,
                                      @RequestParam("odds_a_win") double oddsAWin,
                                      @RequestParam("odds_dogfall") double oddsDogfall,
                                      @RequestParam("odds_b_win") double oddsBWin,
                                      @RequestParam(value = "img_right" ,required = false) MultipartFile imgRight,
                                      @RequestParam(value = "img_others" ,required = false) MultipartFile[] imgOthers) throws IOException{

        ResponseWrapper result;

        try{

            //TODO 为神马混合表单提交不用 @RequestBody JSONObject params 呢？？？
            JSONObject params = new JSONObject();
            params.put("task_id",taskId);
            params.put("user_id",userId);
            params.put("task_type",taskType);
            params.put("task_content",taskContent);
            params.put("answer_right_id",answerRightId);
            params.put("answer_right",answerRight);
            params.put("answer_right_odds",rightOdds);
            params.put("answer_err_id",answerErrId);
            params.put("answer_err",answerErr);
            params.put("answer_err_odds",errOdds);
            params.put("sale_price",salePrice);
            params.put("quantity",quantity);
            params.put("lock_time",lockTime);
            params.put("settle_time",settleTime);
            params.put("hot",hot);
            params.put("team_name_a",teamNameA);
            params.put("team_name_b",teamNameB);
            params.put("odds_a_win",oddsAWin);
            params.put("odds_dogfall",oddsDogfall);
            params.put("odds_b_win",oddsBWin);
            params.put("shiro_user",super.getUserId());

            //发布竞猜
            result = this.publish(params,imgRight,imgOthers);

//            LotteryResultVo rtn = new LotteryResultVo(176,3,"换行换行","什么鬼");
//            rtn.addPlayerResult(3,11,'A',false,2.0,10,200);
//            rtn.addPlayerResult(3,12,'B',true,2.5,2,20);
//            taskService.runLotterySuccessNotify(rtn);
        }catch (Exception e){
            LOGGER.error("竞猜发布失败",e);
            result = ResponseWrapper.failed(ErrorCodeEnum.SystemError.getCode(), ErrorCodeEnum.SystemError.getDesc());
        }

        return ResponseEntity.ok(jacksonSerializer.toJson(result));
    }

    private ResponseWrapper publish(JSONObject params,MultipartFile imgRight,MultipartFile[] imgOthers) throws IOException{
        ResponseWrapper result;

        try{
            params.put("shiro_user",super.getUserId());
            String answerRight = params.getString("answer_right");

            ClientEntity client = clientService.selectById(params.getInteger("user_id"));
            String nickname = StringUtils.isEmpty(client.getNickname())?client.getPhonenumber():client.getNickname();

            PicUploadResult imgRightResult = FileUploadUtil.imgUpload(imgRight, true, answerRight, nickname);
            List<PicUploadResult> imgOthersResult = FileUploadUtil.imgUpload(imgOthers, false, "", nickname);
            //发布竞猜
            Task task = taskService.publish(params,imgRightResult,imgOthersResult);

            //加入倒计时开奖队列
            int expire = (int)(task.getSettleTime().getTime()/1000 - System.currentTimeMillis()/1000);
            taskService.pushCountDownLotteryQueue(task.getTaskId(),expire);
            result = ResponseWrapper.succeed(task);

            LOGGER.info(String.format("竞猜项目【%s】发布成功！",task.getTaskId()));

        }catch (ApiException e){
            LOGGER.error("竞猜发布失败",e);
            result = ResponseWrapper.failed(e.getCode(),e.getMessage());
        }catch (Exception e){
            LOGGER.error("竞猜发布失败",e);
            result = ResponseWrapper.failed(ErrorCodeEnum.SystemError.getCode(), ErrorCodeEnum.SystemError.getDesc());
        }

        return result;
    }

    /**
     * 开奖处理
     * @param params
     * @return
     */
    @RequestMapping(value = "/lottery",method ={ RequestMethod.POST,RequestMethod.GET})
    @ResponseBody
    public ResponseEntity runLotteryProcess(@RequestBody JSONObject params){

        ResponseWrapper result = null;
        long taskId = params.getLongValue("taskId");
        long answerId = params.getLongValue("answerId");
        try {
            result = this.letteryProcess(taskId,answerId);
        }catch (ApiException e){
            e.printStackTrace();
            result = ResponseWrapper.failed(ErrorCodeEnum.SystemError.getCode(),"开奖处理失败！");
        }
        return ResponseEntity.ok(result);
    }

    /**
     * 开奖处理
     * @param params
     * @return
     */
    @RequestMapping(value = "/front/lottery",method ={ RequestMethod.POST})
    @ResponseBody
    public ResponseEntity runFrontLotteryProcess(@RequestBody JSONObject params){
        ResponseWrapper result = null;
        long taskId = params.getLongValue("taskId");
        long answerId = params.getLongValue("answerId");
        String tokenStr = params.getString("token");
        try {
            Token token = AesTokenUtil.verifyToken(tokenStr);
            result = this.letteryProcess(taskId,answerId);
        }catch (ApiException e){
            e.printStackTrace();
            result = ResponseWrapper.failed(ErrorCodeEnum.SystemError.getCode(),"开奖处理失败！");
        }
        return ResponseEntity.ok(result);
    }

    private ResponseWrapper letteryProcess(long taskId,long answerId){
        ResponseWrapper result = null;
        LotteryResultVo rtn;
        RedisTemplate<String, Object> redisTemplate = (RedisTemplate<String, Object>)SpringContextUtil.getBean("redisTemplate");
        RedisLockUtil lock = new RedisLockUtil(redisTemplate, "LOTTERY_TASK_"+String.valueOf(taskId), 10000, 20000);
        try {
            if(lock.lock()) {
                if(answerId > 0)
                    rtn = taskService.runLotteryProcess(taskId,answerId);
                else
                    rtn = taskService.runLotteryProcess(taskId,true);

                //开奖结果通知
                if(null != rtn) {
                    taskService.runLotterySuccessNotify(rtn);
                    result = ResponseWrapper.succeed(rtn);
                }else {
                    result = ResponseWrapper.failed(ErrorCodeEnum.SystemError.getCode(),"开奖处理失败！");
                }
            }
        }catch (InterruptedException e) {
            e.printStackTrace();
            result = ResponseWrapper.failed(ErrorCodeEnum.SystemError.getCode(),"开奖处理失败！");

        }catch (ApiException e){
            e.printStackTrace();
            result = ResponseWrapper.failed(ErrorCodeEnum.SystemError.getCode(),"开奖处理失败！");
        }

        return result;
    }
    /**
     * 锁定竞猜项目
     * @param params
     * @return
     */
    @RequestMapping(value = "/lock",method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity lockTask(@RequestBody JSONObject params){
        if (!SecurityUtils.getSubject().isAuthenticated()) {
            return  ResponseEntity.ok(ResponseWrapper.failed(ErrorCodeEnum.AuthenticationException.getCode(),
                    ErrorCodeEnum.AuthenticationException.getDesc()));
        }

        boolean rtn = false;
        try {
            JSONArray taskIds = params.getJSONArray("taskIds");
            List<Long> ids = new ArrayList<>();
            for (Object id:taskIds) {
                ids.add(Long.valueOf(id.toString()));
            }
            rtn = taskService.lockTask(ids);
        }catch (ApiException e){
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
        }
        return ResponseEntity.ok(ResponseWrapper.succeed(rtn));
    }

    /**
     * 推荐竞猜项目到首页
     * @param params
     * @return
     */
    @RequestMapping(value = "/recommend",method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity recommendTask(@RequestBody JSONObject params){
        if (!SecurityUtils.getSubject().isAuthenticated()) {
            return  ResponseEntity.ok(ResponseWrapper.failed(ErrorCodeEnum.AuthenticationException.getCode(),
                    ErrorCodeEnum.AuthenticationException.getDesc()));
        }

        boolean rtn = false;
        try {
            JSONArray taskIds = params.getJSONArray("taskIds");
            List<Long> ids = new ArrayList<>();
            for (Object id:taskIds) {
                ids.add(Long.valueOf(id.toString()));
            }
            rtn = taskService.recommendTask(ids);
        }catch (ApiException e){
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
        }
        return ResponseEntity.ok(ResponseWrapper.succeed(rtn));
    }

    /**
     * 获取竞猜详情
     * @param params
     * @return
     * @throws IOException
     */
    @RequestMapping(value = "/detail",method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity queryTaskDetail(@RequestBody JSONObject params) throws IOException{
        ResponseWrapper result;

        try {
            TaskVo vo = this.taskService.selectTaskVo(params);
            result = ResponseWrapper.succeed(vo);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
        }

        return ResponseEntity.ok(result);
    }
}
