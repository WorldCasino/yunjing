<%@ page import="com.cicada.commons.utils.SystemConfig" %>
<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>充值兑换明细</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/dist/css/font-awesome.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/dist/css/ionicons.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/dist/css/AdminLTE.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/dist/css/skins/all-skins.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/plugins/datatables/jquery.dataTables.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/plugins/datatables/dataTables.bootstrap.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/plugins/datepicker/css/bootstrap-datepicker3.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/plugins/daterangepicker/daterangepicker.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/plugins/select2/select2.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/cicada.main.css">
</head>
<body style="overflow: hidden" class="sidebar-mini">
<div class="content">
    <div class="row-fluid">
        <form id="queryForm" class="form-horizontal" action="" method="post">
            <input type="hidden" name="tradeTypeIds" value="0,1,4,7,8">
            <div class="form-group">
                <label for="create_date" class="col-sm-1 control-label">交易时间</label>
                <div class="col-sm-2" >
                    <input type="text" name="create_date" id="create_date" class="form-control" style="width: 120%;">
                    <input type="text" id = "createDateStart" name="startTime" class="form-control" style="display: none"/>
                    <input type="text" id = "createDateEnd" name="endTime" class="form-control" style="display: none;"/>
                </div>

                <label for="q_nickname" class="col-sm-1 control-label">玩家昵称</label>
                <div class="col-sm-2">
                    <input type="text" id="q_nickname" name="nickname" class="form-control input-sm"/>
                    <input type="text" name="userId" class="form-control" style="display: none;"/>
                </div>
                <label for="q_phonenumber" class="col-sm-1 control-label">手机号</label>
                <div class="col-sm-2">
                    <input type="text" id="q_phonenumber" name="phonenumber" class="form-control input-sm"/>
                </div>
                <label class="col-sm-1 control-label">交易类型</label>
                <div class="col-sm-2">
                    <select id ="fromType" name="fromType" multiple="multiple" class="form-control">
                        <option value="0">充值金币</option>
                        <option value="1">充值送金币</option>
                        <option value="4">商品兑换</option>
                        <option value="7">新用户注册奖励</option>
                        <option value="8">登录奖励</option>
                    </select>
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
            <th style="width: 8%;">流水号</th>
            <th style="width: 10%;">交易时间</th>
            <th style="width: 10%;">交易类型</th>
            <th style="width: 12%;">玩家昵称</th>
            <th style="width: 10%;">手机号</th>
            <th style="width: 8%;">金额</th>
            <th style="width: 8%;">金币</th>
            <th style="width: 10%;">状态</th>
            <th style="width: 16%;">备注</th>
            <th style="width: 8%;">操作员</th>
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
<script src="<%=request.getContextPath()%>/plugins/select2/select2.js"></script>
<script src="<%=request.getContextPath()%>/plugins/select2/i18n/zh-CN.js"></script>

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

        var id = cicada.getQueryString("userid");
        $("input[name=userId]").val(id);

        $("input[name='create_date']").daterangepicker(cicada.DATE_RANGE_PICKER_OPTIONS,
            function(start, end, label) {
                $("#createDateStart").val(start.format("YYYY/MM/DD"));
                $("#createDateEnd").val(end.format("YYYY/MM/DD"));
            });

        //多选
        $("#fromType").select2({
            tags: true,
            maximumSelectionLength: 3  //最多能够选择的个数
        });

        $("#fromType").on('change',function () {
            var selList = $("#fromType").select2("data");
            var ids = "";
            selList.forEach(function (value, index, arr) {
                ids += (ids==""?"":",") + value.id;
            });

            $("input[name='tradeTypeIds']").val(ids);
        });

        //数据列绑定
        var dataColumns = [
            {"data": 'uadId'},
            {
                "data": 'createDate',
                "render":function (data,type,rowData,callback) {
                    return cicada.timeStamp2Date(data).format(cicada.CONSTS.DATE_FORMAT_MD_HM);
                }
            },
            {
                "data": 'fromType',
                "render":function (data,type,rowData,callback) {
                    return data.desc;
                }
            },
            {
                "data": 'nickname',
                "render":function (data,type,rowData,callback) {
                    return data + '<br/>[' + rowData.userId + ']';
                }
            },
            {"data": 'phonenumber'},
            {"data": 'rechargeAmount'},
            {
                "data": 'coins',
                "render":function (data,type,rowData,callback) {
                    return data * cicada.ENUMS.TRADE_TYPE.getFlag(rowData.fromType.code);
                }
            },
            {
                "data": 'tradeStatus',
                "render": function (data,type,rowData,callback) {
                    //TODO EDIT
                    return cicada.isNullOrEmpty(data)?'已完成':data;
                }
            },
            {
                "data": 'remark'
            },
            {
                "data": 'operater',
                "render": function (data,type,rowData,callback) {
                    return data;
                }
            }
        ];

        var columnDefs = [
        ];

        var tables = $("#dataTable").dataTable(cicada.getDatatableSettings('trade/list',
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
        //查看竞猜详情
        $("#dataTable tbody").on("click", "#taskLink", function () {
            var data = tables.api().row($(this).parents("tr")).data();

            var url = 'task/view?taskId='+data.taskId;
            var id = "task_"+data.taskId;
            var title = "竞猜详情【"+data.taskId+"】";
            window.parent.openNewTab(id,title,url);
            return;
        });
    });
</script>
