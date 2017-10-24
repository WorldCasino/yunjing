<%@ page import="com.cicada.commons.utils.SystemConfig" %>
<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>  
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>兑换审核</title>
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
                <label for="create_date" class="col-sm-1 control-label">下单时间</label>
                <div class="col-sm-2" >
                    <input type="text" name="create_date" id="create_date" class="form-control" style="width: 120%;">
                    <input type="text" id = "createDateStart" name="createDateStart" class="form-control" style="display: none"/>
                    <input type="text" id = "createDateEnd" name="createDateEnd" class="form-control" style="display: none;"/>
                </div>
                <label for="create_date" class="col-sm-1 control-label">姓名</label>
                <div class="col-sm-2" >
                    <input type="text" name="nickname" id="nickname" class="form-control">
                </div>
                <label for="create_date" class="col-sm-1 control-label">电话</label>
                <div class="col-sm-2" >
                    <input type="text" name="phonenumber" id="phonenumber" class="form-control">
                </div>
                <label for="order_status" class="col-sm-1 control-label">状态</label>
                <div class="col-sm-2">
                    <select id ="order_status" name="order_status" class="form-control">
                        <option value="">全部</option>
                        <option value="10">已下单</option>
                        <option value="20">已支付</option>
                        <option value="30">审核中</option>
                        <option value="40">配送中</option>
                        <option value="50">已收货</option>
                        <option value="60">退款中</option>
                        <option value="70">退货中</option>
                        <option value="99">已取消</option>
                    </select>
                </div>
            </div>
        </form>

        <div class="pull-right" style="margin-top: 5px;">

            <button type="button" class="btn btn-primary btn-sm" id="btn-query">
                <i class="fa fa-search"></i> 查询
            </button>

            <div class="btn-group">
                <button type="button" class="btn btn-primary btn-sm" id="btn-re">
                    <i class="fa fa-refresh"></i> 刷新
                </button>
            </div>
        </div>
    </div>

    <!--表格-->
    <table id="dataTable" class="table table-striped table-bordered table-hover table-condensed" align="center">
        <thead>
        <tr class="info">
            <th style="width: 10%;">兑换单号</th>
            <th style="width: 10%;">商品ID</th>
            <th style="width: 20%;">商品名称</th>
            <th style="width: 10%;">数量</th>
            <th style="width: 10%;">兑换总额</th>
            <th style="width: 10%;">姓名</th>
            <th style="width: 10%;">手机号</th>
            <th style="width: 10%;">状态</th>
            <th style="width: 10%;">操作</th>
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
        cicada.CONSTS.URL_BASE = "<%=SystemConfig.getInstance().getURL_BASE()%>";
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
            "<button id='audit' class='btn btn-danger btn-sm' type='button'><i class='fa fa-edit'></i> 审核</button>" +
            "</div>"
        </shiro:hasAnyRoles>

        var tables = $("#dataTable").dataTable(
            //URL
            cicada.getDatatableSettings('order/list',
                //查询条件
                $("#queryForm").serializeArray(),
                //对应上面thead里面的序列
                [
                    {"data": "orderId"},
                    {"data": "itemId"},
                    {"data": "itemName"},
                    {"data": 'qty'},
                    {"data": 'coinsAmount'},
                    {
                        "data": 'addrContact',
                        "render": function (data,type,rowData,callback) {
                            return data + '<br/>[' + rowData.clientId+']'
                        }
                    },
                    {"data": 'addrTel'},
                    {
                        "data": 'orderStatus',
                        "render":function (data,type,rowData,callback) {
                            return data.desc;
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
//                    cell.innerHTML = cicada.CONSTS.TASK_TYPE.getName(i+1);
                    });
                }
        ));

//查询按钮
        $("#btn-query").on("click", function () {
            tables.fnDraw();//查询后不需要保持分页状态，回首页
        });

//锁定竞猜
        $("#btn-lock").on("click", function () {
            var ids = new Array();
            $('input:checkbox[name=checkList]:checked').each(function (i) {
                ids.push(this.id);
            })

            if(ids.length==0){
                layer.msg("请选择要锁定的竞猜项目！");
                return;
            }

            layer.confirm('<span style="color:red">锁定后将无法下注！<br/>确定要锁定选中的竞猜项目吗？</span>', {
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

        //刷新
        $("#btn-re").on("click", function () {
            tables.fnDraw(false);//刷新保持分页状态
        });

        //修改
        $("#dataTable tbody").on("click", "#editRow", function () {
            var data = tables.api().row($(this).parents("tr")).data();
            $("input[name=typeId]").val(data.typeIdStr);
            $("input[name=typeNameCn]").val(data.typeNameCn);
            $("input[name=typeNameEn]").val(data.typeNameEn);

            url = "";

            $("#editModal").modal("show");
        });

        $("#btn-submit").on("click", function () {
            $.ajax({
                cache: false,
                type: "POST",
                url: url,
                data: $("#editForm").serialize(),
                async: false,
                error: function (request) {
                    showFail("Server Connection Error<%=request.getContextPath()%>.");
                },
                success: function (data) {
                    if (data.status == 1) {
                        $("#editModal").modal("hide");
                        showSuccess("");
                        tables.fnDraw();
                    } else {
                        showFail("");
                    }
                }
            });
        });

        //审核通过
        $("#dataTable tbody").on("click", "#audit", function () {
            var data = tables.api().row($(this).parents("tr")).data();
            var orderId = data.orderId;

            layer.confirm('<span style="color:red">确定通过兑换审核吗？</span>', {
                title:"警告",
                btn: ['通过','不通过','取消'] //按钮
            }, function(index){
                var data = {orderId:orderId,isOk:true};
                cicada.post('order/audit',JSON.stringify(data),function (result) {
                    layer.msg('审核处理成功！');

                    tables.fnDraw(false);//刷新保持分页状态
                },function (err) {
                    layer.msg('审核处理失败！'+ err.message, {icon: 2});
                },"application/json");

                layer.close(index);
            }, function(index){
                var data = {orderId:orderId,isOk:false};
                cicada.post('order/audit',JSON.stringify(data),function (result) {
                    layer.msg('审核不通过保存成功！');

                    tables.fnDraw(false);//刷新保持分页状态
                },function (err) {
                    layer.msg('审核不通过保存失败！'+ err.message, {icon: 2});
                },"application/json");

                tables.fnDraw(false);//刷新保持分页状态

                layer.close(index);
            }, function(index){
                layer.close(index);
            });
        });

    });
</script>
