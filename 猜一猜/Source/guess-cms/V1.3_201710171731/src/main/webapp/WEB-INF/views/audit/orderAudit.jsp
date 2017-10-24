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
                <%--<label for="create_date" class="col-sm-1 control-label">下单时间</label>--%>
                <%--<div class="col-sm-2" >--%>
                    <%--<input type="text" name="create_date" id="create_date" class="form-control" style="width: 120%;">--%>
                    <%--<input type="text" id = "startTime" name="startTime" class="form-control" style="display: none"/>--%>
                    <%--<input type="text" id = "endTime" name="endTime" class="form-control" style="display: none;"/>--%>
                <%--</div>--%>
                <label for="addr_contact" class="col-sm-1 control-label">收货人姓名</label>
                <div class="col-sm-2" >
                    <input type="text" name="addr_contact" id="addr_contact" class="form-control">
                </div>
                <label for="addr_tel" class="col-sm-1 control-label">收货人电话</label>
                <div class="col-sm-2" >
                    <input type="text" name="addr_tel" id="addr_tel" class="form-control">
                </div>
                <label for="orderStatus" class="col-sm-1 control-label">订单状态</label>
                <div class="col-sm-2">
                    <select id ="orderStatus" name="orderStatus" class="form-control">
                        <option value="">全部</option>
                        <%--<option value="10">已下单</option>--%>
                        <option value="20">待审核</option>
                        <option value="25">待发货</option>
                        <option value="30">配送中</option>
                        <%--<option value="40">已收货</option>--%>
                        <%--<option value="50">退货中</option>--%>
                        <%--<option value="60">退款中</option>--%>
                        <option value="70">审核不通过</option>
                        <%--<option value="99">已取消</option>--%>
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

    <div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">

                <div class="modal-header" >
                    <button type="button" class="close" data-dismiss="modal">
                        <span aria-hidden="true">&times;</span>
                        <span class="sr-only"></span>
                    </button>
                    <h4 class="modal-title" id="myModalLabel">兑换详情</h4>
                </div>

                <div class="modal-body">
                    <form class="form-horizontal"  id="editModalForm" action="" method="post">
                        <input type="hidden" class="form-control orderId" name="orderId" >
                        <div class="form-group">
                            <label class="col-sm-3 control-label">商品信息</label>
                          </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">商品名称</label>
                            <div class="col-sm-3">
                                <input type="text" class="form-control"   id="itemName" disabled>
                             </div>
                            <label class="col-sm-2 control-label">数量</label>
                            <div class="col-sm-3">
                                <input type="text" class="form-control"   id="qty" disabled>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">用户信息</label>
                            <div class="col-sm-8">
                                <div  style="float: right;color: #00a7d0;cursor: pointer;" class="lookdetail" >查看明细</div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">用户ID</label>
                            <div class="col-sm-3">
                                <input type="text" class="form-control"   id="clientId" disabled>
                             </div>
                            <label class="col-sm-2 control-label">用户昵称</label>
                            <div class="col-sm-3">
                                <input type="text" class="form-control"   id="clientName" disabled>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">账号余额</label>
                            <div class="col-sm-3">
                                <input type="text" class="form-control"   id="coinBalance" disabled>
                             </div>
                        </div>
                         <div class="form-group">
                            <label class="col-sm-3 control-label">物流信息</label>
                            <div class="col-sm-8">
                                <div id="goEditAddress"  style="float: right;color: #00a7d0;cursor: pointer;" >修改地址</div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">收货人</label>
                            <div class="col-sm-3">
                                <input type="text" class="form-control"   id="addrContact" disabled>
                            </div>
                            <label class="col-sm-2 control-label">手机电话</label>
                            <div class="col-sm-3">
                                <input type="text" class="form-control"   id="addrTel" disabled>
                             </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">收货地址</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control"   id="addr2" disabled>
                             </div>
                        </div>
                         <div class="form-group">
                            <label class="col-sm-3 control-label">备注</label>
                            <div class="col-sm-8">
                                 <div id="goEditRemarks"  style="float: right;color: #00a7d0;cursor: pointer;" >修改备注</div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">当前备注</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control"   id="remarks" disabled>
                             </div>
                        </div>

                     </form>

                    <div class="text-center" style="margin-top: 50px">
                        <button type="button"   class="btn btn-primary btn-lg" onclick="changeStatus('true')">审核通过</button>
                        <button type="button"   class="btn btn-primary btn-lg" onclick="changeStatus('false')">不通过审核</button>
                        <button type="button" class="btn btn-default btn-lg" id="btnClose">
                             返回列表
                        </button>
                    </div>
                </div>
               </div>
        </div>
    </div>



    <div class="modal fade" id="editAddress" tabindex="-2" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">

                <div class="modal-header" >
                    <button type="button" class="close" data-dismiss="modal">
                        <span aria-hidden="true">&times;</span>
                        <span class="sr-only"></span>
                    </button>
                    <h4 class="modal-title">管理收货地址</h4>
                </div>

                <div class="modal-body">
                    <form class="form-horizontal" id="editAddressForm" action="" method="post">
                         <div class="form-group">
                            <label class="col-sm-1 control-label"></label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control addrContact" name="addrContact" placeholder="收货人姓名" >
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-1 control-label"></label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control addrTel" name="addrTel" placeholder="手机号">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-1 control-label"></label>
                            <div class="col-sm-3">
                                <select  class="form-control province" title="省" name="province"  onchange="getAllcity(this,'city')">
                                     <option value="">省</option>
                                </select>
                            </div>
                            <div class="col-sm-3">
                                <select  class="form-control city" title="市" name="city" onchange="getAllarea(this,'area')">
                                    <option value="">市</option>
                                </select>
                            </div>
                            <div class="col-sm-3">
                                <select  class="form-control area" title="区" name="area">
                                    <option value="">区</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-1 control-label"></label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control street" name="street" placeholder="详细地址">
                            </div>
                        </div>
                        <div class="text-center" style="margin-top: 50px">
                            <button type="submit"   class="btn btn-primary btn-lg">确认修改</button>
                            <button type="button" class="btn btn-default btn-lg back"  >
                                返回详情
                            </button>
                        </div>
                    </form>
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
                    <h4 class="modal-title">修改备注</h4>
                </div>
                 <div class="modal-body">
                    <form class="form-horizontal"  id="editRemarkForm"  action="" method="post">
                         <div class="form-group">
                             <label class="col-sm-1 control-label"></label>
                             <div class="col-sm-9">
                                 <textarea  style="margin: 0px; width: 100%; height: 223px;" class="remarks" name="remarks" ></textarea>
                             </div>

                        </div>
                     </form>
                     <div class="text-center" style="margin-top: 50px">
                         <button type="button"   class="btn btn-primary btn-lg" id="sureRemarks">确认修改</button>
                         <button type="button" class="btn btn-default btn-lg back"  >
                             返回详情
                         </button>
                     </div>
                </div>
             </div>
        </div>
    </div>

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
<script src="<%=request.getContextPath()%>/bootstrap/js/bootstrapValidator.js"></script>
<script>
    $(function () {
        cicada.CONSTS.URL_BASE = "<%=SystemConfig.getInstance().getURL_BASE()%>";
        cicada.CONSTS.URL_BASE_API = "<%=SystemConfig.getInstance().getURL_BASE_API()%>";
        cicada.CONSTS.URL_BASE_IMG = "<%=SystemConfig.getInstance().getURL_BASE_IMG()%>";
        cicada.CONSTS.URL_BASE_IMG_TASK = "<%=SystemConfig.getInstance().getURL_BASE_IMG_TASK()%>";


        $("input[name='create_date']").daterangepicker(cicada.DATE_RANGE_PICKER_OPTIONS,
            function(start, end, label) {
                $("#startTime").val(start.format("YYYY/MM/DD"));
                $("#endTime").val(end.format("YYYY/MM/DD"));
            });

        //添加、修改异步提交地址
        var str = "";
        <shiro:hasAnyRoles name = "admin">
        str+= "<div class='btn-group'>" +
            "<button id='orderAudit' class='btn btn-danger btn-sm' type='button'> 审核</button>" +
            "</div>"
        </shiro:hasAnyRoles>

        var tables = $("#dataTable").dataTable(
            //URL
            cicada.getDatatableSettings('order/list',
                //查询条件
                'queryForm',
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
                            return data + '[' + rowData.clientId+']'
                        }
                    },
                    {"data": 'addrTel'},
                    {
                        "data": 'orderStatus',
                        "render":function (data,type,rowData,callback) {
                            return data.desc;
                        }
                    },
                    {
                        "data": 'orderStatus',
                        "render":function (data,type,rowData,callback) {
                            if(data.code == 20){  return str}else{ return ""}
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

        //关闭页面
        $("#btnClose").on('click',function () {
            window.location.reload();
        });

        //查看详情
        $("#dataTable tbody").on("click", "#orderAudit", function () {
            var data = tables.api().row($(this).parents("tr")).data();
            $(".orderId").val(data.orderId);
            $("#itemName").val(data.itemName);
            $("#qty").val(data.qty);
            $("#clientId").val(data.clientId);
            $("#clientName").val(data.clientName);
            $("#coinBalance").val(data.coinBalance);
            $("#addrContact").val(data.addrContact);
            $("#addrTel").val(data.addrTel);
            $("#addr2").val(data.addr2);
            $("#remarks").val(data.remarks);
             $("#editModal").modal("show");
            $(".addrContact").attr("value",data.addrContact);
            $(".addrTel").attr("value",data.addrTel);
            $(".street").attr("placeholder",data.addr2);
            $(".remarks").val(data.remarks);
             allajaxList("0","province");
         });


        //开启修改地址页面
        $("#goEditAddress").on("click", function () {
            $("#editAddress").modal("show");
         });


        //开启修改备注页面
        $("#goEditRemarks").on("click", function () {
             $("#editRemark").modal("show");
          });

        //返回详情
        $(".back").on("click", function () {
            $("#editRemark").modal("hide");
            $("#editAddress").modal("hide");
         });

        //确认修改备注
        $("#sureRemarks").on("click", function () {
            var orderId = $(".orderId").val();
            console.log($(".remarks").val());
            $.ajax({
                cache: false,
                type: "POST",
                url: cicada.CONSTS.URL_BASE_API+"order/updateOrder",
                data: {"orderId":orderId,"remarks":$(".remarks").val()},
                async: false,
                success: function (data) {
                    if (data.data == true) {
                        $("#editRemark").modal("hide");
                        layer.msg('修改成功！');
                        $("#remarks").val($(".remarks").val());
                     } else {
                        layer.msg('修改失败！');
                    }
                }
            });


        });

        //查看
        $(".lookdetail").on("click", function () {
             var url = 'client/detail?userid='+$("#clientId").val();
            var id = "user_"+$("#clientId").val();
            var title = "玩家详情【"+$("#clientName").val()+"】";
            window.parent.openNewTab(id,title,url);
            return;
        });





        //更新地址的表单验证
        $("#editAddressForm").bootstrapValidator({
            message: 'This value is not valid',
            feedbackIcons: {/*输入框不同状态，显示图片的样式*/
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {/*验证*/
                addrContact: {/*键名task_content和input name值对应*/
                    validators: {
                        notEmpty: {/*非空提示*/
                            message: '请输入收货人！'
                        },
                        stringLength: {/*长度提示*/
                            min: 1,
                            max: 10,
                            message: '请输入1到10个汉字！'
                        }
                    }
                },
                addrTel: {/*键名task_content和input name值对应*/
                    validators: {
                        notEmpty: {/*非空提示*/
                            message: '请输入电话！'
                        },
                        regexp: {
                            regexp: /^(13[0-9]|15[0-9]|18[0-9]|147|145|149|170|171|173|175|176|177|178)\d{8}$/,
                            message: '请输入正确的电话！'
                        }
                    }
                },
                province: {/*键名task_content和input name值对应*/
                    validators: {
                        notEmpty: {/*非空提示*/
                            message: '请选择省！'
                        }
                    }
                },
                city: {/*键名task_content和input name值对应*/
                    validators: {
                        notEmpty: {/*非空提示*/
                            message: '请选择市！'
                        }
                    }
                },
                area: {/*键名task_content和input name值对应*/
                    validators: {
                        notEmpty: {/*非空提示*/
                            message: '请选择区！'
                        }
                    }
                },
                street: {/*键名task_content和input name值对应*/
                    validators: {
                        notEmpty: {/*非空提示*/
                            message: '请输入街道！'
                        },
                        stringLength: {/*长度提示*/
                            min: 3,
                            max: 20,
                            message: '请输入3到20个汉字！'
                        }
                    }
                }
            }
        }).on('success.form.bv', function(e) {//点击提交之后
            // Prevent form submission
            e.preventDefault();
             // Use Ajax to submit form data 提交至form标签中的action，result自定义
            var address= $(".province").find("option:selected").text()+ $(".city").find("option:selected").text()+ $(".area").find("option:selected").text()+$(".street").val();
            $.ajax({
                cache: false,
                type: "post",
                url: cicada.CONSTS.URL_BASE_API+"order/updateOrder",
                data: {
                        "orderId":$(".orderId").val(),
                        "addrContact":$(".addrContact").val(),
                        "addrTel":$(".addrTel").val(),
                        "addr2": address
                },
                async: false,
                success: function (data) {
                    if (data.data == true) {
                        $("#editAddress").modal("hide");
                        layer.msg('修改成功！');
                        $("#addrContact").val($(".addrContact").val());
                        $("#addrTel").val($(".addrTel").val());
                        $("#addr2").val(address);
                    } else {
                        layer.msg('修改失败！');
                    }
                }
            });

        });

    });

    /**
     * 改变审核状态
     * @param orderStatus
     */
    function changeStatus(flag) {
        var orderId = $(".orderId").val();
        var str="";
        if(flag == "true"){
            str="确定审核通过吗?"
        }else{
            str="确定不通过审核吗?"
        }
        layer.confirm("<span style='color:red'>"+str+"</span>", {
            title:"警告",
            btn: ['确认','取消'] //按钮
        }, function(index){
            var data = {"orderId":orderId,"isok":flag};
            cicada.post('order/audit',JSON.stringify(data ),function (result) {
                layer.msg('审核处理成功！');
                $("#btnClose").click();
             },function (err) {
                layer.msg(err.message, {icon: 2});
            },"application/json");

            layer.close(index);
        },  function(index){
            layer.close(index);
        });
      }

      //获取省市区
      function getAllcity(obj,objClass) {
          allajaxList($(obj).val(),objClass);
      }
      function getAllarea(obj,objClass) {
          allajaxList($(obj).val(),objClass);
      }
      function allajaxList(parent_code,objClass) {
           $.ajax({
              cache: false,
              type: "post",
              url: cicada.CONSTS.URL_BASE_API+"order/getAllAddress",
              data: {
                  "parentCode":parent_code
               },
              async: false,
              success: function (data) {
                  console.log(data)
                  var addressList = data.data;
                  $("."+objClass).empty();
                  $("."+objClass).append("<option value=''>请选择</option>");
                  for(var i=0;i<addressList.length;i++){
                      $("."+objClass).append("<option value='"+addressList[i].code+"'>"+addressList[i].name+"</option>");
                  }
              }
          });
      }


</script>
