<%@ page import="com.cicada.commons.utils.SystemConfig" %>
<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>玩家列表</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/dist/css/font-awesome.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/dist/css/ionicons.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/dist/css/AdminLTE.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/dist/css/skins/all-skins.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/plugins/datatables/jquery.dataTables.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/plugins/datatables/dataTables.bootstrap.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/plugins/datepicker/css/bootstrap-datepicker3.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/plugins/daterangepicker/daterangepicker.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/cicada.main.css">
</head>
<body style="overflow: hidden" class="sidebar-mini">
<!-- 查询、添加、批量删除、导出、刷新 -->
<div class="content">
    <!-- 查询、添加、批量删除、导出、刷新 -->
    <div class="row-fluid">
        <form id="queryForm" class="form-horizontal" action="" method="post">
            <div class="form-group">
                <label for="create_date" class="col-sm-1 control-label">注册时间</label>
                <div class="col-sm-2" >
                    <input type="text" name="create_date" id="create_date" class="form-control" style="width: 120%;">
                    <input type="text" id = "createDateStart" name="startTime" class="form-control" style="display: none"/>
                    <input type="text" id = "createDateEnd" name="endTime" class="form-control" style="display: none;"/>
                </div>

                <label for="q_nickname" class="col-sm-1 control-label">玩家昵称</label>
                <div class="col-sm-2">
                    <input type="text" id="q_nickname" name="nickname" class="form-control input-sm"/>
                </div>
                <label for="q_phonenumber" class="col-sm-1 control-label">手机号</label>
                <div class="col-sm-2">
                    <input type="text" id="q_phonenumber" name="phonenumber" class="form-control input-sm"/>
                </div>
                <label for="q_userId" class="col-sm-1 control-label">用户ID</label>
                <div class="col-sm-2">
                    <input type="text" id="q_userId" name="userId" class="form-control input-sm"/>
                </div>
            </div>
        </form>

        <div class="pull-right">
            <button type="button" class="btn btn-primary btn-sm" id="btn-query">
                <i class="fa fa-search"></i> 查询
            </button>
        </div>
    </div>

    <!--表格-->
    <table id="dataTable" class="table table-striped table-bordered table-hover table-condensed" align="center">
        <thead>
        <tr class="info">
            <%--<th style="width: 1%;"></th>--%>
            <th style="width: 10%;">用户ID</th>
            <th style="width: 10%;">头像</th>
            <th style="width: 14%;">昵称</th>
            <th style="width: 7%;">性别</th>
            <th style="width: 7%;">手机号</th>
            <th style="width: 7%;">微信</th>
            <th style="width: 8%;">状态</th>
            <th style="width: 12%;">账户余额</th>
            <th style="width: 12%;">发布数量</th>
            <th style="width: 12%;">注册时间</th>
            <th style="width: 12%;">操作</th>
        </tr>
        </thead>
        <tbody></tbody>
    </table>

</div>

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
<script src="<%=request.getContextPath()%>/plugins/daterangepicker/moment.js"></script>
<script src="<%=request.getContextPath()%>/plugins/daterangepicker/daterangepicker.js"></script>
<script src="<%=request.getContextPath()%>/layer/2.1/layer.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/cicada.main.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/DateUtility.js"></script>
<script>
    $(function () {
        cicada.CONSTS.URL_BAES = "<%=SystemConfig.getInstance().getURL_BASE()%>";
        cicada.CONSTS.URL_BASE_API = "<%=SystemConfig.getInstance().getURL_BASE_API()%>";
        cicada.CONSTS.URL_BASE_IMG = "<%=SystemConfig.getInstance().getURL_BASE_IMG()%>";
        cicada.CONSTS.URL_BASE_IMG_TASK = "<%=SystemConfig.getInstance().getURL_BASE_IMG_TASK()%>";

        $("input[name='create_date']").daterangepicker(cicada.DATE_RANGE_PICKER_OPTIONS,
            function(start, end, label) {
                $("#createDateStart").val(start.format("YYYY/MM/DD"));
                $("#createDateEnd").val(end.format("YYYY/MM/DD"));
            });

        //添加、修改异步提交地址
        var str = "";
        <shiro:hasAnyRoles name = "admin">
        str+= "<div class='btn-group'>" +
            "<button id='editRow' class='btn btn-primary btn-sm' type='button'><i class='fa fa-edit'></i></button>" +
            "<button id='delRow' class='btn btn-primary btn-sm' type='button'><i class='fa fa-trash-o'></i></button>" +
            "</div>"
        </shiro:hasAnyRoles>

        //数据列绑定
        var dataColumns = [
            {
                "data": "userId"
            },
            {
                "data":"headUrl",
                "render":function (data,type,rowData,callback) {
                    var str = "";
                    if(!cicada.isNullOrEmpty(data)){
                        var imgUrl = data;

                        str = "<div style='width: 50px;'>";
                        str +="   <div class='zoomImage' style='background-image:url("+imgUrl+")'></div>";
                        str +="</div>";
                    }
                    return str;
                }
            },
            {"data": 'nickname'},
            {
                "data": 'gender',
                "render":function (data,type,rowData,callback) {
                    return data.desc;
                }
            },
            {"data": 'phonenumber'},
            {
                "data": 'wxOpenId',
                "render":function (data,type,rowData,callback) {
                    return cicada.isNullOrEmpty(data)?"否":"是";
                }
            },
            {
                "data": 'userStatus',
                "render":function (data,type,rowData,callback) {
                    return data.desc;
                }
            },
            {
                "data": 'accountVo',
                "render": function (data,type,rowData,callback) {
                    if(data) {
                        //账户余额
                        return data.coinBalance;
                    }
                }
            },
            {
                "data": 'accountVo',
                "render": function (data,type,rowData,callback) {
                    if(data) {
                        //发布数量
                        return data.taskCount;
                    }
                }
            },
            {
                "data": 'createDate',
                "render":function (data,type,rowData,callback) {
                    return cicada.timeStamp2Date(data).format(cicada.CONSTS.DATE_FORMAT_MD_HM);
                }
            },
            {
                "data":"columnDefs"
            }
        ];
        //列表操作按钮
        var columnDefs = [
            {
                targets: -1,
                defaultContent: "<input type='button' id = 'btnDetail' value = '查看' class='btn btn-default btn-sm'/>"
            }
        ];

        var tables = $("#dataTable").dataTable(cicada.getDatatableSettings('client/list',
            //查询条件
            'queryForm',
            //对应上面thead里面的序列
            dataColumns,
            //操作按钮
            columnDefs,
            //在每次table被draw完后回调函数
            function () {
                var api = this.api();
                //获取到本页开始的条数
                var startIndex = api.context[0]._iDisplayStart;
                api.column(1).nodes().each(function (cell, i) {
                    //cell.innerHTML = cicada.CONSTS.TASK_TYPE.getName(i+1);
                });
            }
        ));

        //查询按钮
        $("#btn-query").on("click", function () {
            tables.fnDraw();//查询后不需要保持分页状态，回首页
        });
        //查看
        $("#dataTable tbody").on("click", "#btnDetail", function () {
            var data = tables.api().row($(this).parents("tr")).data();

            var url = 'client/detail?userid='+data.userId;
            var id = "user_"+data.userId;
            var title = "玩家详情【"+data.nickname+"】";
            window.parent.openNewTab(id,title,url);
            return;
        });
    });
</script>
