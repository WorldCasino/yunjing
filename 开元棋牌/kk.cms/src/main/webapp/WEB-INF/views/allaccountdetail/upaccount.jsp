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
                <label for="userId" class="col-sm-1 control-label">用户Id</label>
                <div class="col-sm-2" >
                    <input type="text" name="userId" id="userId" class="form-control">
                </div>
                <label for="tradeNo" class="col-sm-2 control-label">订单编号</label>
                <div class="col-sm-2" >
                    <input type="text" name="tradeNo" id="tradeNo" value="" style="width: 120%;">
                </div>

                <div class="pull-right" style="margin-top: 5px;">
                    <div class="btn-group">
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


              </div>
         </form>

    </div>

    <!--表格-->
    <table id="dataTable" class="table table-striped table-bordered table-hover table-condensed" align="center">
        <thead>
        <tr class="info">
            <th style="width: 10%;">订单编号</th>
            <th style="width: 10%;">用户ID</th>
            <th style="width: 10%;">用户昵称</th>
            <th style="width: 10%;">手机号</th>
            <th style="width: 10%;">打款金额</th>
            <th style="width: 10%;">银行卡</th>
            <th style="width: 10%;">持卡人</th>
            <th style="width: 10%;">开户行</th>
            <th style="width: 10%;">操作</th>
        </tr>
        </thead>
        <tbody></tbody>
    </table>
</div>



<div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog"  >
        <div class="modal-content"  >
             <div class="modal-header"  >
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">&times;</span>
                    <span class="sr-only"></span>
                </button>
                <h4 class="modal-title" id="myModalLabel">出金打款</h4>
            </div>

            <div class="modal-body" style=" width: 100%; ">
                <form role="form" class="form-horizontal" id="detailForm" style=" width: 100%; ">
                    <input type="hidden"  class="tradeId" value="">
                    <input type="hidden"  class="phone" value="">
                     <%--账户信息--%>
                     <div class="form-group"  >
                        <label class="col-sm-8 control-label" >已经给用户打款，提醒用户打款进度</label>
                    </div>
                    <div class="form-group"  >
                        <label class="col-sm-4 control-label">持卡人</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control cardName"  disabled >
                        </div>
                    </div>
                    <div class="form-group"  >
                        <label class="col-sm-4 control-label">金额</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control amount"  disabled >
                        </div>
                    </div>
                 </form>


                <div class="text-center" style="margin-top: 50px">
                    <shiro:hasPermission name="8mademoney">
                        <div class="btn-group">
                            <button type="button" class="btn btn-primary btn-lg" id="okOne">
                               确认打款
                            </button>
                        </div>
                    </shiro:hasPermission>
                    <button type="button" class="btn btn-default btn-lg" id="btnCancel">
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

        $("input[name='date1']").daterangepicker(kk.DATE_RANGE_PICKER_OPTIONS,
            function(start, end, label) {
                $("#createStartTime").val(start.format("YYYY/MM/DD"));
                $("#createEndTime").val(end.format("YYYY/MM/DD"));
            });



        //添加、修改异步提交地址
        var str = "";
        <shiro:hasPermission name="8mademoney">
        str+= "<div class='btn-group'>" +
            "<button   class='btn btn-danger btn-sm audit' type='button'> 打款</button>" +
            "</div>"
        </shiro:hasPermission>


        var tables = $("#dataTable").dataTable(
            //URL
            kk.getDatatableSettings('ac_detail/system/updataGrid',
                //查询条件
                'queryForm',
                //对应上面thead里面的序列
                [
                    {"data": "tradeNo"},
                    {"data": "userId"},
                    {"data": "nickName"},
                    {"data": "phone"},
                    {"data": 'amount'},
                    {"data": 'cardNo'},
                    {"data": 'cardName'},
                    {"data": 'cardBank'},
                    {
                        "data": 'tradeStatusEnum',
                        "render": function (data, type, full, callback) {
                            return data.code == 3 ? str:data.desc
                        }
                    }
                ],
                //行操作按钮定义
                [

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
            window.location.reload();
        });

        //查看
        $("#dataTable tbody").on("click", ".audit", function () {
            var data = tables.api().row($(this).parents("tr")).data();
            $("#myModalLabel").html(data.nickName+"的打款确认");

            $(".amount").val(data.amount);
            $(".cardName").val(data.cardName);
            $(".tradeId").val(data.tradeId);
            $(".phone").val(data.phone);

            $("#editModal").modal("show");
         });




        //打款通过按钮
        $("#okOne").on("click", function () {
            layer.confirm('<span style="color:red">确定打款了吗？</span>', {
                title:"警告",
                btn: ['确认','取消'] //按钮
            }, function(index){
                $.ajax({
                    type: "POST",
                    url: kk.CONSTS.URL_BASE_API+"ac_detail/system/updateAccountDetailInfor",
                    data: {
                        "tradeId":$(".tradeId").val(),
                        "playMoeny":"true",
                        "phone":$(".phone").val(),
                        "updateBy"  : <shiro:principal property="id"/>
                    },
                    async: false,
                    success: function (data) {
                        if (data.data == true) {
                            layer.msg('打款成功！');
                            $("#btnCancel").click();
                        } else {
                            layer.msg("打款失败", {icon: 2});
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
