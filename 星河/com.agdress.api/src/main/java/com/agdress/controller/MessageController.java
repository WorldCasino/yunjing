package com.agdress.controller;

import com.agdress.commons.utils.ResponseWrapper;
import com.agdress.commons.utils.cmsUtil;
import com.agdress.entity.MessageContentEntity;
import com.agdress.entity.Starship_UserEntity;
import com.agdress.entity.vo.ActivityResultVo;
import com.agdress.entity.vo.MessageContenVo;
import com.agdress.enums.RoleTypeEnum;
import com.agdress.result.DatatablesResult;
import com.agdress.service.IActivityService;
import com.agdress.service.IMessageContentService;
import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/8/22.
 */
@Controller
@RequestMapping("/message")
public class MessageController extends BaseController {


    @Autowired
    private IMessageContentService messageContentService;


    /**
     * 获取未通知消息列表
     * @param userId
     * @return
     * message/listMessage
     */
    @RequestMapping(value = "/listMessage",method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity getMessageList(String userId,String roleId){

        Map<String, String> params=new HashMap<String,String>();
        params.put("roleId",roleId);
        if(Long.parseLong(roleId) == RoleTypeEnum.Salesman.getCode()){
            params.put("userId",userId);
        }
        Map<String,Object> map=messageContentService.getMessageList(params);

        ResponseWrapper result = ResponseWrapper.succeed(map);
        return ResponseEntity.ok(result);
    }


    /**
     * 消息列表记录
     * @param params
     * @return
     * message/dataGrid
     */
    @RequestMapping(value = "/dataGrid", method = RequestMethod.POST)
    public ResponseEntity<DatatablesResult> dataGrid(@RequestBody JSONObject params) {
        int rows = params.getIntValue("length");
        int start = params.getIntValue("start");
        int draw = params.getIntValue("draw");
        int page = (start / rows) + 1;
        try {
            Map<String,String> whereMap = cmsUtil.toHashMap(params);
            DatatablesResult datatablesResult = this.messageContentService.selectMessageListVoPage(whereMap, page, rows,draw );
            return ResponseEntity.ok(datatablesResult);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
    }


    /**
     * 更新状态
     * @param messageContentEntity
     * @return
     * message/updateStatus
     */
    @RequestMapping(value = "/updateStatus",method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity updateStatus(MessageContentEntity messageContentEntity){

        boolean flag=messageContentService.updateById(messageContentEntity);

        ResponseWrapper result = ResponseWrapper.succeed(flag);
        return ResponseEntity.ok(result);
    }

}
