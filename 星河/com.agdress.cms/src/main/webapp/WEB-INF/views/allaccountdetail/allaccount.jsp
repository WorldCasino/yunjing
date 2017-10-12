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
            <input type="hidden" name="userId"   class="form-control">
            <input type="hidden" name="loginbeUserId" id="loginbeUserId" value="<shiro:principal property="limitBeUserId"/>">
            <input type="hidden" name="loginagentId" id="loginagentId" value="<shiro:principal property="limitAgentId"/>">
            <div class="form-group">
                <label for="bgLoginId" class="col-sm-2 control-label">用户ID</label>
                 <div class="col-sm-2" >
                    <input type="text" name="bgLoginId" id="bgLoginId" class="form-control">
                </div>
                <label for="date1" class="col-sm-2 control-label">创建时间</label>
                <div class="col-sm-2" >
                    <input type="text" name="date1" id="date1" class="form-control" style="width: 120%;">
                    <input type="text" id = "createStartTime" name="createStartTime" class="form-control" style="display: none"/>
                    <input type="text" id = "createEndTime" name="createEndTime" class="form-control" style="display: none;"/>
                </div>
                <label for="tradeStatus" class="col-sm-2 control-label">状态</label>
                <div class="col-sm-2">
                    <select id ="tradeStatus" name="tradeStatus" class="form-control">
                        <option value="">全部</option>
                        <option value="0">审核中</option>
                        <option value="1">审核不通过</option>
                        <option value="3">审核通过</option>
                        <option value="2">已完成</option>
                    </select>
                </div>
             </div>
            <div class="form-group">
                <label for="tradeKind" class="col-sm-2 control-label">出入金</label>
                <div class="col-sm-2">
                    <select id ="tradeKind" name="tradeKind" class="form-control">
                        <option value="">全部</option>
                        <option value="1">入金</option>
                        <option value="-1">出金</option>
                     </select>
                </div>
                <label for="tradeNo" class="col-sm-2 control-label">订单编号</label>
                <div class="col-sm-2" >
                    <input type="text" name="tradeNo" id="tradeNo" value="" style="width: 120%;">
                </div>
              </div>
         </form>
        <div class="pull-right" style="margin-top: 5px;">
            <div class="btn-group">
                <shiro:hasPermission name="5search">
                    <button type="button" class="btn btn-primary btn-sm" id="btn-query">
                         查询
                    </button>
                    <button type="button" class="btn btn-primary btn-sm" id="btn-re">
                         刷新
                    </button>
                </shiro:hasPermission>
            </div>
        </div>
    </div>
    <div style="font-size: 20px;">
        <span style="font-size: 22px;">出入金统计：</span>入金总额：<span class="rumoney" style="display: inline-block;margin-right: 30px;">${rumoney}</span> 出金总额：<span class="chumoney">${chumoney}</span>
    </div>
    <!--表格-->
    <table id="dataTable" class="table table-striped table-bordered table-hover table-condensed" align="center">
        <thead>
        <tr class="info">
            <th style="width: 10%;">订单编号</th>
            <th style="width: 10%;">用户ID</th>
            <th style="width: 10%;">昵称</th>
            <th style="width: 10%;">事件</th>
            <th style="width: 10%;">出入金方式</th>
            <th style="width: 10%;">金额</th>
            <th style="width: 10%;">状态</th>
            <th style="width: 10%;">创建时间</th>
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
                $("#createStartTime").val(start.format("YYYY/MM/DD"));
                $("#createEndTime").val(end.format("YYYY/MM/DD"));
            });

        var id = agdress.getQueryString("userId");
        $("input[name=userId]").val(id);
        var tradeKind = agdress.getQueryString("tradeKind");
        if(tradeKind != null && tradeKind != ''){
            $("#tradeKind").val(tradeKind);
        }
        var bgLoginId = agdress.getQueryString("bgLoginId");
        $("input[name=bgLoginId]").val(bgLoginId);
        if(bgLoginId != null && bgLoginId != ''){
            $("input[name=bgLoginId]").attr("readonly","readonly");
        }

        //消息记录用到的
        var messageContentId = agdress.getQueryString("messageContentId");
        var tradeNo = agdress.getQueryString("tradeNo");
        if(tradeNo != null && tradeNo != ''){
            $("#tradeNo").val(tradeNo);
        }

        var tables = $("#dataTable").dataTable(
            //URL
            agdress.getDatatableSettings('ss_ac_detail/dataGrid',
                //查询条件
                'queryForm',
                //对应上面thead里面的序列
                [
                    {"data": "tradeNo"},
                    {"data": "bgLoginId"},
                    {"data": "nickName"},
                    {
                        "data": 'tradeKindEnum',
                        "render": function (data, type, full, callback) {
                            return data.desc;
                          }
                    },
                    {
                        "data": 'tradeTypeEnum',
                        "render": function (data, type, full, callback) {
                            return data.desc
                        }
                    },
                    {"data": 'amount'},
                    {
                        "data": 'tradeStatusEnum',
                        "render": function (data, type, full, callback) {
                            return data.desc
                        }
                    },
                    {
                        "data": 'createDate',
                        "render": function (data, type, full, callback) {
                            return agdress.timeStamp2String(data)
                        }
                    }
                ],
                //行操作按钮定义
                [

                ],
                // 在每次table被draw完后回调函数
                function () {
                     var api = this.api();
//                    console.log(api.context[0].json);
                    $(".rumoney").html(api.context[0].json.allcome_onmoney);
                    $(".chumoney").html(api.context[0].json.allexpendmoney);
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

        //刷新页面
        $("#btn-re").on("click", function () {
            tables.fnDraw(false);//刷新保持分页状态
        });

        //判断是否是从消息中进入的
        if(messageContentId != ""){
            changeStatus(messageContentId)
        }
        function changeStatus(messageContentId){
            $.ajax({
                type: "POST",
                url: agdress.CONSTS.URL_BASE_API + "message/updateStatus",
                data: {
                    "messageContentId": messageContentId,
                    "status": "1"
                },
                async: false,
                success: function (data) {
                    window.parent.messageList();
                }, error: function (error) {
                    layer.msg(error.responseText, {icon: 2});
                }
            });
        }


     });
</script>
