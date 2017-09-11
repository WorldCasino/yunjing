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
                <label for="agentId" class="col-sm-1 control-label">ID</label>
                <div class="col-sm-2" >
                    <input type="text" name="agentId" id="agentId" class="form-control">
                </div>
                <label for="qq" class="col-sm-1 control-label">QQ</label>
                <div class="col-sm-2" >
                    <input type="text" name="qq" id="qq" class="form-control">
                </div>
                <shiro:hasPermission name="23search">
                    <button type="button" class="btn btn-primary btn-sm" id="btn-query">
                        <i class="fa fa-search"></i> 查询
                    </button>
                    <button type="button" class="btn btn-primary btn-sm" id="btn-re">
                        <i class="fa fa-refresh"></i> 刷新
                    </button>
                </shiro:hasPermission>

             </div>

         </form>
    </div>

    <!--表格-->
    <table id="dataTable" class="table table-striped table-bordered table-hover table-condensed" align="center">
        <thead>
        <tr class="info">
            <th style="width: 10%;">业务员ID</th>
            <th style="width: 10%;">账号</th>
            <th style="width: 20%;">qq</th>
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

        var tables = $("#dataTable").dataTable(
            //URL
            agdress.getDatatableSettings('ss_agent/dataGrid',
                //查询条件
                'queryForm',
                //对应上面thead里面的序列
                [
                    {"data": "agentId"},
                    {"data": "agentName"},
                    {"data": 'qq'}
                ],
                //行操作按钮定义
                [ ],
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


     });
</script>
