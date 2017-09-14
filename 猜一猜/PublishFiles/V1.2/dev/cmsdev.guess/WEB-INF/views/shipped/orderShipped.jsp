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
                <label for="orderId" class="col-sm-1 control-label">兑换单号</label>
                <div class="col-sm-2" >
                    <input type="text" name="orderId" id="orderId" class="form-control">
                </div>
                <label for="orderStatus" class="col-sm-1 control-label">订单状态</label>
                <div class="col-sm-2">
                    <select id ="orderStatus" name="orderStatus" class="form-control">
                        <option value="">全部</option>
                        <option value="25">待发货</option>
                        <option value="30">配送中</option>
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
            <th style="width: 20%;">商品名称</th>
            <th style="width: 10%;">数量</th>
             <th style="width: 10%;">收货人</th>
            <th style="width: 10%;">手机号</th>
            <th style="width: 10%;">收货地址</th>
            <th style="width: 10%;">备注</th>
            <th style="width: 10%;">状态</th>
            <th style="width: 10%;">操作</th>
        </tr>
        </thead>
        <tbody></tbody>
    </table>




    <div class="modal fade" id="editShippedDiv" tabindex="-2" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                 <div class="modal-header" >
                    <button type="button" class="close" data-dismiss="modal">
                        <span aria-hidden="true">&times;</span>
                        <span class="sr-only"></span>
                    </button>
                    <h4 class="modal-title">发货管理</h4>
                </div>
                 <div class="modal-body">
                    <form class="form-horizontal"  id="editShoppedForm"  action="" method="post">
                         <input type="hidden" class="form-control orderId" name="orderId" >
                         <div class="form-group">
                             <label class="col-sm-1 control-label"></label>
                             <div class="col-sm-9">
                                 <input type="number" class="form-control logistics_number" name="logistics_number" placeholder="填写物流单号">
                             </div>
                         </div>
                     </form>
                </div>
                <!-- modal-body END -->

                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" id="sureShipped">保存</button>
                    <button type="button"   class="btn btn-primary back "  >返回</button>
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
<script>
    $(function () {
        cicada.CONSTS.URL_BASE = "<%=SystemConfig.getInstance().getURL_BASE()%>";
        cicada.CONSTS.URL_BASE_API = "<%=SystemConfig.getInstance().getURL_BASE_API()%>";
        cicada.CONSTS.URL_BASE_IMG = "<%=SystemConfig.getInstance().getURL_BASE_IMG()%>";
        cicada.CONSTS.URL_BASE_IMG_TASK = "<%=SystemConfig.getInstance().getURL_BASE_IMG_TASK()%>";



        //添加、修改异步提交地址
        var str = "";
        <shiro:hasAnyRoles name = "admin">
        str+= "<div class='btn-group'>" +
            "<button  id='orderShippedMod' class='btn btn-danger btn-sm'  type='button'> 发货</button>" +
            "</div>"
        </shiro:hasAnyRoles>

        var tables = $("#dataTable").dataTable(
            //URL
            cicada.getDatatableSettings('order/listShipped',
                //查询条件
                'queryForm',
                //对应上面thead里面的序列
                [
                    {"data": "orderId"},
                    {"data": "itemName"},
                    {"data": 'qty'},
                    {
                        "data": 'addrContact',
                        "render": function (data,type,rowData,callback) {
                            console.log(rowData)
                            return data + '[' + rowData.clientId+']'
                        }
                    },
                    {"data": 'addrTel'},
                    {"data": 'addr2'},
                    {"data": 'remarks'},
                    {
                        "data": 'orderStatus',
                        "render":function (data,type,rowData,callback) {
                                return data.code == 25?data.desc:data.desc+"<br>"+rowData.logisticsNumber;
                           }
                    },
                    {
                        "data": 'orderStatus',
                        "render":function (data,type,rowData,callback) {
                             return data.code == 25?str:"";
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
        $(".back").on('click',function () {
            window.location.reload();
        });

        /**
         * 开启填写运单号界面
         */
        $("#dataTable tbody").on("click", "#orderShippedMod", function () {
            var data = tables.api().row($(this).parents("tr")).data();
            $(".orderId").val(data.orderId);
            $("#editShippedDiv").modal("show");
        });

         /**
         * 确认填写运单号-确认
         */
        $("#sureShipped").on("click", function () {
            var orderId = $(".orderId").val();
            if($(".logistics_number").val().trim() == ""){layer.msg("物流单号不能为空", {icon: 2}); return;}
            var data = {"orderId":orderId,"logisticsNumber":$(".logistics_number").val().trim()};
            cicada.post('order/shipped',JSON.stringify(data),function (result) {
                layer.msg('新增运单号成功！');
                $(".back").click();
            },function (err) {
                layer.msg(err.message, {icon: 2});
            },"application/json");
             layer.close(index);
          });

    });



</script>
