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
                <label for="bgLoginId" class="col-sm-1 control-label">用户ID</label>
                 <div class="col-sm-2" >
                    <input type="text" name="bgLoginId" id="bgLoginId" class="form-control">
                </div>
                <label for="date1" class="col-sm-1 control-label">创建时间</label>
                <div class="col-sm-2" >
                    <input type="text" name="date1" id="date1" class="form-control" style="width: 100%;">
                    <input type="text" id = "createStartTime" name="createStartTime" class="form-control" style="display: none"/>
                    <input type="text" id = "createEndTime" name="createEndTime" class="form-control" style="display: none;"/>
                </div>
             </div>
            <div class="form-group">
                <label for="tradeKind" class="col-sm-1 control-label">事件</label>
                <div class="col-sm-2">
                    <select id ="tradeKind" name="tradeKind" class="form-control">
                        <option value="">全部</option>
                        <option value="1">入金</option>
                        <option value="-1">出金</option>
                     </select>
                </div>
                <label for="tradeType" class="col-sm-1 control-label">出入金方式</label>
                <div class="col-sm-2">
                    <select id ="tradeType" name="tradeType" class="form-control">
                        <option value="">全部</option>
                        <option value="10">充值</option>
                        <option value="20">游戏转码</option>
                        <option value="3040">游戏赢利/赔付</option>
                         <option value="50">提现</option>
                    </select>
                </div>
                <label for="tradeStatus" class="col-sm-1 control-label">状态</label>
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
            <th style="width: 10%;">用户ID</th>
            <th style="width: 10%;">昵称</th>
            <th style="width: 10%;">事件</th>
            <th style="width: 10%;">出入金方式</th>
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
                    <input type="hidden"  class="tradeId" value="">
                     <%--个人信息--%>
                    <div class="form-group"  >
                        <label class="col-sm-4 control-label" >用户信息</label>
                     </div>
                    <div class="form-group"  >
                        <label class="col-sm-4 control-label">用户ID</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control bgLoginId"  disabled >
                            <input type="hidden" class="form-control userId"  disabled >
                        </div>
                    </div>
                    <div class="form-group"  >
                        <label class="col-sm-4 control-label">用户名称</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control nickName"  disabled >
                        </div>
                    </div>
                    <div class="form-group"  >
                        <label class="col-sm-4 control-label">用户手机号</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control phone"  disabled >
                        </div>
                    </div>

                    <%--账户信息--%>
                    <div class="form-group"  >
                        <label class="col-sm-4 control-label" >账户信息</label>
                    </div>
                    <div class="form-group"  >
                        <label class="col-sm-4 control-label">账户余额</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control balance"  disabled >
                        </div>
                    </div>
                    <div class="form-group"  >
                        <label class="col-sm-4 control-label">可转出余额</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control actionTotle"  disabled >
                        </div>
                    </div>
                     <%--卡号信息--%>
                    <div class="form-group"  >
                        <label class="col-sm-4 control-label" >银行卡信息</label>
                    </div>
                    <div class="form-group"  >
                        <label class="col-sm-4 control-label">卡号</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control cardNo"  disabled >
                        </div>
                    </div>
                    <div class="form-group"  >
                        <label class="col-sm-4 control-label">持卡人</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control cardName"  disabled >
                        </div>
                    </div>
                    <div class="form-group"  >
                        <label class="col-sm-4 control-label">开户行</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control cardBank"  disabled >
                        </div>
                    </div>
                    <div class="form-group"  >
                        <label class="col-sm-4 control-label">申请转出金额</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control amount"  disabled >
                        </div>
                    </div>
                </form>

                <div class="text-center" style="margin-top: 50px">
                    <div class="btn-group">
                        <button type="button" class="btn btn-primary btn-lg" id="goEditRemarks">
                            审核
                        </button>
                    </div>
                     <button type="button" class="btn btn-default btn-lg" id="btnCancel">
                            返回列表
                    </button>
                </div>
            </div>
         </div>
    </div>
</div>

<div class="modal fade" id="editRemark" tabindex="-2" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header" >
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">&times;</span>
                    <span class="sr-only"></span>
                </button>
                <h4 class="modal-title">添加备注</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal"  id="editRemarkForm"  action="" method="post">
                    <div class="form-group">
                        <label class="col-sm-1 control-label"></label>
                        <div class="col-sm-9">
                            <textarea  style="margin: 0px; width: 100%; height: 100px;" class="remarks" name="remarks"></textarea>
                        </div>

                    </div>
                </form>
                <!-- modal-body END -->
                <div class="text-center">
                    <shiro:hasPermission name="5examine">
                        <div class="btn-group">
                            <button type="button" class="btn btn-primary btn-lg" id="okOne">
                                审核通过
                            </button>
                        </div>
                        <div class="btn-group" >
                            <button type="button" class="btn btn-primary btn-lg" id="errorOne">
                                审核不通过
                            </button>
                        </div>
                    </shiro:hasPermission>
                    <button type="button" class="btn btn-default btn-lg " id="backdetail">
                        返回详情
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

        $("input[name='date1']").daterangepicker(agdress.DATE_RANGE_PICKER_OPTIONS,
            function(start, end, label) {
                $("#createStartTime").val(start.format("YYYY/MM/DD"));
                $("#createEndTime").val(end.format("YYYY/MM/DD"));
            });

        var id = agdress.getQueryString("userId");
        $("input[name=userId]").val(id);
        var tradeType = agdress.getQueryString("tradeType");
        $("#tradeType").val(tradeType);
        //添加、修改异步提交地址
        var str = "";
        <shiro:hasPermission name="5examine">
        str+= "<div class='btn-group'>" +
            "<button   class='btn btn-danger btn-sm audit' type='button'> 审核</button>" +
            "</div>"
        </shiro:hasPermission>

        var role_ids=<shiro:principal property="rolesstr" />+"";

        var tables = $("#dataTable").dataTable(
            //URL
            agdress.getDatatableSettings('ss_ac_detail/dataGrid',
                //查询条件
                'queryForm',
                //对应上面thead里面的序列
                [
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
                    },
                    {
                        "data": 'tradeStatusEnum',
                        "render": function (data, type, full, callback) {
                            return data.code == 0  && full.tradeTypeEnum.code ==50 && role_ids.indexOf(full.roleId) >= 0?str:''
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

        //返回列表
        $("#btnCancel").on("click", function () {
            window.location.reload();
        });

        //返回详情
        $("#backdetail").on("click", function () {
            $("#editRemark").modal("hide");
        });

        //查看详情
        $("#dataTable tbody").on("click", ".audit", function () {
            var data = tables.api().row($(this).parents("tr")).data();
            $("#myModalLabel").html(data.nickName+"的账单明细");
            showDetailUpdate(data.tradeId);
        });

        function showDetailUpdate(tradeId){
             $.ajax({
                 type: "POST",
                url: agdress.CONSTS.URL_BASE_API + "ss_ac_detail/findById",
                data:  {
                        "tradeId" : tradeId
                },
                async: false,
                success: function (data) {
                     if (data.message == "succeed") {
                         var tradepd=data.data;
                         console.log(tradepd);
                         $(".tradeId").val(tradepd.tradeId);
                         $(".userId").val(tradepd.userId);
                         $(".bgLoginId").val(tradepd.bgLoginId);
                         $(".nickName").val(tradepd.nickName);
                         $(".phone").val(tradepd.phone);
                         //银行卡
                         $(".cardBank").val(tradepd.cardBank);
                         $(".cardNo").val(tradepd.cardNo);
                         $(".cardName").val(tradepd.cardName);
                          //余额以及总额
                         $(".balance").val(tradepd.balance);
                         $(".actionTotle").val(tradepd.actionTotle);
                         $(".amount").val(tradepd.amount);
                         $("#editModal").modal("show");
                    }else{
                        alert("信息有误");
                    }
                }
            });
         }

        /**
         * 开启修改备注页面
         */
        $("#goEditRemarks").on("click", function () {
            $("#editRemark").modal("show");
        });


        //审核通过按钮
        $("#okOne").on("click", function () {
            layer.confirm('<span style="color:red">确定审核通过吗？</span>', {
                title:"警告",
                btn: ['确认','取消'] //按钮
            }, function(index){
                 changeTradeStatus("true");
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
                if($(".remarks").val() == ""){
                    layer.msg("备注信息不能为空", {icon: 2});
                }else{
                    changeTradeStatus("false");
                }
                layer.close(index);
            } , function(index){
                layer.close(index);
            });

        });
        //改变审核状态
        function changeTradeStatus(flag){
            $.ajax({
                type: "POST",
                url: agdress.CONSTS.URL_BASE_API +"ss_ac_detail/updateAccountDetailInfor",
                data: {
                    "tradeId":$(".tradeId").val(),
                    "examine":flag,
                    "remarks":$(".remarks").val(),
                    "updateBy"  : <shiro:principal property="id"/>
                },
                async: false,
                success: function (data) {
                    $("#okOne").remove();
                    $("#errorOne").remove();
                    layer.msg('审核处理完成！');
                },error: function(error) {
                    layer.msg(error.responseText, {icon: 2});
                }
            });
        }



     });
</script>