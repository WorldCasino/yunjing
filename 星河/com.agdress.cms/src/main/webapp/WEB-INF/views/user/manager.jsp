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
            <input type="hidden" name="loginbeUserId" id="loginbeUserId" value="<shiro:principal property="limitBeUserId"/>">
            <input type="hidden" name="loginagentId" id="loginagentId" value="<shiro:principal property="limitAgentId"/>">
            <div class="form-group">
                <label for="bgLoginId" class="col-sm-2 control-label">用户ID</label>
                <div class="col-sm-2" >
                    <input type="text" name="bgLoginId" id="bgLoginId" class="form-control">
                </div>
                <label for="date2" class="col-sm-2 control-label">最近登录时间</label>
                <div class="col-sm-2" >
                    <input type="text" name="date2" id="date2" class="form-control" style="width: 120%;">
                    <input type="text" id = "loginStartTime" name="loginStartTime" class="form-control" style="display: none"/>
                    <input type="text" id = "loginEndTime" name="loginEndTime" class="form-control" style="display: none;"/>
                </div>
                <label for="agentNumber" class="col-sm-2 control-label">所属代理商</label>
                <div class="col-sm-2" >
                    <select name="agentNumber" id="agentNumber" class="form-control agentNumber">

                    </select>
                </div>
             </div>
            <div class="form-group">
                <label for="phone" class="col-sm-2 control-label">手机号</label>
                <div class="col-sm-2" >
                    <input type="text" name="phone" id="phone" class="form-control">
                </div>
                <label for="date1" class="col-sm-2 control-label">注册时间</label>
                <div class="col-sm-2" >
                    <input type="text" name="date1" id="date1" class="form-control" style="width: 120%;">
                    <input type="text" id = "registerStartTime" name="registerStartTime" class="form-control" style="display: none"/>
                    <input type="text" id = "registerEndTime" name="registerEndTime" class="form-control" style="display: none;"/>
                </div>
                <label for="beUserNumber" class="col-sm-2 control-label">所属客服</label>
                <div class="col-sm-2" >
                    <input type="text" name="beUserNumber" id="beUserNumber" class="form-control">
                </div>
              </div>
         </form>
        <div class="pull-right" style="margin-top: 5px;">
             <div class="btn-group">
                <shiro:hasPermission name="20search">
                    <button type="button" class="btn btn-primary btn-sm" id="btn-query">
                        <i class="fa fa-search"></i> 查询
                    </button>
                    <button type="button" class="btn btn-primary btn-sm" id="btn-re">
                        <i class="fa fa-refresh"></i> 刷新
                    </button>
                </shiro:hasPermission>
            </div>
        </div>
    </div>

    <!--表格-->
    <table id="dataTable" class="table table-striped table-bordered table-hover table-condensed" align="center">
        <thead>
            <tr class="info">
                <th style="width: 10%;">用户ID</th>
                <th style="width: 10%;">昵称</th>
                <th style="width: 10%;">手机号码</th>
                <th style="width: 10%;">代理商</th>
                <th style="width: 10%;">银行卡</th>
                <th style="width: 10%;">账户余额</th>
                <th style="width: 10%;">客服账号</th>
                <th style="width: 10%;">注册时间</th>
                <th style="width: 10%;">上线时间</th>
                <th style="width: 10%;">操作</th>
            </tr>
        </thead>
        <tbody></tbody>
    </table>
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
        <shiro:hasPermission  name="20detail">
        str+= "<div class='btn-group' style='margin-right: 5px;'>" +
            "<button  class='btn btn-primary btn-sm todetail'  id='btn-query'  type='button'> 详情</button>" +
            "</div>"
        </shiro:hasPermission>


        var tables = $("#dataTable").dataTable(
            //URL
            agdress.getDatatableSettings('ss_user/dataGrid',
                //查询条件
                'queryForm',
                //对应上面thead里面的序列
                [
                    {"data": "bgLoginId"},
                    {"data": "nickName"},
                    {"data": 'phone'},
                    {
                        "data": 'agentNumber',
                        "render": function (data, type, full, callback) {
                            return data //+"("+full.agentName+")"
                        }
                    },
                    {
                        "data": 'cardNumber',
                        "render": function (data, type, full, callback) {
                            return (parseInt(data) > 0)?"已绑定":"未绑定"
                           }
                    },
                    {"data": 'balance'},
                    {
                        "data": 'beUserNumber',
                        "render": function (data, type, full, callback) {
                            return data+"("+full.beUserName+")"
                        }
                    },
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


        //查看
        $("#dataTable tbody").on("click", ".todetail", function () {
            var data = tables.api().row($(this).parents("tr")).data();
             var url = 'ss_user/detailuser?userId='+data.userId;
            var id = "user_"+data.userId;
            var title = "玩家详情【"+data.nickName+"】";
            window.parent.openNewTab(id,title,url);
            return;
        });


        //代理商列表
        if(true) {
            $.ajax({
                type: "POST",
                url: agdress.CONSTS.URL_BASE_API+"ss_agent/getAgentList",
                data: {},
                async: false,
                success: function (data) {
                    var agentList=data.data;
                    $(".agentNumber").append("<option value=''>全部</option>");
                    for(var i=0 ; i <agentList.length ;i++){
                        $(".agentNumber").append("<option value='"+agentList[i].loginName+"'>"+agentList[i].loginName+"</option>");
                    }
                }
            });
        }



     });



</script>
