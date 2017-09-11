package com.cicada.service;

import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.service.IService;
import com.cicada.commons.Exception.ApiException;
import com.cicada.enums.TaskStatusEnum;
import com.cicada.pojo.Task;
import com.cicada.pojo.vo.LotteryResultVo;
import com.cicada.pojo.vo.TaskVo;
import com.cicada.result.DatatablesResult;
import com.cicada.result.PicUploadResult;

import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/5/11.
 * Description: *_*
 */
public interface ITaskService extends IService<Task> {
    List<Task> getInProgressTasks();

    /**
     * 根据ID获取竞猜项目
     * @param taskId 竞猜项目ID
     * @return
     */
    TaskVo selectTaskVoById(int taskId) throws ApiException;

    /**
     * 更新竞猜状态
     * @param taskId 竞猜项目ID
     * @param status 竞猜状态
     * @return
     */
    boolean updateTaskStatus(int taskId,TaskStatusEnum status) throws ApiException;

    /**
     * 开奖处理
     * @param taskId 开奖项目
     * @param mustLottery 是否没买完也开奖
     * @return
     * @throws ApiException
     */
    LotteryResultVo runLotteryProcess(long taskId, boolean mustLottery) throws ApiException;

    /**
     * 开奖处理
     * @param taskId 开奖项目
     * @param answerId 竞猜正确答案
     * @return
     * @throws ApiException
     */
    LotteryResultVo runLotteryProcess(long taskId,long answerId) throws ApiException;

    /**
     * 开奖成功结果通知
     * @param resultVo 竞猜项目开奖结果
     */
    void runLotterySuccessNotify(LotteryResultVo resultVo);

    /**
     * 获取竞猜项目列表
     * @param params 查询参数
     * @param page 页码
     * @param rows 返回行数
     * @param draw
     * @return
     * @throws ApiException
     */
    @Deprecated
    DatatablesResult<TaskVo> selectTaskVo(JSONObject params, Integer page, Integer rows, Integer draw) throws ApiException;

    /**
     * 获取竞猜项目列表 分页
     * @param params 查询参数
     * @param page 页码
     * @param rows 返回行数
     * @param draw
     * @return
     * @throws ApiException
     */
    DatatablesResult<TaskVo> selectTaskVoByPage(JSONObject params, Integer page, Integer rows, Integer draw) throws ApiException;

    /**
     * 发布竞猜
     * @param params 前台提交的参数
     * @param imgRightResult 正确答案图片上传结果
     * @param imgOthersResult 错误答案图片上传结果
     * @return 竞猜实体
     * @throws ApiException
     */
    Task publish(JSONObject params,PicUploadResult imgRightResult,List<PicUploadResult> imgOthersResult) throws ApiException;

    /**
     * 加入倒计时开奖队列
     * @param taskId 竞猜项目ID
     * @param expire 倒计时时间（秒）
     */
    void pushCountDownLotteryQueue(long taskId,int expire);

    /**
     * 锁定竞猜项目
     * @param taskId 需要锁定的竞猜项目
     * @return
     */
    boolean lockTask(long taskId) throws ApiException;
    /**
     * 锁定竞猜项目
     * @param taskIds 所有需要锁定的竞猜项目
     * @return
     */
    boolean lockTask(List<Long> taskIds) throws ApiException;

    /**
     * 检查所有待开奖任务（倒计时 未及时处理的）
     * @return
     * @throws ApiException
     */
    List<TaskVo> selectWattingLotteryTasks() throws ApiException;

    /**
     * 获取竞猜详情
     * @param params
     * @return
     * @throws ApiException
     */
    TaskVo selectTaskVo(JSONObject params) throws ApiException;
}
