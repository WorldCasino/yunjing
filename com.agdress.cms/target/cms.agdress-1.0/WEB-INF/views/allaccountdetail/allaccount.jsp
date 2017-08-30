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
                <label for="date1" class="col-sm-1 control-label">创建时间</label>
                <div class="col-sm-2" >
                    <input type="text" name="date1" id="date1" class="form-control" style="width: 100%;">
                    <input type="text" id = "createStartTime" name="createStartTime" class="form-control" style="display: none"/>
                    <input type="text" id = "createEndTime" name="createEndTime" class="form-control" style="display: none;"/>
                </div>
             </div>
            <div class="form-group">
                <label for="trade_kind" class="col-sm-1 control-label">事件</label>
                <div class="col-sm-2">
                    <select id ="trade_kind" name="trade_kind" class="form-control">
                        <option value="">全部</option>
                        <option value="1">入金</option>
                        <option value="2">出金</option>
                     </select>
                </div>
                <label for="trade_type" class="col-sm-1 control-label">出入金方式</label>
                <div class="col-sm-2">
                    <select id ="trade_type" name="trade_type" class="form-control">
                        <option value="">全部</option>
                        <option value="10">充值</option>
                        <option value="20">游戏转码</option>
                        <option value="30">游戏赢利</option>
                        <option value="40">游戏赔付</option>
                        <option value="50">提现</option>
                    </select>
                </div>
                <label for="trade_status" class="col-sm-1 control-label">状态</label>
                <div class="col-sm-2">
                    <select id ="trade_status" name="trade_status" class="form-control">
                        <option value="">全部</option>
                        <option value="10">已提交</option>
                        <option value="20">审核中</option>
                        <option value="30">已完成</option>
                        <option value="40">审核不通过</option>
                        <option value="50">已关闭</option>
                     </select>
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
    <div style="font-size: 20px;">
        <span style="font-size: 22px;">出入金统计：</span>入金总额：<span class="rumoney" style="display: inline-block;margin-right: 30px;">${rumoney}</span> 出金总额：<span class="chumoney">${chumoney}</span>
    </div>
    <!--表格-->
    <table id="dataTable" class="table table-striped table-bordered table-hover table-condensed" align="center">
        <thead>
        <tr class="info">
            <th style="width: 10%;">账单ID</th>
            <th style="width: 10%;">用户ID</th>
            <th style="width: 10%;">昵称</th>
            <th style="width: 20%;">事件</th>
            <th style="width: 10%;">出入金方式</th>
            <%--<th style="width: 10%;">交易类型</th>--%>
            <th style="width: 10%;">金额</th>
            <th style="width: 10%;">状态</th>
            <th style="width: 10%;">创建时间</th>
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
                <h4 class="modal-title" id="myModalLabel">出金审核</h4>
            </div>

            <div class="modal-body" style=" width: 100%; ">
                <form role="form" class="form-horizontal" id="detailForm" style=" width: 100%; ">
                    <input type="hidden"  class="trade_id" value="">
                     <%--个人信息--%>
                    <div class="form-group" id="divAnswerRight">
                        <label class="col-sm-1 control-label" ></label>
                        <div class="col-sm-8">
                               <span style="display: block;width:100%;font-size: 20px;">用户信息</span>
                               <span style="display: block;width:100%;">用户ID：<span class="user_id"></span></span>
                               <span style="display: block;width:100%;">用户名称：<span class="nickname"></span></span>
                               <span style="display: block;width:100%;">用户手机号：<span class="phone"></span></span>
                        </div>
                     </div>
                    <%--账户信息--%>
                    <div class="form-group" id="divAnswerRight">
                        <label class="col-sm-1 control-label" ></label>
                        <div class="col-sm-8">
                            <span style="display: block;width:100%;font-size: 20px;">账户信息</span>
                            <span style="display: block;width:100%;">账户余额：<span class="balance"></span></span>
                            <span style="display: block;width:100%;">可转出余额：<span class="action_totle"></span></span>
                        </div>
                    </div>
                    <%--卡号信息--%>
                    <div class="form-group" id="divAnswerRight">
                        <label class="col-sm-1 control-label" ></label>
                        <div class="col-sm-8">
                            <span style="display: block;width:100%;font-size: 20px;">银行卡</span>
                            <span style="display: block;width:100%;">卡号：<span class="card_no"></span></span>
                            <span style="display: block;width:100%;">持卡人：<span class="card_name"></span></span>
                            <span style="display: block;width:100%;">开户行：<span class="card_bank"></span></span>
                        </div>
                    </div>
                     <div class="from-group text-center">
                        <shiro:hasPermission name="5examine">
                            <div class="btn-group">
                                <button type="button" class="btn btn-primary btn-sm" id="okOne">
                                    审核通过
                                </button>
                            </div>
                            <div class="btn-group" style="display: none;">
                                <button type="button" class="btn btn-primary btn-sm" id="errorOne">
                                    不通过审核
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
        <shiro:hasPermission name="5examine">
        str+= "<div class='btn-group'>" +
            "<button   class='btn btn-danger btn-sm audit' type='button'><i class='fa fa-edit'></i> 审核</button>" +
            "</div>"
        </shiro:hasPermission>


        var tables = $("#dataTable").dataTable(
            //URL
            agdress.getDatatableSettings('ss_ac_detail/dataGrid',
                //查询条件
                'queryForm',
                //对应上面thead里面的序列
                [
                    {"data": "trade_id"},
                    {"data": "user_id"},
                    {"data": "nickname"},
                    {
                        "data": 'trade_kind',
                        "render": function (data, type, full, callback) {
                            if(parseInt(data) == 1  ){
                                return "入金"
                            }else  if(parseInt(data) == 2  ){
                                return "出金"
                            }else{
                                return "状态是"+data
                            }
                          }
                    },
//                    {
//                        "data": 'trade_currency',
//                        "render": function (data, type, full, callback) {
//                            if(parseInt(data) == 1  ){
//                                return "支付宝"
//                            }else if(parseInt(data) == 2){
//                                return "微信"
//                            }else if(parseInt(data) == 3){
//                                return "银行卡"
//                            }else{
//                                return ""
//                            }
//                        }
//                    },
                    {
                        "data": 'trade_type',
                        "render": function (data, type, full, callback) {
                            if(parseInt(data) == 10  ){
                                return "充值"
                            }else if(parseInt(data) == 20){
                                return "游戏转码（下注）"
                            }else if(parseInt(data) == 20){
                                return "游戏赢利"
                            }else if(parseInt(data) == 20){
                                return "游戏赔付"
                            }else{
                                return "提现"
                            }
                        }
                    },
                    {"data": 'amount'},
                    {
                        "data": 'trade_status',
                        "render": function (data, type, full, callback) {
                            if(parseInt(data) == 10  ){
                                return "已提交"
                            }else if(parseInt(data) == 20){
                                return "审核中"
                            }else if(parseInt(data) == 30){
                                return "已完成"
                            }else if(parseInt(data) == 40){
                                return "审批不通过"
                            }else{
                                return "已关闭"
                            }
                        }
                    },
                    {
                        "data": 'create_date',
                        "render": function (data, type, full, callback) {
                            return agdress.timeStamp2String(data)
                        }
                    },
                    {
                        "data": 'trade_status',
                        "render": function (data, type, full, callback) {
                            if(parseInt(data) == 10  ){
                                return ""
                            }else if(parseInt(data) == 20){
                                return str
                            }else if(parseInt(data) == 30){
                                return ""
                            }else if(parseInt(data) == 40){
                                return ""
                            }else{
                                return ""
                            }
                        }
                    }
                ],
                //行操作按钮定义
                [

                ],
                // 在每次table被draw完后回调函数
                function () {
                     var api = this.api();
                    console.log(api.context[0].json);
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
            $("#myModalLabel").html(data.nickname+"的账单明细");
            showDetailUpdate(data.trade_id);
        });

        function showDetailUpdate(trade_id){
             $.ajax({
                 type: "POST",
                url: agdress.CONSTS.URL_BASE_API + "ss_ac_detail/findById",
                data:  {
                        "trade_id" : trade_id
                },
                async: false,
                success: function (data) {
                     if (data.message == "succeed") {
                         var tradepd=data.data;
                         console.log(tradepd);
                         $(".trade_id").val(tradepd.trade_id);
                         $(".user_id").html(tradepd.user_id);
                         $(".nickname").html(tradepd.nickname);
                         $(".phone").html(tradepd.phone);
                         //银行卡
                         $(".card_bank").html(tradepd.card_bank);
                         $(".card_no").html(tradepd.card_no);
                         $(".card_name").html(tradepd.card_name);
                          //余额以及总额
                         $(".balance").html(tradepd.balance);
                         $(".action_totle").html(tradepd.action_totle);
                         $("#editModal").modal("show");
                    }else{
                        alert("信息有误");
                    }
                }
            });
         }


        //审核通过按钮
        $("#okOne").on("click", function () {
            layer.confirm('<span style="color:red">确定审核通过吗？</span>', {
                title:"警告",
                btn: ['确认','取消'] //按钮
            }, function(index){
                changeTradeStatus("30");
                 layer.close(index);
            } , function(index){
                layer.close(index);
            });

        });

        //审核不通过通过按钮
        $("#errorOne").on("click", function () {
            layer.confirm('<span style="color:red">确定不通过审核吗？</span>', {
                title:"警告",
                btn: ['确认','取消'] //按钮
            }, function(index){
                changeTradeStatus("40");
                layer.close(index);
            } , function(index){
                layer.close(index);
            });

        });
        //改变审核状态
        function changeTradeStatus(trade_status){
            $.ajax({
                type: "POST",
                url: agdress.CONSTS.URL_BASE_API +"ss_ac_detail/updateAccountDetailInfor",
                data: {
                    "trade_id":$(".trade_id").val(),
                    "trade_status":trade_status
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
        }



     });
</script>
