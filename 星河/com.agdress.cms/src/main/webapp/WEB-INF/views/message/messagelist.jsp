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
            <input type="hidden" name="roleId"   class="form-control" value="<shiro:principal property="rolesstr"/>">
            <input type="hidden" name="loginbeUserId" id="loginbeUserId" value="<shiro:principal property="limitBeUserId"/>">
            <div class="form-group">
                <label for="tradeNo" class="col-sm-3 control-label">订单编号</label>
                <div class="col-sm-2" >
                    <input type="text" name="tradeNo" id="tradeNo" class="form-control">
                </div>

                <div class="pull-right" style="margin-top: 5px;">
                    <div class="btn-group">
                        <shiro:hasPermission name="42search">
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
         </form>

    </div>
    <!--表格-->
    <table id="dataTable" class="table table-striped table-bordered table-hover table-condensed" align="center">
        <thead>
        <tr class="info">
            <th style="width: 5%;">订单编号</th>
            <th style="width: 10%;">订单类型</th>
            <th style="width: 5%;">金额</th>
            <th style="width: 30%;">提醒内容</th>
            <th style="width: 5%;">创建时间</th>
            <th style="width: 5%;">操作</th>
        </tr>
        </thead>
        <tbody></tbody>
    </table>
</div>

<!--隐藏的退出弹窗点击退出显示-->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"
                        aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">信息详情</h4>
            </div>
            <div class="modal-body" style=" width: 100%; ">
                <form role="form" class="form-horizontal" id="detailForm" style=" width: 100%; ">
                    <div class="form-group"  >
                        <label class="col-sm-3 control-label">订单编号</label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control tradeNo"  disabled >
                        </div>
                    </div>
                    <div class="form-group"  >
                        <label class="col-sm-3 control-label">消息类型</label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control messageType"  disabled >
                        </div>
                    </div>
                    <div class="form-group"  >
                        <label class="col-sm-3 control-label">金额</label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control amount"  disabled >
                        </div>
                    </div>
                    <div class="form-group"  >
                        <label class="col-sm-3 control-label">内容</label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control content1"  disabled >
                        </div>
                    </div>
                    <div class="form-group"  >
                        <label class="col-sm-3 control-label">创建时间</label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control createDate"  disabled >
                        </div>
                    </div>
                </form>

                <div class="text-center" style="margin-top: 50px">
                    <button type="button" class="btn btn-default btn-lg" id="btnCancel">
                        返回列表
                    </button>
                </div>
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

        var tradeNo = agdress.getQueryString("tradeNo");
        console.log(tradeNo);
        if(tradeNo != null && tradeNo != ''){
            $("#tradeNo").val(tradeNo);
        }

        //添加、修改异步提交地址
        var str = "";
        <shiro:hasPermission name="42update">
        str+= "<div class='btn-group'>" +
            "<button  class='btn btn-primary btn-sm audit'  id='btn-query'  type='button'>查看详情</button>" +
            "</div>"
        </shiro:hasPermission>

        var tables = $("#dataTable").dataTable(
            //URL
            agdress.getDatatableSettings('message/dataGrid',
                //查询条件
                'queryForm',
                //对应上面thead里面的序列
                [
                    {"data": "tradeNo"},
                    {
                        "data": 'messageType',
                        "render": function (data, type, full, callback) {
                            return data.desc
                        }
                    },
                    {"data": "amount"},
                    {"data": "content"},
                    {
                        "data": 'createDate',
                        "render": function (data, type, full, callback) {
                            return agdress.timeStamp2String(data)
                        }
                    },
                    {
                        "data": 'status',
                        "render": function (data, type, full, callback) {
                            return data == "1"?"已读":str
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


        //返回列表
        $("#btnCancel").on("click", function () {
            window.location.reload();
        });


        //转为已读
        $("#dataTable tbody").on("click", ".audit", function () {
            var data = tables.api().row($(this).parents("tr")).data();
            var messageContentId=data.messageContentId;
            changeStatus(messageContentId);
            LinkUrl(data.messageType.code,data.tradeNo,messageContentId);
//            $(".tradeNo").val(data.tradeNo);
//            $(".amount").val(data.amount);
//            $(".messageType").val(data.messageType.desc);
//            var content1=data.content.trim();
//            console.log(content1)
//            $(".content1").val(content1);
//            $(".createDate").val(agdress.timeStamp2String(data.createDate));
//            $("#myModal").modal("show");
        });

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

        function LinkUrl(messageType,tradeNo,messageContentId){
             if(messageType == 50){//提现审核
                 var url = 'audit/withdrawal?tradeNo='+tradeNo+"&messageContentId="+messageContentId;
                 var id = "Account_CJ"+tradeNo;
                 var title = "出金审核列表";
                 window.parent.openNewTab(id,title,url);
                 return;
             }else {
                 //查看出入金记录
                 var url = 'ss_ac_detail/manager?tradeNo='+tradeNo;
                 var id = "Account_CR"+tradeNo;
                 var title = "出入金明细记录";
                 window.parent.openNewTab(id,title,url);
                 return;
             }

        }



     });

</script>
