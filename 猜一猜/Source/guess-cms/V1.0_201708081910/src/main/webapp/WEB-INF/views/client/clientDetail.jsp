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
    <title>玩家详情</title>
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
    <!-- Main content -->
    <section class="content">
        <form role="form" class="form-horizontal" id="upForm">

            <div class="form-group">
                <label class="col-sm-2 control-label">头像</label>
                <div class="col-sm-3">
                    <img class="user-image" name="headUrl" style="width: 80px;height: 80px;" src="https://image.caiecai.net/headers/header.png"/>
                </div>
                <label class="col-sm-2 control-label">性别</label>
                <div class="col-sm-3">
                    <div class="radio col-sm-4">
                        <input type="radio" name="gender" value="0"> 先生
                    </div>
                    <div class="radio col-sm-4">
                        <input type="radio" name="gender" value="1"> 女士
                    </div>
                    <div class="radio col-sm-4">
                        <input type="radio" name="gender" value="-1" checked> 未知
                    </div>
                </div>
            </div>
            <%--<div class="form-group">--%>
                <%--<label class="col-sm-2 control-label">性别</label>--%>
                <%--<div class="col-sm-10">--%>
                <%--</div>--%>
            <%--</div>--%>
            <div class="form-group">
                <label class="col-sm-2 control-label">昵称</label>

                <div class="col-sm-3">
                    <input type="text" class="form-control" name="nickname" disabled>
                </div>
                <label class="col-sm-2 control-label">手机号</label>
                <div class="col-sm-3">
                    <input type="text" class="form-control" name="phonenumber" disabled>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">微信</label>
                <div class="col-sm-3">
                    <input type="text" class="form-control" name="bindWx" disabled>
                </div>
                <label class="col-sm-2 control-label">最近登录</label>
                <div class="col-sm-3">
                    <input type="text" class="form-control" name="lastTime" disabled>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label" >账户余额</label>
                <div class="col-sm-3">
                    <div class="input-group">
                        <input type="text" class="form-control" disabled name="balance">
                        <span class="input-group-btn">
                            <button class="btn btn-default" type="button" id="btnRechargeList">充值兑换明细</button>
                        </span>
                    </div>
                </div>
                <label class="col-sm-2 control-label" >累计盈亏</label>
                <div class="col-sm-3">
                    <div class="input-group">
                        <input type="text" class="form-control" disabled name="incomeExpend">
                        <span class="input-group-btn">
                            <button class="btn btn-default" type="button" id="btnIncomeList">盈亏明细</button>
                        </span>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label" >发布数量</label>
                <div class="col-sm-3">
                    <div class="input-group">
                        <input type="text" class="form-control" disabled name="taskCount">
                        <span class="input-group-btn">
                            <button class="btn btn-default" type="button" id="btnPublishList">查看明细</button>
                        </span>
                    </div>
                </div>
                <label class="col-sm-2 control-label" >参与数量</label>
                <div class="col-sm-3">
                    <div class="input-group">
                        <input type="text" class="form-control" disabled name="joinCount">
                        <span class="input-group-btn">
                            <button class="btn btn-default" type="button" id="btnJoinList">查看明细</button>
                        </span>
                    </div>
                </div>
            </div>
        </form>

        <div class="text-center" style="margin-top: 50px">
            <button type="button" class="btn btn-primary btn-lg" id="btnRecharge">
                <i class="fa fa-plus"></i> 给TA充值
            </button>
            <button type="button" class="btn btn-default btn-lg" id="btnClose">
                <i class="fa fa-close"></i> 返回列表
            </button>
        </div>
    </section>
    <!-- /.content -->
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
<script src="<%=request.getContextPath()%>/resources/js/cicada.main.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/DateUtility.js"></script>
<script>
    var id = cicada.getQueryString("userid");
    window.userId = id;

    $(function () {
        cicada.CONSTS.URL_BAES = "<%=SystemConfig.getInstance().getURL_BASE()%>";
        cicada.CONSTS.URL_BASE_API = "<%=SystemConfig.getInstance().getURL_BASE_API()%>";
        cicada.CONSTS.URL_BASE_IMG = "<%=SystemConfig.getInstance().getURL_BASE_IMG()%>";
        cicada.CONSTS.URL_BASE_IMG_TASK = "<%=SystemConfig.getInstance().getURL_BASE_IMG_TASK()%>";

        if(cicada.isNullOrEmpty(id)) return;

        //获取玩家详情
        cicada.post('client/detail',JSON.stringify({userId:id}),function (result) {
            console.log(result);
            bindFormData(result);
            //TODO
        },function (err) {
            layer.msg('玩家详情获取失败！'+ err.message, {icon: 2});
        },"application/json");

        //页面数据绑定
        function bindFormData(data) {
            $("img[name='headUrl']")[0].src = data.headUrl;
            $("input[name=gender][value="+data.gender.code+"]").attr("checked",true);
            $("input[name=nickname]").val(data.nickname);
            $("input[name=phonenumber]").val(data.phonenumber);
            $("input[name=lastTime]").val(new Date(data.lastTime).formatYMD());
            $("input[name=bindWx]").val(cicada.isNullOrEmpty(data.wxOpenId)?"未绑定":"已绑定");
            $("input[name=balance]").val(data.accountVo.coinBalance);
            $("input[name=taskCount]").val(data.accountVo.taskCount);
            $("input[name=joinCount]").val(data.accountVo.taskJoin);
        };

        //关闭页面
        $("#btnClose").on('click',function () {
            var id = "user_"+window.userId;
            window.parent.closeMyTab(id);
        });

        //充值兑换明细
        $("#btnRechargeList").on("click", function () {
            var url = 'client/trade/list?userid='+window.userId;
            var id = "clientRecharge_"+window.userId;
            var title = "充值兑换明细【" + $("input[name=nickname]").val() +"】";
            window.parent.openNewTab(id,title,url);
            return;
        });
        //盈亏明细
        $("#btnIncomeList").on("click", function () {
            var url = 'client/trade/list?userid='+window.userId;
            var id = "clientTrade_"+window.userId;
            var title = "盈亏明细【" + $("input[name=nickname]").val() +"】";
            window.parent.openNewTab(id,title,url);
            return;
        });
        //发布竞猜明细
        $("#btnPublishList").on("click", function () {
            var url = 'client/trade/list?userid='+window.userId;
            var id = "clientTrade_"+window.userId;
            var title = "盈亏明细【" + $("input[name=nickname]").val() +"】";
            window.parent.openNewTab(id,title,url);
            return;
        });
        //参与竞猜明细
        $("#btnJoinList").on("click", function () {
            var url = 'client/trade/list?userid='+window.userId;
            var id = "clientTrade_"+window.userId;
            var title = "盈亏明细【" + $("input[name=nickname]").val() +"】";
            window.parent.openNewTab(id,title,url);
            return;
        });
    });
</script>

