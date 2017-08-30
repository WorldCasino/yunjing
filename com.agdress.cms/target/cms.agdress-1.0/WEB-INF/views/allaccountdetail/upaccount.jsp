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
                <label for="user_id" class="col-sm-1 control-label">用户ID</label>
                <div class="col-sm-2" >
                    <input type="text" name="user_id" id="user_id" class="form-control">
                </div>
                  <div class="col-sm-2" >
                        <shiro:hasPermission name="5search">
                            <button type="button" class="btn btn-primary btn-sm" id="btn-query">
                                <i class="fa fa-search"></i> 查询
                            </button>
                            <button type="button" class="btn btn-primary btn-sm" id="btn-re">
                                <i class="fa fa-refresh"></i> 刷新
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
            <th style="width: 10%;">编号</th>
            <th style="width: 10%;">用户ID</th>
            <th style="width: 10%;">昵称</th>
            <th style="width: 10%;">手机号</th>
            <th style="width: 10%;">打款金额</th>
            <th style="width: 20%;">银行卡</th>
            <th style="width: 10%;">持卡人</th>
            <th style="width: 10%;">开户行</th>
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
                <h4 class="modal-title" id="myModalLabel">出金打款</h4>
            </div>

            <div class="modal-body" style=" width: 100%; ">
                <form role="form" class="form-horizontal" id="detailForm" style=" width: 100%; ">
                    <input type="hidden"  class="trade_id" value="">
                    <input type="hidden"  class="phone" value="">
                     <%--账户信息--%>
                    <div class="form-group" id="divAnswerRight">
                        <label class="col-sm-1 control-label" ></label>
                        <div class="col-sm-8">
                            <span style="display: block;width:100%;font-size: 18px;">已经给用户打款，提醒用户打款进度</span>
                            <span style="display: block;width:100%;font-size: 16px;">持卡人：<span class="card_name"></span></span>
                            <span style="display: block;width:100%;font-size: 16px;">金额：<span class="amount"></span></span>
                        </div>
                    </div>

                     <div class="from-group text-center">
                        <shiro:hasPermission name="8mademoney">
                            <div class="btn-group">
                                <button type="button" class="btn btn-primary btn-sm" id="okOne">
                                    确认
                                </button>
                            </div>
                        </shiro:hasPermission>
                        <div class="btn-group">
                            <button type="button" class="btn btn-primary btn-sm" id="btnCancel">
                                 取消
                            </button>
                        </div>
                    </div>
                </form>
            </div>
         </div>
    </div>
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



        //添加、修改异步提交地址
        var str = "";
        <shiro:hasPermission name="8mademoney">
        str+= "<div class='btn-group'>" +
            "<button   class='btn btn-danger btn-sm audit' type='button'><i class='fa fa-edit'></i> 打款</button>" +
            "</div>"
        </shiro:hasPermission>


        var tables = $("#dataTable").dataTable(
            //URL
            agdress.getDatatableSettings('ss_ac_detail/updataGrid',
                //查询条件
                'queryForm',
                //对应上面thead里面的序列
                [
                    {"data": "trade_id"},
                    {"data": "user_id"},
                    {"data": "nickname"},
                    {"data": "phone"},
                    {"data": 'amount'},
                    {"data": 'card_no'},
                    {"data": 'card_name'},
                    {"data": 'card_bank'},
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
        $("#btnCancel").on("click", function () {
            $("#editModal").modal("hide");
            window.location.reload();
        });

        //查看
        $("#dataTable tbody").on("click", ".audit", function () {
            var data = tables.api().row($(this).parents("tr")).data();
            $("#myModalLabel").html(data.nickname+"的打款确认");

            $(".amount").html(data.amount);
            $(".card_name").html(data.card_name);
            $(".trade_id").val(data.trade_id);
            $(".phone").val(data.phone);

            $("#editModal").modal("show");
         });




        //审核通过按钮
        $("#okOne").on("click", function () {
            layer.confirm('<span style="color:red">确定打款了吗？</span>', {
                title:"警告",
                btn: ['确认','取消'] //按钮
            }, function(index){
                $.ajax({
                    type: "POST",
                    url: agdress.CONSTS.URL_BASE_API+"ss_ac_detail/updateAccountDetailInfor",
                    data: {
                        "trade_id":$(".trade_id").val(),
                        "is_notification":"1",
                        "phone":$(".phone").val()
                    },
                    async: false,
                    success: function (data) {
                        if (data.data == true) {
                            $("#okOne").hide();
                            $("#errorOne").hide();
                            layer.msg('审核处理成功！');
                        } else {
                            layer.msg('审核处理失败！');
                        }
                    }
                });
                 layer.close(index);
            } , function(index){
                layer.close(index);
            });

        });

     });
</script>
