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
                <label for="loginName" class="col-sm-2 control-label">客服账号</label>
                <div class="col-sm-2" >
                    <input type="text" name="loginName" id="loginName" class="form-control">
                </div>
                 <label for="qq" class="col-sm-2 control-label">客服QQ</label>
                <div class="col-sm-2" >
                    <input type="text" name="qq" id="qq" class="form-control">
                </div>
                <%--<label for="agentNumber" class="col-sm-2 control-label">所属代理商</label>--%>
                <%--<div class="col-sm-2" >--%>
                    <%--<input type="text" name="agentNumber" id="agentNumber" class="form-control">--%>
                <%--</div>--%>
             </div>
            <input type="hidden" name="loginbeUserId" id="loginbeUserId" value="<shiro:principal property="limitBeUserId"/>">
            <%--<input type="hidden" name="loginagentId" id="loginagentId" value="<shiro:principal property="limitAgentId"/>">--%>
         </form>
        <div class="pull-right" style="margin-top: 5px;">
            <div class="btn-group">
                 <shiro:hasPermission name="23search">
                    <button type="button" class="btn btn-primary btn-sm" id="btn-query">
                        查询
                    </button>
                     <button type="button" class="btn btn-primary btn-sm" id="btn-re">
                         刷新
                    </button>
                </shiro:hasPermission>
             </div>
            <shiro:hasPermission name="23add">
                <button type="button" class="btn btn-primary btn-sm toadd" >
                    新增客服
                </button>
            </shiro:hasPermission>
        </div>
    </div>

    <!--表格-->
    <table id="dataTable" class="table table-striped table-bordered table-hover table-condensed" align="center">
        <thead>
        <tr class="info">
            <th style="width: 10%;">客服账号</th>
            <th style="width: 10%;">客服昵称</th>
            <th style="width: 20%;">客服qq</th>
            <%--<th style="width: 10%;">所属代理商</th>--%>
            <th style="width: 10%;">操作</th>
         </tr>
        </thead>
        <tbody></tbody>
    </table>
</div>





<div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="width:30%;">
        <div class="modal-content" style=" width: 100%; ">
            <div class="modal-header" style=" width: 100%; ">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">&times;</span>
                    <span class="sr-only"></span>
                </button>
                <h4 class="modal-title" id="myModalLabel">修改客服</h4>
            </div>

            <div class="modal-body" style=" width: 100%; ">
                <form role="form" class="form-horizontal" id="detailForm" style=" width: 100%; ">
                     <input type="hidden"  class="userId" value="">
                    <div class="form-group" >
                        <label class="col-sm-3 control-label" >客服账号</label>
                        <div class="col-sm-6">
                            <input type="text" name="loginName"  class="form-control updateloginName" readonly="readonly">
                        </div>
                    </div>
                     <div class="form-group" >
                        <label class="col-sm-3 control-label" >昵称</label>
                        <div class="col-sm-6">
                            <input type="text" name="nickName"  class="form-control updatenickName">
                        </div>
                    </div>
                    <div class="form-group" >
                        <label class="col-sm-3 control-label" >QQ</label>
                        <div class="col-sm-6">
                            <input type="text" name="qq"  class="form-control updateqq" onkeyup="value=value.replace(/[^\0-9]/g,'')">
                        </div>
                    </div>
                    <%--<div class="form-group"  >--%>
                        <%--<label class="col-sm-3 control-label"   >所属代理商</label>--%>
                        <%--<div class="col-sm-6">--%>
                            <%--<select  name="agentId" class="form-control updateagentId" >--%>

                            <%--</select>--%>
                        <%--</div>--%>
                    <%--</div>--%>
                 </form>

                <div class="text-center" style="margin-top: 50px">
                    <shiro:hasPermission name="23update">
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




<div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="width:50%;">
        <div class="modal-content" style=" width: 100%; ">
            <div class="modal-header" style=" width: 100%; ">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">&times;</span>
                    <span class="sr-only"></span>
                </button>
                <h4 class="modal-title">新增客服</h4>
            </div>

            <div class="modal-body" style=" width: 100%; ">
                <form role="form" class="form-horizontal" id="addForm" style=" width: 100%; ">
                    <div class="form-group" >
                        <label class="col-sm-3 control-label" >客服账号</label>
                        <div class="col-sm-6">
                            <input type="text" name="loginName"  class="form-control addloginName">
                        </div>
                    </div>
                    <div class="form-group" >
                        <label class="col-sm-3 control-label" >密码</label>
                        <div class="col-sm-6">
                            <input type="text" name="passWord"  class="form-control addpassWord">
                        </div>
                    </div>
                    <div class="form-group" >
                        <label class="col-sm-3 control-label" >昵称</label>
                        <div class="col-sm-6">
                            <input type="text" name="nickName"  class="form-control addnickName">
                        </div>
                    </div>
                    <div class="form-group" >
                        <label class="col-sm-3 control-label" >QQ</label>
                        <div class="col-sm-6">
                            <input type="text" name="qq"  class="form-control addqq" onkeyup="value=value.replace(/[^\0-9\a-z\A-Z]/g,'')">
                        </div>
                    </div>
                    <%--<div class="form-group"   >--%>
                        <%--<label class="col-sm-3 control-label" >所属代理商</label>--%>
                        <%--<div class="col-sm-6">--%>
                            <%--<select  name="agentId" class="form-control addagentId" >--%>

                            <%--</select>--%>
                        <%--</div>--%>
                    <%--</div>--%>
                </form>

                <div class="text-center" style="margin-top: 50px">
                    <shiro:hasPermission name="23add">
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



</body>
</html>
<%@ include file="../../../currency/js.jsp"%>
<script>
    $(function () {

//         //代理商列表
//        if(true) {
//            $.ajax({
//                type: "POST",
//                url: agdress.CONSTS.URL_BASE_API+"ss_agent/getAgentList",
//                data: {},
//                async: false,
//                success: function (data) {
//                    var agentList=data.data;
//                    for(var i=0 ; i <agentList.length ;i++){
//                         $(".addagentId").append("<option value='"+agentList[i].agentId+"'>"+agentList[i].loginName+"</option>");
//                         $(".updateagentId").append("<option value='"+agentList[i].agentId+"'>"+agentList[i].loginName+"</option>");
//                    }
//                }
//            });
//        }

        //添加、修改异步提交地址
        var str = "";
        <shiro:hasPermission name="23update">
        str+= "<div class='btn-group'>" +
            "<button  class='btn btn-primary btn-sm toupdate'  id='btn-query'  type='button'>修改</button>" +
            "</div>"
        </shiro:hasPermission>

        var tables = $("#dataTable").dataTable(
            //URL
            agdress.getDatatableSettings('ss_user/ywdataGrid',
                //查询条件
                'queryForm',
                //对应上面thead里面的序列
                [
                    {"data": "loginName"},
                    {"data": "nickName"},
                    {"data": "qq"},
//                    {"data": 'agentNumber'},
                    {"data": 'columnDefs'}
                ],
                //行操作按钮定义
                [
                    {
                        targets: -1,
                        defaultContent: str
                    }
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

         //新增
        $("#okAdd").on("click", function () {
            if($(".addloginName").val() == ""){
                layer.msg("客服账号不能为空！", {icon: 2}); return;
            }
            if(!loginNameIsHave($(".addloginName").val())){
                layer.msg("客服账号已存在，请更换账号！", {icon: 2});return;
            }
            if($(".addpassWord").val() == ""){
                layer.msg("密码不能为空！", {icon: 2});return;
            }
            if($(".addnickName").val() == ""){
                layer.msg("客服昵称不能为空！", {icon: 2});return;
            }
            if($(".addqq").val() == ""){
                layer.msg("客服qq不能为空！", {icon: 2});return;
            }
             $.ajax({
                type: "POST",
                url: agdress.CONSTS.URL_BASE_API+"ss_user/addUserForXt",
                data: {
                    "roleId":"3",
                    "loginName":$(".addloginName").val(),
                    "passWord":$(".addpassWord").val(),
                    "nickName":$(".addnickName").val(),
                    "qq":$(".addqq").val()
//                    ,"agentId":$(".addagentId").val()
                },
                async: false,
                success: function (data) {
                    if (data.data == true) {
                        layer.msg('新增成功！');
                        $("#okAdd").hide();
                    } else {
                        layer.msg("操作失败！", {icon: 2});
                    }
                }
            });
        });


        //修改
        $("#dataTable tbody").on("click", ".toupdate", function () {
            var data = tables.api().row($(this).parents("tr")).data();
            $(".updateloginName").val(data.loginName);
            $(".updatenickName").val(data.nickName);
            $(".updateqq").val(data.qq);
//            $(".updateagentId").find("option").each(function(n,obj){
//                if($(obj).html() == data.loginName){
//                    $(".updateagentId").val($(obj).val());
//                }
//            });
            $(".userId").val(data.userId);
            $("#editModal").modal("show");
        });


        $("#okUpdate").on("click", function () {
            if($(".updatenickName").val() == ""){
                layer.msg("昵称不能为空！", {icon: 2});return;
             }
            if($(".updateqq").val() == ""){
                layer.msg("qq不能为空！", {icon: 2});return;
            }
            $.ajax({
                type: "POST",
                url: agdress.CONSTS.URL_BASE_API+"ss_user/updateUserForXt",
                data: {
                    "userId":$(".userId").val(),
                    "nickName":$(".updatenickName").val(),
                    "qq":$(".updateqq").val()
//                    ,"agentId":$(".updateagentId").val()
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


     });
</script>
