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
                <label for="userId" class="col-sm-1 control-label">用户ID</label>
                <div class="col-sm-2" >
                    <input type="text" name="userId" id="userId" class="form-control">
                </div>
                <label for="ywName" class="col-sm-1 control-label">业务员</label>
                <div class="col-sm-2" >
                    <input type="text" name="ywName" id="ywName" class="form-control">
                </div>
                <label for="phone" class="col-sm-1 control-label">手机号</label>
                <div class="col-sm-2" >
                    <input type="text" name="phone" id="phone" class="form-control">
                </div>
             </div>
            <div class="form-group">
                 <label for="date1" class="col-sm-1 control-label">注册时间</label>
                <div class="col-sm-2" >
                    <input type="text" name="date1" id="date1" class="form-control" style="width: 100%;">
                    <input type="text" id = "registerStartTime" name="registerStartTime" class="form-control" style="display: none"/>
                    <input type="text" id = "registerEndTime" name="registerEndTime" class="form-control" style="display: none;"/>
                </div>
                <label for="date2" class="col-sm-1 control-label">最近登录时间</label>
                <div class="col-sm-2" >
                    <input type="text" name="date2" id="date2" class="form-control" style="width: 100%;">
                    <input type="text" id = "loginStartTime" name="loginStartTime" class="form-control" style="display: none"/>
                    <input type="text" id = "loginEndTime" name="loginEndTime" class="form-control" style="display: none;"/>
                </div>
                <div class="col-sm-2" >
                        <shiro:hasPermission name="20search">
                        <button type="button" class="btn btn-primary btn-sm" id="btn-query">
                            <i class="fa fa-search"></i> 查询
                        </button>
                        </shiro:hasPermission>
                        <button type="button" class="btn btn-primary btn-sm" id="btn-re">
                            <i class="fa fa-refresh"></i> 刷新
                        </button>
                </div>
              </div>
         </form>
    </div>

    <!--表格-->
    <table id="dataTable" class="table table-striped table-bordered table-hover table-condensed" align="center">
        <thead>
        <tr class="info">
            <th style="width: 10%;">用户ID</th>
            <th style="width: 10%;">昵称</th>
            <th style="width: 20%;">手机号码</th>
            <th style="width: 10%;">银行卡是否绑定</th>
            <th style="width: 10%;">账户余额</th>
            <th style="width: 10%;">专属业务员</th>
            <th style="width: 10%;">注册时间</th>
            <th style="width: 10%;">最近上线时间</th>
            <th style="width: 10%;">操作</th>
        </tr>
        </thead>
        <tbody></tbody>
    </table>
</div>

<div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="width:65%;">
        <div class="modal-content" style=" width: 100%; ">
             <div class="modal-header" style=" width: 100%; ">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">&times;</span>
                    <span class="sr-only"></span>
                </button>
                <h4 class="modal-title" id="myModalLabel">信息修改</h4>
            </div>

            <div class="modal-body" style=" width: 100%; ">
                <form role="form" class="form-horizontal" id="detailForm" style=" width: 100%; ">
                    <input type="hidden"  class="only_id" value="">
                     <%--个人信息--%>
                    <div class="form-group" id="divAnswerRight">
                        <label class="col-sm-1 control-label" ></label>
                        <div class="col-sm-6">
                             <span style="display: block;float: left;width:20%">
                                 <img class="head_url" src="" style="display: block;width:100%;">
                             </span>
                             <span style="display: block; line-height: 45px;padding: 3px;float: right;letter-spacing:1px;width:75%;text-align: left;">
                                 <span class="nickname">我我我嚄我</span>
                                 <span>(ID：<span class="user_id">424156</span>)</span>
                             </span>
                             <span style="display: block;float: right;width:75%;">
                                    手机号码：
                                    <input type="text"  class="phone"  style="width:50%;"/>
                                    <shiro:hasPermission name="20update">
                                        <button type="button" class="btn btn-primary btn-sm" id="changephone">  修改 </button>
                                    </shiro:hasPermission>
                             </span>
                         </div>
                     </div>
                    <%-- 银行卡信息 --%>
                    <div class="form-group"  >
                        <label class="col-sm-1 control-label"></label>
                        <div class="col-sm-6">
                            <input  type="hidden" class="card_id" >
                            <span style="display: block;float: left;width:100%;padding-bottom: 10px;">银行卡号：<input style="width:76%;" type="text" class="card_no" ></span>
                            <span style="display: block;float: left;width:100%;padding-bottom: 10px;">&nbsp;&nbsp;&nbsp;持卡人：<input style="width:76%;" type="text" class="card_name" ></span>
                            <span style="display: block;float: left;width:100%;">&nbsp;&nbsp;&nbsp;开户行：<input style="width:76%;" type="text" class="card_bank" ></span>
                             <shiro:hasPermission name="20update">
                                <span style="display: block;float: right;width:20%;">
                                    <button type="button" class="btn btn-primary btn-sm" id="changebank">修改</button>
                                </span>
                            </shiro:hasPermission>
                        </div>
                        <label class="col-sm-1 control-label" ></label>
                        <div class="col-sm-3">
                            专属业务员：
                            <select style="width:50%;"  class="form-control beuserlist" >

                            </select>
                            <shiro:hasPermission name="20update">
                                <button type="button" class="btn btn-primary btn-sm" id="changeagent">修改</button>
                            </shiro:hasPermission>
                        </div>
                    </div>
                    <%-- 财富信息--%>
                    <div class="form-group"  >
                        <label class="col-sm-1 control-label"></label>
                        <div class="col-sm-6">
                            <input  type="hidden" class="account_id" >
                            <span style="display: block;float: left;width:100%;padding-bottom: 10px;">账号余额：<span class="balance"></span></span>
                            <span style="display: block;float: left;width:100%;padding-bottom: 10px;">
                                    充值金额：<input style="width:48%;" type="text" class="addbalance" ><button type="button" class="btn btn-primary btn-sm" id="changebalance">充值</button>
                            </span>
                            <span style="display: block;float: left;width:100%;padding-bottom: 10px;">转码总量：<span class="total_lottery"></span></span>
                         </div>
                        <label class="col-sm-1 control-label" ></label>
                        <div class="col-sm-3">
                            <span style="display: block;float: left;width:100%;padding-bottom: 10px;">
                                    充值总额：<span class="total_recharge"></span>
                                <shiro:hasPermission name="20detail"><button type="button" class="btn btn-primary btn-sm" id="listrecharge">查看明细</button></shiro:hasPermission>
                            </span>
                            <span style="display: block;float: left;width:100%;padding-bottom: 10px;">
                                    提现总额：<span class="total_withdraw"></span>
                                <shiro:hasPermission name="20detail"><button type="button" class="btn btn-primary btn-sm" id="listwithdraw">查看明细</button></shiro:hasPermission>
                            </span>
                            <span style="display: block;float: left;width:100%;padding-bottom: 10px;">
                                    赢输统计：<span class="action_totle"></span>
                                <shiro:hasPermission name="20detail"><button type="button" class="btn btn-primary btn-sm" id="listaction">查看明细</button></shiro:hasPermission>
                            </span>
                        </div>
                     </div>
                     <div class="form-group" >
                         <label class="col-sm-1 control-label"></label>
                         <div class="col-sm-6">
                             <span style="display: block;float: left;width:100%;padding-bottom: 10px;">最近登录：<span class="update_date"></span></span>
                         </div>
                         <label class="col-sm-1 control-label" ></label>
                         <div class="col-sm-3">
                             <span style="display: block;float: left;width:100%;padding-bottom: 10px;">注册时间：<span class="create_date"></span></span>
                         </div>
                    </div>
                    <div class="from-group text-center">
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
                $("#registerStartTime").val(start.format("YYYY/MM/DD"));
                $("#registerEndTime").val(end.format("YYYY/MM/DD"));
            });
        $("input[name='date2']").daterangepicker(agdress.DATE_RANGE_PICKER_OPTIONS,
            function(start, end, label) {
                $("#loginStartTime").val(start.format("YYYY/MM/DD"));
                $("#loginEndTime").val(end.format("YYYY/MM/DD"));
            });



        //添加、修改异步提交地址
        var str = "";
        <shiro:hasPermission name="20detail">
             str+= "<div class='btn-group' style='margin-right: 5px;'>" +
            "<button  class='btn btn-primary btn-sm todetail'  id='btn-query'  type='button'> 详情</button>" +
            "</div>"
        </shiro:hasPermission>
        <shiro:hasPermission name="20update">
        str+= "<div class='btn-group'>" +
            "<button  class='btn btn-primary btn-sm todetail'  id='btn-query'  type='button'> 修改</button>" +
            "</div>"
        </shiro:hasPermission>



        var tables = $("#dataTable").dataTable(
            //URL
            agdress.getDatatableSettings('ss_user/dataGrid',
                //查询条件
                'queryForm',
                //对应上面thead里面的序列
                [
                    {"data": "userId"},
                    {"data": "nickName"},
                    {"data": 'phone'},
                    {
                        "data": 'cardNumber',
                        "render": function (data, type, full, callback) {
                            if(parseInt(data) >0  ){
                                return "是"
                            }else{
                                return "否"
                            }
                          }
                    },
                    {"data": 'balance'},
                    {"data": 'ywName'},
                    {
                        "data": 'createDate',
                        "render": function (data, type, full, callback) {
                            return agdress.timeStamp2String(data)
                        }
                    },
                    {
                        "data": 'updateDate',
                        "render": function (data, type, full, callback) {
                            return agdress.timeStamp2String(data)
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
        $("#dataTable tbody").on("click", ".todetail", function () {
            var data = tables.api().row($(this).parents("tr")).data();
            $("#myModalLabel").html(data.nickName+"的资料明细");
            showDetailUpdate(data.userId);
        });

        function showDetailUpdate(userId){
             var url=agdress.CONSTS.URL_BASE_API+"ss_user/findById";
             $.ajax({
                  type: "POST",
                 url: url,
                 data:  {
                        "userId" : userId
                 },
                 async: false,
                 success: function (data) {
                     if (data.message == "succeed") {
                        var usepd=data.data;
                         $(".only_id").val(usepd.user_id);
                         $(".phone").val(usepd.phone);
                         $(".user_id").html(usepd.user_id);
                         $(".nickname").html(usepd.nickname);
                         $(".head_url").attr("src",usepd.head_url);
                         $(".create_date").html( agdress.timeStamp2String(usepd.create_date));
                         $(".update_date").html(agdress.timeStamp2String(usepd.update_date));
                         //银行卡
                         $(".card_bank").val(usepd.card_bank);
                         $(".card_no").val(usepd.card_no);
                         $(".card_name").val(usepd.card_name);
                         $(".card_id").val(usepd.card_id);
                         //余额以及总额
                         $(".account_id").val(usepd.account_id);
                         $(".balance").html(usepd.balance);
                         $(".total_recharge").html(usepd.total_recharge);
                         $(".total_withdraw").html(usepd.total_withdraw);
                         $(".action_totle").html(usepd.action_totle);
                         $(".total_lottery").html(usepd.total_lottery);
                         //循环业务员
                        var beuserlist=usepd.beuserlist;
                         $(".beuserlist").empty();
                        for(var i =0 ;i <beuserlist.length ; i++){
                            $(".beuserlist").append("<option value="+beuserlist[i].userId+">"+beuserlist[i].nickname+"</option>");
                        }
                         $(".beuserlist").val(usepd.be_user_id);
                        $("#editModal").modal("show");
                    }else{
                        alert("信息有误");
                    }
                }
            });
         }


        //修改电话号码
        $("#changephone").on("click", function () {
            $.ajax({
                type: "POST",
                url: agdress.CONSTS.URL_BASE_API+"ss_user/updateUserInfor",
                data: {
                        "userId":$(".only_id").val() ,
                        "phone" :$(".phone").val()
                },
                async: false,
                 success: function (data) {
                    if (data.data == true) {
                        layer.msg('修改成功！');
                    } else {
                        alert("修改失败")
                    }
                }
            });
        });

        //修改银行卡信息
        $("#changebank").on("click", function () {;
            $.ajax({
                type: "POST",
                url: agdress.CONSTS.URL_BASE_API+"ss_user/updateUserBank",
                data: {
                        "card_id":$(".card_id").val(),
                        "card_name":$(".card_name").val(),
                        "card_no":$(".card_no").val(),
                        "card_bank":$(".card_bank").val()
                },
                async: false,
                success: function (data) {
                    if (data.data == true) {
                        layer.msg('修改成功！');
                    } else {
                        alert("修改失败")
                    }
                }
            });
        });

        //修改业务员
        $("#changeagent").on("click", function () {
            $.ajax({
                type: "POST",
                url: agdress.CONSTS.URL_BASE_API+"ss_user/updateUserInfor",
                data: {
                        "userId":$(".only_id").val(),
                        "be_user_id":$(".beuserlist").val()
                },
                async: false,
                success: function (data) {
                    if (data.data == true) {
                        layer.msg('修改成功！');
                     } else {
                        alert("修改失败")
                    }
                }
            });
         });

        //充值余额
        $("#changebalance").on("click", function () {
            layer.confirm('<span style="color:red">确定充值金额吗？</span>', {
                title:"警告",
                btn: ['确认','取消'] //按钮
            }, function(index){
                $.ajax({
                    type: "POST",
                    url: agdress.CONSTS.URL_BASE_API+"ss_user/updateUserBalance",
                    data: {
                        "account_id":$(".account_id").val(),
                        "addbalance":$(".addbalance").val()
                    },
                    async: false,
                    success: function (data) {
                        if (data.data == true) {
                            layer.msg('充值成功！');
                            var now=parseFloat($(".balance").html())+parseFloat($(".addbalance").val());
                            $(".balance").html(now);
                        } else {
                            layer.msg('充值失败！');
                        }
                    }
                });
                layer.close(index);
            } , function(index){
                layer.close(index);
            });

        });

        //查看充值记录
        $("#listrecharge").on("click", function () {
            layer.msg('请前往账户管理-账号出入金明细表查看');
        });

        //查看提现记录
        $("#listwithdraw").on("click", function () {
            layer.msg('请前往账户管理-账号出入金明细表查看');
        });

        //查看输赢记录
        $("#listaction").on("click", function () {
            layer.msg('请前往账户管理-账号出入金明细表查看');
        });


     });
</script>
