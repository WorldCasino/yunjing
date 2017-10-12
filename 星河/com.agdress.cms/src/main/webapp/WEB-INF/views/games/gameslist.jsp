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
            <%--<input type="hidden" name="loginId"   class="form-control">--%>
            <input type="hidden" name="loginbeUserId" id="loginbeUserId" value="<shiro:principal property="limitBeUserId"/>">
            <input type="hidden" name="loginagentId" id="loginagentId" value="<shiro:principal property="limitAgentId"/>">
            <div class="form-group">
                <label for="loginId" class="col-sm-2 control-label">玩家账号</label>
                 <div class="col-sm-2" >
                     <input type="text" name="loginId" id="loginId" class="form-control">
                </div>

                <label for="agentId" class="col-sm-2 control-label" >所属代理商</label>
                <div class="col-sm-2" >
                    <select name="agentId" id="agentId" class="form-control agentId" style="width: 120%;">

                    </select>
                </div>

                <label for="orderStatus" class="col-sm-2 control-label">结算状态</label>
                <div class="col-sm-2">
                    <select id ="orderStatus" name="orderStatus" class="form-control">
                        <option value="">全部</option>
                        <option value="1">未结算</option>
                        <option value="2">结算赢</option>
                        <option value="3">结算平</option>
                        <option value="4">结算输</option>
                        <option value="5">取消</option>
                        <option value="6">过期</option>
                        <option value="7">系统取消</option>
                    </select>
                </div>

             </div>
            <div class="form-group">

                <label for="fromIp" class="col-sm-2 control-label">玩家IP</label>
                <div class="col-sm-2" >
                    <input type="text" name="fromIp" id="fromIp" class="form-control">
                </div>


                <label for="date1" class="col-sm-2 control-label">下注时间</label>
                <div class="col-sm-2" >
                    <input type="text" name="date1" id="date1" class="form-control" style="width: 120%;">
                    <input type="text" id = "starttime" name="showStarttime" class="form-control" style="display: none"/>
                    <input type="text" id = "endtime" name="showEndtime" class="form-control" style="display: none;"/>
                </div>

                <label for="gameId" class="col-sm-2 control-label">游戏类型</label>
                <div class="col-sm-2">
                    <select id ="gameId" name="gameId" class="form-control">
                        <option value="">全部</option>
                        <option value="1">百家乐</option>
                        <option value="2">轮盘</option>
                        <option value="3">骰宝</option>
                        <option value="4">龙虎</option>
                        <option value="5">免拥百家乐</option>
                        <option value="6">超级六</option>
                        <option value="7">极速百家乐</option>
                        <option value="9">保险百家乐</option>
                        <option value="10">共咪百家乐</option>
                        <option value="11">多彩百家乐</option>
                        <option value="13">牛牛</option>
                     </select>
                </div>


              </div>
         </form>
        <div class="pull-right" style="margin-top: 5px;">
            <div class="btn-group">
                <shiro:hasPermission name="30search">
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
        <span style="font-size: 22px;"></span>投注总额：<span class="chumoney" style="display: inline-block;margin-right: 30px;"> </span> 输赢：<span class="rumoney"  style="display: inline-block;margin-right: 30px;"> </span>
        转码量：<span class="zmmoney" style="display: inline-block;margin-right: 30px;"> </span>
        <%--<span>(注：只能查询最近二十分之前的记录)</span>--%>
    </div>
    <!--表格-->
    <table id="dataTable" class="table table-striped table-bordered table-hover table-condensed" align="center">
        <thead>
        <tr class="info">
            <th style="width: 5%;">订单编号</th>
            <th style="width: 9%;">下注时间</th>
            <%--<th style="width: 5%;">用户ID</th>--%>
            <th style="width: 5%;">玩家账号</th>
            <th style="width: 5%;">代理商</th>
            <th style="width: 5%;">投注</th>
            <th style="width: 5%;">状态</th>
            <th style="width: 5%;">结算额</th>
            <th style="width: 5%;">转码量</th>
            <th style="width: 5%;">类型</th>
            <th style="width: 5%;">玩家IP</th>
            <th style="width: 5%;">局号</th>
            <th style="width: 5%;">桌号</th>
            <%--<th style="width: 5%;">发牌资料</th>--%>
            <%--<th style="width: 5%;">游戏结果GR</th>--%>

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
                $("#starttime").val(start.format("YYYY-MM-DD"));
                $("#endtime").val(end.format("YYYY-MM-DD"));
            });

        var bgLoginId = agdress.getQueryString("bgLoginId");
        $("input[name=loginId]").val(bgLoginId);

        var tables = $("#dataTable").dataTable(
            //URL
            agdress.getDatatableSettings('ss_games/dataGrid',
                //查询条件
                'queryForm',
                //对应上面thead里面的序列
                [
                    {"data": "orderId"},
                    {"data": "orderTime"},
//                    {"data": "uid"},
                    {"data": "loginId"},
                    {"data": "agentName"},
                    {"data": "bAmount"},
                    {
                        "data": 'orderStatus',
                        "render": function (data, type, full, callback) {
                            return data.desc
                        }
                    },
                    {"data": "aAmount"},
                    {"data": "zmAmount"},
                    {"data": "gameName"},
                    {"data": "fromIp"},
                    {"data": "issueId"},
                    {"data": "tableId"}
//                    {"data": "licensingInfor"},
//                    {"data": "resultContent"},

                ],
                //行操作按钮定义
                [

                ],
                // 在每次table被draw完后回调函数
                function () {
                     var api = this.api();
//                    console.log(api.context[0].json);
                    $(".rumoney").html(api.context[0].json.allcome_onmoney.toFixed(2));
                    $(".chumoney").html(api.context[0].json.allexpendmoney.toFixed(2));
                    $(".zmmoney").html(api.context[0].json.allzhuanmoney.toFixed(2));
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

        //代理商列表
        if(true) {
            $.ajax({
                type: "POST",
                url: agdress.CONSTS.URL_BASE_API+"ss_agent/getAgentList",
                data: {},
                async: false,
                success: function (data) {
                    var agentList=data.data;
                    $(".agentId").append("<option value=''>全部</option>");
                    for(var i=0 ; i <agentList.length ;i++){
                        $(".agentId").append("<option value='"+agentList[i].agentId+"'>"+agentList[i].nickName+"</option>");
                    }
                }
            });
        }

     });
</script>
