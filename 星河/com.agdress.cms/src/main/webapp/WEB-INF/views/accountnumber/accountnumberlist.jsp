<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html>
<html>
<%@ include file="../../../currency/top.jsp"%>
<body style="overflow: hidden" class="sidebar-mini">
<!-- 查询、添加、批量删除、导出、刷新 -->
<div class="content">
    <!-- 查询、添加、批量删除、导出、刷新 -->
    <div class="row-fluid">
        <form id="queryForm" class="form-horizontal" action="" method="post">
            <div class="form-group">

                <label for="date2" class="col-sm-2 control-label">最近登录时间</label>
                <div class="col-sm-2" >
                    <input type="text" name="date2" id="date2" class="form-control" style="width: 120%;">
                    <input type="text" id = "loginStartTime" name="loginStartTime" class="form-control" style="display: none"/>
                    <input type="text" id = "loginEndTime" name="loginEndTime" class="form-control" style="display: none;"/>
                </div>

                <label for="date1" class="col-sm-2 control-label">注册时间</label>
                <div class="col-sm-2" >
                    <input type="text" name="date1" id="date1" class="form-control" style="width: 120%;">
                    <input type="text" id = "registerStartTime" name="registerStartTime" class="form-control" style="display: none"/>
                    <input type="text" id = "registerEndTime" name="registerEndTime" class="form-control" style="display: none;"/>
                </div>

                <label for="loginName" class="col-sm-2 control-label">账号</label>
                <div class="col-sm-2" >
                    <input type="text" name="loginName" id="loginName" class="form-control">
                </div>
             </div>
            <div class="form-group">
                <label for="roleId" class="col-sm-2 control-label">角色</label>
                <div class="col-sm-2">
                    <select id ="roleId" name="roleId" class="form-control" style="width: 120%;">
                    </select>
                </div>
                <div class="pull-right" style="margin-top: 5px;">
                    <div class="btn-group">
                        <shiro:hasPermission name="13search">
                            <button type="button" class="btn btn-primary btn-sm" id="btn-query">
                                <i class="fa fa-search"></i> 查询
                            </button>
                            <button type="button" class="btn btn-primary btn-sm" id="btn-re">
                                刷新
                            </button>
                        </shiro:hasPermission>
                    </div>
                    <shiro:hasPermission name="13add">
                        <button type="button" class="btn btn-primary btn-sm toadd">
                            注册
                        </button>
                    </shiro:hasPermission>
                </div>
            </div>
         </form>
    </div>

    <!--表格-->
    <table id="dataTable" class="table table-striped table-bordered table-hover table-condensed" align="center">
        <thead>
        <tr class="info">
            <th style="width: 10%;">账号</th>
            <th style="width: 10%;">角色</th>
            <th style="width: 10%;">昵称</th>
            <th style="width: 10%;">手机号</th>
            <th style="width: 10%;">注册时间</th>
            <th style="width: 10%;">最近上线时间</th>
            <th style="width: 10%;">操作</th>
        </tr>
        </thead>
        <tbody></tbody>
    </table>
</div>


<div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="width:30%;">
        <div class="modal-content" style=" width: 100%; ">
            <div class="modal-header" style=" width: 100%; ">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">&times;</span>
                    <span class="sr-only"></span>
                </button>
                <h4 class="modal-title">注册账号</h4>
            </div>

            <div class="modal-body" style=" width: 100%; ">
                <form role="form" class="form-horizontal" id="addForm" style=" width: 100%; ">
                     <div class="form-group" >
                        <label class="col-sm-3 control-label" >账号</label>
                        <div class="col-sm-6">
                            <input type="text" name="loginName"  class="form-control addloginName" onkeyup="value=value.replace(/[^\0-9\a-z\A-Z]/g,'')">
                        </div>
                    </div>
                    <div class="form-group" >
                        <label class="col-sm-3 control-label" >密码</label>
                        <div class="col-sm-6">
                            <input type="text" name="passWord"  class="form-control addpassWord" onkeyup="value=value.replace(/[^\0-9\a-z\A-Z]/g,'')">
                        </div>
                    </div>
                    <div class="form-group" >
                        <label class="col-sm-3 control-label" >手机号</label>
                        <div class="col-sm-6">
                            <input type="text" name="phone"  class="form-control addphone" onkeyup="value=value.replace(/[^\0-9\a-z\A-Z]/g,'')">
                        </div>
                    </div>
                    <div class="form-group" >
                        <label class="col-sm-3 control-label" >昵称</label>
                        <div class="col-sm-6">
                            <input type="text" name="nickName"  class="form-control addnickName" >
                        </div>
                    </div>
                    <div class="form-group"  >
                        <label class="col-sm-3 control-label" >角色</label>
                        <div class="col-sm-6">
                            <select  name="roleId" class="form-control addroleId" >

                            </select>
                        </div>
                    </div>
                </form>

                <div class="text-center" style="margin-top: 50px">
                    <shiro:hasPermission name="13add">
                        <div class="btn-group">
                            <button type="button" class="btn btn-primary btn-lg" id="okAdd">
                                确认新增
                            </button>
                        </div>
                    </shiro:hasPermission>
                    <button type="button" class="btn btn-default btn-lg btnCancel" >
                        返回列表
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>


<div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="width:50%;">
        <div class="modal-content" style=" width: 100%; ">
            <div class="modal-header" style=" width: 100%; ">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">&times;</span>
                    <span class="sr-only"></span>
                </button>
                <h4 class="modal-title" id="myModalLabel">修改账号</h4>
            </div>

            <div class="modal-body" style=" width: 100%; ">
                <form role="form" class="form-horizontal" id="detailForm" style=" width: 100%; ">
                    <input type="hidden"  class="userId" value="">
                      <div class="form-group" >
                        <label class="col-sm-3 control-label" >账号</label>
                        <div class="col-sm-6">
                            <input type="text" name="loginName"  class="form-control updateloginName"  readonly="readonly">
                        </div>
                    </div>
                    <div class="form-group" >
                        <label class="col-sm-3 control-label" >手机号</label>
                        <div class="col-sm-6">
                            <input type="text" name="phone"  class="form-control updatephone" onkeyup="value=value.replace(/[^\0-9]/g,'')">
                        </div>
                    </div>
                    <div class="form-group" >
                        <label class="col-sm-3 control-label" >昵称</label>
                        <div class="col-sm-6">
                            <input type="text" name="nickName"  class="form-control updatenickName" >
                        </div>
                    </div>
                    <div class="form-group"  >
                        <label class="col-sm-3 control-label" >角色</label>
                        <div class="col-sm-6">
                            <select  name="roleId" class="form-control updateroleId" >

                            </select>
                        </div>
                    </div>
                </form>

                <div class="text-center" style="margin-top: 50px">
                    <shiro:hasPermission name="13update">
                        <div class="btn-group">
                            <button type="button" class="btn btn-primary btn-lg" id="okUpdate">
                                确认修改
                            </button>
                        </div>
                    </shiro:hasPermission>
                    <button type="button" class="btn btn-default btn-lg btnCancel"  >
                               返回列表
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

<!--隐藏的退出弹窗点击退出显示-->
<div class="modal fade" id="updateStatus" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"
                        aria-hidden="true">&times;</button>
                <h4 class="modal-title textStatus">确定要启用吗？</h4>
            </div>
            <input type="hidden"  class="userId" value="">
            <input type="hidden"  class="userStatus" value="">
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">我在想想
                </button>
                <button type="button" class="btn btn-primary" id="sureChange">
                    确定
                </button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal -->
</div>
</body>
</html>
<%@ include file="../../../currency/js.jsp"%>
<script>
    $(function () {

        $("input[name='date1']").daterangepicker(agdress.DATE_RANGE_PICKER_OPTIONS,
            function(start, end, label) {
                $("#registerStartTime").val(start.format("YYYY/MM/DD"));
                $("#registerEndTime").val(end.format("YYYY/MM/DD"));
            });
        $("input[name='date2']").daterangepicker(agdress.DATE_RANGE_PICKER_OPTIONS,
            function(start, end, label) {
                $("#loginStartTime").val(start.format("YYYY/MM/DD"));
                $("#loginEndTime").val(end.format("YYYY/MM/DD"));
            });



        //添加、修改异步提交地址
        var str = "";
        <shiro:hasPermission name="13update">
             str+= "<div class='btn-group'>" +
            "<button  class='btn btn-primary btn-sm toupdate'  id='btn-query'  type='button'>修改</button>" +
            "</div>"
        </shiro:hasPermission>




        var tables = $("#dataTable").dataTable(
            //URL
            agdress.getDatatableSettings('ss_user/xtdataGrid',
                //查询条件
                'queryForm',
                //对应上面thead里面的序列
                [
                    {"data": "loginName"},
                    {"data": 'roleName'},
                    {"data": 'nickName'},
                    {"data": 'phone'},
                    {
                        "data": 'createDate',
                        "render": function (data, type, full, callback) {
                            return agdress.timeStamp2String(data)
                        }
                    },
                    {
                        "data": 'updateDate',
                        "render": function (data, type, full, callback) {
                            return agdress.timeStamp2String(data)
                        }
                    },
                    {
                        "data": 'userStatus',
                        "render": function (data, type, full, callback) {
                            var thisstr=str;

                            <shiro:hasPermission name="13status">
                            if(data ==1){
                                thisstr+= "<div class='btn-group' style='margin-left: 20px;'>" +
                                    "<button  class='btn btn-primary btn-sm toupdateStatus'  id='btn-query'  type='button'>启用</button>" +
                                    "</div>"
                            }else if(data ==0){
                                thisstr+= "<div class='btn-group' style='margin-left: 20px;'>" +
                                    "<button  class='btn btn-primary btn-sm toupdateStatus'  id='btn-query'  type='button'>停用</button>" +
                                    "</div>"
                            }
                            </shiro:hasPermission>
                            return thisstr
                        }
                    }
                ],
                //行操作按钮定义
                [

                ],
                // 在每次table被draw完后回调函数
                function () {
                    var api = this.api();
                    //获取到本页开始的条数
                    var startIndex = api.context[0]._iDisplayStart;
                    api.column(1).nodes().each(function (cell, i) {
//                    cell.innerHTML = cicada.CONSTS.TASK_TYPE.getName(i+1);
                    });
                }
            ));


        //查询按钮
        $("#btn-query").on("click", function () {
            tables.fnDraw();//查询后不需要保持分页状态，回首页
        });

        //刷新
        $("#btn-re").on("click", function () {
            tables.fnDraw(false);//刷新保持分页状态
        });

        //取消
        $(".btnCancel").on("click", function () {
             window.location.reload();
        });

        //添加
        $(".toadd").on("click", function () {
            $("#addModal").modal("show");
        });

        //修改
        $("#dataTable tbody").on("click", ".toupdate", function () {
            var data = tables.api().row($(this).parents("tr")).data();
            $(".updateloginName").val(data.loginName);
            $(".updatephone").val(data.phone);
            $(".updatenickName").val(data.nickName);
            $(".updateroleId").find("option").each(function(n,obj){
                 if($(obj).html() == data.roleName){
                     $(".updateroleId").val($(obj).val());
                 }
            });
            $(".userId").val(data.userId);
            $("#editModal").modal("show");
        });

        //新增
        $("#okAdd").on("click", function () {
            if($(".addloginName").val() == ""){
                layer.msg("登录账号不能为空！", {icon: 2});return;
            }
            if(!loginNameIsHave($(".addloginName").val())){
                layer.msg("客服账号已存在，请更换账号！", {icon: 2});return;
            }
            if($(".addpassWord").val() == ""){
                layer.msg("密码不能为空！", {icon: 2});return;
            }
            if($(".addphone").val() == ""){
                layer.msg("手机号不能为空！", {icon: 2});return;
            }
            $.ajax({
                type: "POST",
                url: agdress.CONSTS.URL_BASE_API+"ss_user/addUserForXt",
                data: {
                    "roleId":$(".addroleId").val(),
                    "loginName":$(".addloginName").val(),
                    "passWord":$(".addpassWord").val(),
                     "phone":$(".addphone").val(),
                    "nickName":$(".addnickName").val()
                },
                async: false,
                 success: function (data) {
                    if (data.data == true) {
                        layer.msg('新增成功！');
                         $("#okAdd").hide();
                    } else {
                        layer.msg("操作失败！", {icon: 2});return;
                    }
                }
            });
        });

        //修改
        $("#okUpdate").on("click", function () {
            if($(".updatephone").val() == ""){
                layer.msg("手机号不能为空！", {icon: 2});return;
            }
            $.ajax({
                type: "POST",
                url: agdress.CONSTS.URL_BASE_API+"ss_user/updateUserForXt",
                data: {
                        "userId":$(".userId").val(),
                        "roleId":$(".updateroleId").val(),
                        "loginName":$(".updateloginName").val(),
                        "phone":$(".updatephone").val(),
                        "nickName":$(".updatenickName").val()
                },
                async: false,
                success: function (data) {
                    if (data.data == true) {
                        layer.msg('修改成功！');
                        $("#okUpdate").hide();
                    } else {
                        layer.msg("操作失败！", {icon: 2});
                    }
                }
            });
        });


        //修改状态
        $("#dataTable tbody").on("click", ".toupdateStatus", function () {
            var data = tables.api().row($(this).parents("tr")).data();
            $(".userId").val(data.userId);
            if(data.userStatus == 0){
                $(".userStatus").val("1");
                $(".textStatus").html("确定要停用？");
            }else if(data.userStatus == 1){
                $(".userStatus").val("0");
                $(".textStatus").html("确定要启用？");
            }
            $("#updateStatus").modal("show");
        });
        //修改启用停用状态
        $("#sureChange").on("click", function () {
            $.ajax({
                type: "POST",
                url: agdress.CONSTS.URL_BASE_API+"ss_user/updateUserForStatus",
                data: {
                    "userId":$(".userId").val(),
                    "userStatus":$(".userStatus").val()
                },
                async: false,
                success: function (data) {
                    if (data.data == true) {
                        $(".btnCancel").click();
                    } else {
                        layer.msg("操作失败！", {icon: 2});return;
                    }
                }
            });
        });


        //判断登录账号是否存在
        function  loginNameIsHave(loginName) {
            var flag=true;
            $.ajax({
                type: "POST",
                url: agdress.CONSTS.URL_BASE_API+"ss_user/loginNameIsHave",
                data: {
                    "loginName":loginName
                },
                async: false,
                success: function (data) {
                    flag=data.data;
                }
            });
            return flag;
        }

        if(true) {
            $.ajax({
                type: "POST",
                url: agdress.CONSTS.URL_BASE_API+"ss_role/getRoleList",
                data: {},
                async: false,
                success: function (data) {
                    var roleList=data.data;
                    $(".roleId").empty();
                    $("#roleId").empty();
                    $("#roleId").append("<option value=''>全部</option>");
                    for(var i=0 ; i <roleList.length ;i++){
                        if(roleList[i].roleId != 3 && roleList[i].roleId != 5){
                             $(".addroleId").append("<option value='"+roleList[i].roleId+"'>"+roleList[i].roleName+"</option>");
                         }
                        $(".updateroleId").append("<option value='"+roleList[i].roleId+"'>"+roleList[i].roleName+"</option>");
                        $("#roleId").append("<option value='"+roleList[i].roleId+"'>"+roleList[i].roleName+"</option>");
                    }
                }
            });
        }


     });
</script>