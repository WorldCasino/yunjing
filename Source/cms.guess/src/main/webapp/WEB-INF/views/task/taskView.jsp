<%@ page import="com.cicada.commons.utils.SystemConfig" %><%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/5/24
  Time: 16:55
  To change this template use File | Settings | File Templates.
--%>
<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>竞猜详情</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/dist/css/font-awesome.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/dist/css/ionicons.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/dist/css/AdminLTE.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/dist/css/skins/all-skins.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/plugins/datatables/jquery.dataTables.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/plugins/datatables/dataTables.bootstrap.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/plugins/datepicker/css/bootstrap-datepicker3.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/cicada.main.css">
</head>

<body class="hold-transition skin-blue sidebar-mini">
    <section class="content">
        <h1 style="padding-left: 60px;">图文竞猜</h1>
        <form role="form" class="form-horizontal" id="upForm">
            <div class="form-group">
                <p style="padding-left: 80px;" id="content">猜一猜</p>
            </div>
            <div class="form-group">
                <div class="form-group" id="layer-photos">
                    <div class="col-sm-2 col-md-offset-1">
                        <img class="user-image" name="image" id="image0" style="width: 100px;height: 100px;display:none"/>
                    </div>
                    <div class="col-sm-2">
                        <img class="user-image" name="image" id="image1" style="width: 100px;height: 100px;display:none"/>
                    </div>
                    <div class="col-sm-2">
                        <img class="user-image" name="image" id="image2" style="width: 100px;height: 100px;display:none"/>
                    </div>
                    <div class="col-sm-2">
                        <img class="user-image" name="image" id="image3" style="width: 100px;height: 100px;display:none" />
                    </div>
                </div>
            </div>
            <div class="form-group">
                <div class="form-group">
                    <label class="col-sm-1 control-label" >答案A</label>
                    <div class="col-sm-1">
                        <input type="text" class="form-control" name="answerA" disabled VALUE="">
                    </div>
                    <label class="col-sm-1 control-label">答案B</label>
                    <div class="col-sm-1">
                        <input type="text" class="form-control" name="answerB" disabled VALUE="">
                    </div>
                    <label class="col-sm-1 control-label">答案C</label>
                    <div class="col-sm-1">
                        <input type="text" class="form-control" name="answerC" disabled VALUE="">
                    </div>
                    <label class="col-sm-1 control-label">单注奖额</label>
                    <div class="col-sm-1">
                        <input type="text" class="form-control" name="sale_price" disabled VALUE="">
                    </div>
                    <label class="col-sm-1 control-label">状态</label>
                    <div class="col-sm-1">
                        <input type="text" class="form-control" name="task_status" disabled VALUE="">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-1 control-label">赔率</label>
                    <div class="col-sm-1">
                        <input type="text" class="form-control" name="oddsA" disabled VALUE="">
                    </div>
                    <label class="col-sm-1 control-label">赔率</label>
                    <div class="col-sm-1">
                        <input type="text" class="form-control" name="oddsB" disabled VALUE="">
                    </div>
                    <label class="col-sm-1 control-label">赔率</label>
                    <div class="col-sm-1">
                        <input type="text" class="form-control" name="oddsC" disabled VALUE="">
                    </div>
                    <label class="col-sm-1 control-label">总注数</label>
                    <div class="col-sm-1">
                        <input type="text" class="form-control" name="quantity" disabled VALUE="">
                    </div>
                    <label class="col-sm-1 control-label">正确答案</label>
                    <div class="col-sm-1">
                        <input type="text" class="form-control" name="answer_right" disabled VALUE="">
                    </div>
                </div>

                <div class="form-group">
                    <h2 class="col-sm-2 col-md-offset-1">下注明细</h2>
                </div>
                <div class="form-group">
                    <!--表格-->
                    <div class="col-sm-7 col-md-offset-1">
                        <table id="dataTable" class="table table-striped table-bordered table-hover table-condensed">
                            <thead>
                            <tr class="info">
                                <th style="width: 10%;">玩家</th>
                                <th style="width: 10%;">答案A</th>
                                <th style="width: 10%;">答案B</th>
                                <th style="width: 10%;">答案C</th>
                                <th style="width: 10%;">累计盈亏</th>
                            </tr>
                            </thead>
                            <tbody></tbody>
                        </table>
                    </div>
                </div>

                <div class="form-group">
                    <label class="col-sm-1 control-label">发布者</label>
                    <div class="col-sm-1">
                        <input type="text" class="form-control" name="create_by" disabled VALUE="">
                    </div>
                    <label class="col-sm-1 control-label">累计收入</label>
                    <div class="col-sm-1">
                        <input type="text" class="form-control" name="income_total" disabled VALUE="">
                    </div>
                    <label class="col-sm-1 control-label">累计打赏</label>
                    <div class="col-sm-1">
                        <input type="text" class="form-control" name="reward_total" disabled VALUE="">
                    </div>
                    <label class="col-sm-1 control-label">累计盈亏</label>
                    <div class="col-sm-1">
                        <input type="text" class="form-control" name="profit_and_loss_total" disabled VALUE="">
                    </div>
                </div>
            </div>
        </form>

        <div class="col-md-offset-1" style="margin-top: 50px">
            <button type="button" class="btn btn-primary btn-lg col-md-offset-1" id="btn-lock">
                <i class="fa fa-plus"></i> 锁定
            </button>
            <button type="button" class="btn btn-default btn-lg col-md-offset-1" id="btn-lottery">
                <i class="fa fa-close"></i> 开奖
            </button>
            <button type="button" class="btn btn-default btn-lg col-md-offset-1" id="btn-close">
                <i class="fa fa-close"></i> 返回
            </button>
        </div>
    </section>
</body>
</html>
<script src="<%=request.getContextPath()%>/plugins/jQuery/jquery-2.2.3.min.js"></script>
<script src="<%=request.getContextPath()%>/bootstrap/js/bootstrap.js"></script>
<script src="<%=request.getContextPath()%>/plugins/datatables/dataTables.bootstrap.js"></script>
<script src="<%=request.getContextPath()%>/plugins/datatables/jquery.dataTables.js"></script>
<script src="<%=request.getContextPath()%>/plugins/slimScroll/jquery.slimscroll.min.js"></script>
<script src="<%=request.getContextPath()%>/plugins/fastclick/fastclick.js"></script>
<script src="<%=request.getContextPath()%>/dist/js/app.min.js"></script>
<script src="<%=request.getContextPath()%>/plugins/datatables/dataTables.bootstrap.js"></script>
<script src="<%=request.getContextPath()%>/plugins/datepicker/js/bootstrap-datepicker.js"></script>
<script src="<%=request.getContextPath()%>/plugins/datepicker/locales/bootstrap-datepicker.zh-CN.min.js"></script>
<script src="<%=request.getContextPath()%>/layer/2.1/layer.js"></script>
<script src="<%=request.getContextPath()%>/layer/2.1/extend/layer.ext.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/cicada.main.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/DateUtility.js"></script>
<script>
    var id = cicada.getQueryString("taskId");
    window.taskId = id;
    var taskData;

    $(function () {
        cicada.CONSTS.URL_BAES = "<%=SystemConfig.getInstance().getURL_BASE()%>";
        cicada.CONSTS.URL_BASE_API = "<%=SystemConfig.getInstance().getURL_BASE_API()%>";
        cicada.CONSTS.URL_BASE_IMG = "<%=SystemConfig.getInstance().getURL_BASE_IMG()%>";
        cicada.CONSTS.URL_BASE_IMG_TASK = "<%=SystemConfig.getInstance().getURL_BASE_IMG_TASK()%>";

        if(cicada.isNullOrEmpty(id)) return;

        //获取竞猜详情
        cicada.post('task/detail',JSON.stringify({taskId:id}),function (result) {
            console.log(result);
            bindFormData(result);
            //TODO
        },function (err) {
            layer.msg('竞猜详情获取失败！'+ err.responseText, {icon: 2});
        },"application/json");

        //页面数据绑定
        function bindFormData(data) {
            taskData=data;
            $("h1").text(data.taskType.desc);
            $("#content").text(unescape(data.taskContent));

            var pictures = data.picturesVoList;
            var imgs = document.getElementsByName("image");
            if(data.taskType.code===0 || data.taskType.code===3) {
                for (var i = 0; i < pictures.length; i++) {
                    imgs[i].src = pictures[i].picUrl;
                    $("#image" + i).show();
                }
                layer.photos({
                    photos:'#layer-photos'
                    ,anim: 5
                });
            }

            if (data.answerVoList[0] != null || typeof data.answerVoList[2] != 'undefined') {
                $("input[name=answerA]").val(data.answerVoList[0].answer);
                $("input[name=oddsA]").val(data.answerVoList[0].odds);
            }
            if (data.answerVoList[1] != null || typeof data.answerVoList[2] != 'undefined') {
                $("input[name=answerB]").val(data.answerVoList[1].answer);
                $("input[name=oddsB]").val(data.answerVoList[1].odds);
            }
            if (data.answerVoList[2] != null || typeof data.answerVoList[2] != 'undefined') {
                $("input[name=answerC]").val(data.answerVoList[2].answer);
                $("input[name=oddsC]").val(data.answerVoList[2].odds);
            }
            $("input[name=sale_price]").val(data.salePrice);
            $("input[name=task_status]").val(data.taskStatus.desc);
            $("input[name=quantity]").val(data.quantity);
            data.answerVoList.forEach(function(e){
                if(e.isRight==1){
                    $("input[name=answer_right]").val(e.answer);
                    return false;//forEach里的break功能
                }else{
                    return;//forEach里的continue功能
                }
            })

            $("input[name=create_by]").val(data.nickName);
            $("input[name=income_total]").val(data.profitTotal);
            $("input[name=reward_total]").val(data.lossTotal);
            $("input[name=profit_and_loss_total]").val(data.profitTotal-data.lossTotal);

            var answers=data.answerVoList;
            answers[0].type='A';
            answers[1].type='B';
            if (answers[2]!= null || typeof answers[2]!= 'undefined') {
                answers[2].type='C';
            }

            var orders=data.orderVoList;

            if(orders!= null || typeof orders!= 'undefined'){
                var tables = $("#dataTable").dataTable({
                    data:orders,
                    columns: [//对应上面thead里面的序列
                        {
                            "data": "userName",
                            "render":function (orders,type,rowData,callback) {
                                //return cicada.ENUMS.TASK_TYPE.getName(data);
                                return rowData.userName;
                            }
                        },
                        {
                            "data": "answerA",
                            "render":function (orders,type,rowData,callback) {
                                //return cicada.ENUMS.TASK_TYPE.getName(data);
//                            return rowData.answerVoList[0].answer+':'+rowData.answerVoList[0].quantity;
                                var result=0;
                                rowData.answerVoList.forEach(function(e){
                                    if(e.answerId==answers[0].answerId){
                                        result=e.quantity;
                                    }else{
                                        return;//forEach里的continue功能
                                    }
                                    return
                                })
                                return result;
                            }
                        }
                        ,
                        {
                            "data": "answerB",
                            "render":function (orders,type,rowData,callback) {
                                //return cicada.ENUMS.TASK_TYPE.getName(data);
//                            if (rowData.answerVoList[1] != null || typeof rowData.answerVoList[1] != 'undefined') {
//                                return rowData.answerVoList[1].answer+':'+rowData.answerVoList[1].quantity;
//                            }
                                var result=0;
                                rowData.answerVoList.forEach(function(e){
                                    if(e.answerId==answers[1].answerId){
                                        result= e.quantity;
                                    }else{
                                        return;//forEach里的continue功能
                                    }
                                    return
                                })
                                return result;
                            }
                        },
                        {
                            "data": "andswerC",
                            "render":function (orders,type,rowData,callback) {
                                //return cicada.ENUMS.TASK_TYPE.getName(data);
//                            if (rowData.answerVoList[2] != null || typeof rowData.answerVoList[2] != 'undefined') {
//                                return rowData.answerVoList[2].answer+':'+rowData.answerVoList[2].quantity;
//                            }
                                var result=0;
                                if(answers[2]!= null || typeof answers[2] != 'undefined'){
                                    rowData.answerVoList.forEach(function(e){
                                        if(e.answerId==answers[2].answerId){
                                            result= e.quantity;
                                        }else{
                                            return;//forEach里的continue功能
                                        }
                                        return
                                    })
                                }
                                return result;
                            }
                        },
                        {
                            "data": "profit_and_loss_usertotal",
                            "render":function (orders,type,rowData,callback) {
                                //return cicada.ENUMS.TASK_TYPE.getName(data);
                                return rowData.profit_and_loss_usertotal;
                            }
                        }
                    ],
                language: {
                    lengthMenu: "",
                    processing: "",
                    paginate: {
                        previous: "<",
                        next: ">",
                        first: "<<",
                        last: ">>"
                    },
                    zeroRecords: "没有记录",
                    info: "",
                    infoEmpty: "",
                    infoFiltered: "",
                    sSearch: "",
                },
                //在每次table被draw完后回调函数
                fnDrawCallback: function () {
                    var api = this.api();
                    //获取到本页开始的条数
                    var startIndex = api.context[0]._iDisplayStart;
                    api.column(1).nodes().each(function (cell, i) {
//                    cell.innerHTML = cicada.CONSTS.TASK_TYPE.getName(i+1);
                    });
                }
                });
            }

            $("input[type=search]").hide();

        };

        //锁定竞猜
        $("#btn-lock").on("click", function () {
            var ids = new Array();
            ids.push(id);
            layer.confirm('<span style="color:red">锁定后将无法下注！<br/>确定要锁定竞猜项目吗？</span>', {
                title:"警告",
                btn: ['锁定','取消'] //按钮
            }, function(index){
                var data = {taskIds:ids};
                cicada.post('task/lock',JSON.stringify(data),function (result) {
                    layer.msg('锁定成功！');

                },function (err) {
                    layer.msg('锁定失败！'+ err.message, {icon: 2});
                },"application/json");

                layer.close(index);
            }, function(index){
                layer.close(index);
            });
        });

//开奖
        $("#btn-lottery").on("click", function () {
            var ids = new Array();
            ids.push(id);
            if(taskData.taskStatus.code != cicada.ENUMS.TASK_STATUS.published){
                layer.msg("竞猜状态【"+cicada.ENUMS.TASK_STATUS.getName(taskData.taskStatus.code)+"】不能开奖！");
                return;
            }

            var content = "<div class='table'><div>" +
                "<label class='control-label col-sm-6'>请选择正确答案：</label>" +
                "<select class='form-control col-sm-6' style='width: 95%;margin-left: 10px;' id='answerId'><option value='0'></option></select>" +
                "</div>" +
                "<div class='pull-right' style='margin-top: 30px;margin-right: 10px;'>" +
                "<button type='button' class='btn btn-danger btn-sm' id='btnCommit'><i class='fa fa-save'></i> 开奖</button>" +
                "<button type='button' class='btn btn-default btn-sm' id='btnCancel'><i class='fa fa-close'></i> 取消</button>" +
                "</div>"+
                "</div>";

            layer.open({
                type: 1,
                area: ['350px', '200px'],
                fix: true,
                maxmin: false,
                shade: 0.4,
                title: '开奖',
                content:content
            });
            for(var i=0;i<taskData.answerVoList.length;i++){
                var ans = taskData.answerVoList[i];
                var op = "<option value='"+ans.answerId+"'>"+ans.answer+"</option>";
                $("#answerId").append(op);
            }

            var saveBtn = $("#btnCommit");
            var answerSelect = $("#answerId");
            var cancelBtn = $("#btnCancel");
            saveBtn.on("click", function () {
                var answerId = answerSelect.val();
                if (cicada.isNullOrEmpty(answerId) || answerId == 0) {
                    layer.msg("请先指定正确答案！",{icon:2});
                } else {
                    cicada.post('task/lottery',JSON.stringify({taskId:taskId,answerId:answerId}),function (result) {
                        layer.msg('开奖成功！');
                    },function (err) {
                        layer.msg('开奖失败！'+ err.message, {icon: 2});
                    },"application/json");

                    layer.closeAll();
                }
            });
            cancelBtn.on("click", function () {
                answerSelect.val(0);
                layer.closeAll();
            });
        });


        //关闭页面
        $("#btn-close").on('click',function () {
            debugger;
            var id = "task_"+window.taskId;
            window.parent.closeMyTab(id);
        });


    });
</script>

