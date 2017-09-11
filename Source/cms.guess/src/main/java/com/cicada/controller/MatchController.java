package com.cicada.controller;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.cicada.commons.Exception.ApiException;
import com.cicada.commons.utils.*;
import com.cicada.enums.ErrorCodeEnum;
import com.cicada.job.Ball.BallUtil;
import com.cicada.job.Ball.BasketballMatchUtil;
import com.cicada.job.Ball.FootBallMatchUtil;
import com.cicada.mapper.TeamMapper;
import com.cicada.pojo.TeamEntity;
import com.cicada.pojo.User;
import com.cicada.result.PicUploadResult;
import com.cicada.service.ITeamService;
import com.cicada.service.impl.TeamServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import sun.security.provider.MD5;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

/**
 * Created by Administrator on 2017/5/16.
 */
@Controller
@RequestMapping("/api/match")
public class MatchController extends BaseController {

    @Autowired
    private JacksonSerializer jacksonSerializer;

    @Autowired
    private ITeamService teamService;

    /**
     * 更新球队缓存
     * @param matchType
     * @return
     * @throws IOException
     * /api/match/changeMatch
     */
    @RequestMapping(value = "/changeMatch",method = RequestMethod.GET)
    @ResponseBody
    public ResponseEntity changeMatch(String matchType) throws IOException{
         ResponseWrapper result;
         try{
             //开始redis存储
             BallUtil.changeRedisBallList("1");
             BallUtil.changeRedisBallList("2");
             result = ResponseWrapper.succeed(true);
         } catch (Exception e){
             e.printStackTrace();
             result = ResponseWrapper.succeed(false);
         }
         return ResponseEntity.ok(result);
    }

    /**
     * 加载球队球队
     * /api/match/addMatch
     */
    @RequestMapping(value = "/addMatch",method = RequestMethod.GET)
    @ResponseBody
    public ResponseEntity addMatch( ) throws IOException{
        ResponseWrapper result;
        try{
            BasketballMatchUtil.setBallList();
            FootBallMatchUtil.setBallList();
            result = ResponseWrapper.succeed(true);
        } catch (Exception e){
            e.printStackTrace();
            result = ResponseWrapper.succeed(false);
        }
        return ResponseEntity.ok(result);
    }

    /**
     *判断球赛是否已经结束
     * /api/match/isMatchOK
     */
    @RequestMapping(value = "/isMatchOK",method = RequestMethod.GET)
    @ResponseBody
    public ResponseEntity isMatchOK( String matchId) throws IOException{
        ResponseWrapper result;
        try{
            BallUtil.MatchBallIsOk(Long.parseLong(matchId));
            result = ResponseWrapper.succeed(true);
        } catch (Exception e){
            e.printStackTrace();
            result = ResponseWrapper.succeed(false);
        }
        return ResponseEntity.ok(result);
    }

    /**
     *  上传照片
     * /api/match/upLoadImages
     */
    @RequestMapping(value = "/upLoadImages",method = RequestMethod.GET)
    @ResponseBody
    public ResponseEntity upLoadImages() throws IOException{
        ResponseWrapper result;
        try{
            TeamEntity teamEntity=null;
            //获取文件夹下的所有文件
            File file = new File("C:\\Users\\wlu\\Desktop\\ball");
            if (file.exists()) {
                File[] files = file.listFiles();
                if (files.length == 0) {
                    System.out.println("文件夹是空的!");
                 } else {
                    for (File file2 : files) {
                        String name=file2.getName().substring(0,file2.getName().length()-4);
                        String hz=file2.getName().substring(file2.getName().length()-4,file2.getName().length());
//                        System.out.println("原始文件名"+name+""+hz);
                        String filename= MD5Util.getMD5Str(name)+hz;
                        System.out.println("加密后文件名:"+filename );
                        //转注入流
                        InputStream is = new FileInputStream(file2);
                        // 图片上传到FTP服务器
                        boolean rtn = FTPClientUtil.uploadImage("team/", filename , is);
                        //上传数据库
                        teamEntity=new TeamEntity();
                        teamEntity.setTeamName(name);
                        EntityWrapper<TeamEntity> wrapper = new EntityWrapper<TeamEntity>(teamEntity);
                        List<TeamEntity> selectList = teamService.selectList(wrapper);
                        if(selectList.size() >0){
                            teamEntity=selectList.get(0);
                            teamEntity.setTeamLogo(filename);
                            teamService.updateById(teamEntity);
                        }else{
                            teamEntity.setTeamLogo(filename);
                            teamService.insert(teamEntity);
                        }
                     }
                }
            } else {
                System.out.println("文件不存在!");
            }
            result = ResponseWrapper.succeed(true);
        } catch (Exception e){
            e.printStackTrace();
            result = ResponseWrapper.succeed(false);
        }
        return ResponseEntity.ok(result);
    }


}
