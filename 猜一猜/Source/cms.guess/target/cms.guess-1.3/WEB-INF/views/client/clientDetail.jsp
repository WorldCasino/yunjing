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
                    <div id="layer-photos">
                        <img class="user-image" name="headUrl" style="width: 80px;height: 80px;"
                             src="https://image.caiecai.net/headers/header.png"
                             layer-src="https://image.caiecai.net/headers/header.png" src=="https://image.caiecai.net/headers/header.png" alt="头像"/>
                    </div>
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

    <%--给TA充值--%>
    <div class="modal fade" id="systemGift" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">

                <div class="modal-header" >
                    <button type="button" class="close" data-dismiss="modal">
                        <span aria-hidden="true">&times;</span>
                        <span class="sr-only"></span>
                    </button>
                    <h4 class="modal-title" id="myModalLabel">给TA充值</h4>
                </div>

                <div class="modal-body">
                    <form class="form-horizontal"  id="editForm" action="" method="post">
                        <input type="hidden" class="form-control" name="userId">
                        <div class="form-group">
                            <label for="txtCoins" class="col-sm-3 control-label">赠送金币</label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" name="coins" id="txtCoins">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="txtRemark" class="col-sm-3 control-label">赠送原因</label>
                            <div class="col-sm-9">
                                <textarea class="form-control" name="remark" id="txtRemark"></textarea>
                            </div>
                        </div>

                        <div class="modal-footer">
                            <button type="submit" id="btn-submit" class="btn btn-primary">确认</button>
                        </div>
                    </form>
                </div>
                <!-- modal-body END -->
            </div>
        </div>
    </div>
</body>
</html>
<script src="<%=request.getContextPath()%>/plugins/jQuery/jquery-2.2.3.min.js"></script>
<script src="<%=request.getContextPath()%>/bootstrap/js/bootstrap.js"></script>
<script src="<%=request.getContextPath()%>/bootstrap/js/bootstrapValidator.js"></script>
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
    var id = cicada.getQueryString("userid");
    window.userId = id;

    $(function () {
        cicada.CONSTS.URL_BAES = "<%=SystemConfig.getInstance().getURL_BASE()%>";
        cicada.CONSTS.URL_BASE_API = "<%=SystemConfig.getInstance().getURL_BASE_API()%>";
        cicada.CONSTS.URL_BASE_IMG = "<%=SystemConfig.getInstance().getURL_BASE_IMG()%>";
        cicada.CONSTS.URL_BASE_IMG_TASK = "<%=SystemConfig.getInstance().getURL_BASE_IMG_TASK()%>";

        if(cicada.isNullOrEmpty(id)) return;
        loadForm();

        //加载页面数据
        function loadForm() {

            //获取玩家详情
            cicada.post('client/detail',JSON.stringify({userId:id}),function (result) {
                console.log(result);
                bindFormData(result);
                //TODO
            },function (err) {
                layer.msg('玩家详情获取失败！'+ err.message, {icon: 2});
            },"application/json");
        }

        //页面数据绑定
        function bindFormData(data) {
            $("img[name='headUrl']").attr("src", data.headUrl);
            $("img[name='headUrl']").attr("layer-src", data.headUrl);
            $("img[name='headUrl']").attr("alt", data.nickname);

            layer.photos({
                photos:'#layer-photos'
                ,anim: 5
            });

            $("input[name=gender][value="+data.gender.code+"]").attr("checked",true);
            $("input[name=nickname]").val(data.nickname);
            $("input[name=phonenumber]").val(data.phonenumber);
            $("input[name=lastTime]").val(new Date(data.lastTime).formatYMD());
            $("input[name=bindWx]").val(cicada.isNullOrEmpty(data.wxOpenId)?"未绑定":"已绑定");
            $("input[name=balance]").val(data.accountVo.coinBalance);
            $("input[name=taskCount]").val(data.accountVo.taskCount);
            $("input[name=incomeExpend]").val((parseFloat(data.accountVo.coinIncome)-parseFloat(data.accountVo.coinExpend)).toFixed(1));
            $("input[name=joinCount]").val(data.accountVo.taskJoin);
        };

        //表单验证
        $("#editForm").bootstrapValidator({
            message: 'This value is not valid',
            feedbackIcons: {/*输入框不同状态，显示图片的样式*/
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {/*验证*/
                remark: {/*键名task_content和input name值对应*/
                    validators: {
                        notEmpty: {/*非空提示*/
                            message: '请输入赠送原因！'
                        },
                        stringLength: {/*长度提示*/
                            min: 5,
                            max: 100,
                            message: '请输入5到50个汉字！'
                        }
                    }
                },
                coins: {
                    validators: {
                        notEmpty: {/*非空提示*/
                            message: '请输入赠送金币！'
                        },
                        regexp: {
                            regexp: /^[0-9]*$/,
                            message: '只能是数值格式！'
                        }
                    }
                }
            }
        }).on('success.form.bv', function(e) {//点击提交之后
            // Prevent form submission
            e.preventDefault();

            // Get the form instance
            var $form = $(e.target);

            // Get the BootstrapValidator instance
             var bv = $form.data('bootstrapValidator');

            // Use Ajax to submit form data 提交至form标签中的action，result自定义
            layer.confirm('确定给TA充值吗？', {
                btn: ['确定','取消'] //按钮
            }, function(index) {
                var formData = cicada.serializeJson("editForm");
                cicada.post('trade/system/give',JSON.stringify(formData), function (result) {
                    layer.msg('充值成功！');
                    loadForm();
                },function (err) {

                    layer.msg('充值失败！'+ err.message, {icon: 2});
                },"application/json");

                layer.close(index);
            }, function(index){
                layer.close(index);
            });
        });

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
            var url = 'client/lottery/list?userid='+window.userId;
            var id = "clientTrade_"+window.userId;
            var title = "盈亏明细【" + $("input[name=nickname]").val() +"】";
            window.parent.openNewTab(id,title,url);
            return;
        });

        //发布竞猜明细
        $("#btnPublishList").on("click", function () {
            var url = 'client/task/list?userid='+window.userId+'&lookType=1';
            var id = "clientTrade_"+window.userId;
            var title = "发布竞猜明细【" + $("input[name=nickname]").val() +"】";
            window.parent.openNewTab(id,title,url);
            return;
        });

        //参与竞猜明细
        $("#btnJoinList").on("click", function () {
            var url = 'client/task/list?userid='+window.userId+'&lookType=2';
            var id = "clientTask_"+window.userId;
            var title = "参与竞猜明细【" + $("input[name=nickname]").val() +"】";
            window.parent.openNewTab(id,title,url);
            return;
        });

        //给TA充值
        $("#btnRecharge").on("click", function () {
            $("input[name='userId']").val(window.userId);
            $("#systemGift").modal("show");
        });
    });
</script>

