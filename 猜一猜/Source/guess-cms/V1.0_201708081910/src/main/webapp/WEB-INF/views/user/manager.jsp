<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>  
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>侧边栏</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/dist/css/font-awesome.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/dist/css/ionicons.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/dist/css/AdminLTE.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/dist/css/skins/all-skins.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/plugins/datatables/jquery.dataTables.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/plugins/datatables/dataTables.bootstrap.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap/css/bootstrap-treeview.min.css">
</head>
<body style="overflow: hidden" class="sidebar-mini">
<!-- 查询、添加、批量删除、导出、刷新 -->
<div class="content">
    <!-- 查询、添加、批量删除、导出、刷新 -->
    <div class="row-fluid">
        <div class="pull-right">
            <div class="btn-group">
                <button type="button" class="btn btn-primary btn-sm" id="btn-add">
                    <i class="fa fa-plus"></i> 添加
                </button>
                <button type="button" class="btn btn-primary btn-sm" id="btn-delAll">
                    <i class="fa fa-remove"></i> 删除
                </button>
                <button type="button" class="btn btn-primary btn-sm" id="btn-export">
                    <i class="fa fa-sign-in"></i> 导出
                </button>
                <button type="button" class="btn btn-primary btn-sm" id="btn-re">
                    <i class="fa fa-refresh"></i> 刷新
                </button>
            </div>
        </div>

        <div class="row">
            <form id="queryForm" action="" method="post">
                <div class="col-xs-2">
                    <input type="text" id="keyword" name="keyword" class="form-control input-sm"
                           placeholder="搜索"/>
                </div>
                <button type="button" class="btn btn-primary btn-sm" id="btn-query">
                    <i class="fa fa-search"></i> 查询
                </button>
            </form>
        </div>
    </div>

    <!--表格-->
    <table id="dataTable" class="table table-striped table-bordered table-hover table-condensed" align="center">
        <thead>
        <tr class="info">
            <!--<td><input type="checkbox" id="checkAll"></td>-->
            <th></th>
            <th>序号</th>
            <th>用户</th>
            <th>权限</th>
            <th>电话</th>
            <th>创建时间</th>
            <th>操作</th>
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
                    <h4 class="modal-title" id="myModalLabel">信息修改</h4>
                </div>

                <div class="modal-body">
                    <form class="form-horizontal"  id="editForm" action="" method="post">
                        <input type="hidden" class="form-control" name="areaId">
                        <div class="form-group">
                            <label for="inputName" class="col-sm-3 control-label">姓名</label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" name="areaNameCn">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputName" class="col-sm-3 control-label">手机</label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" name="areaNameEn">
                            </div>
                        </div>
                    </form>
                </div>
                <!-- modal-body END -->

                <div class="modal-footer">
                    <button type="submit" id="btn-submit" class="btn btn-primary">确认</button>
                </div>
            </div>
        </div>
    </div>

</div>

</body>
</html>
<script src="<%=request.getContextPath()%>/plugins/jQuery/jquery-2.2.3.min.js"></script>
<script src="<%=request.getContextPath()%>/bootstrap/js/bootstrap.min.js"></script>
<script src="<%=request.getContextPath()%>/plugins/datatables/dataTables.bootstrap.min.js"></script>
<script src="<%=request.getContextPath()%>/plugins/datatables/jquery.dataTables.js"></script>
<script src="<%=request.getContextPath()%>/plugins/slimScroll/jquery.slimscroll.min.js"></script>
<script src="<%=request.getContextPath()%>/plugins/fastclick/fastclick.js"></script>
<script src="<%=request.getContextPath()%>/dist/js/app.min.js"></script>
<script src="<%=request.getContextPath()%>/dist/js/demo.js"></script>
<script src="<%=request.getContextPath()%>/plugins/datatables/dataTables.bootstrap.js"></script>
<script src="<%=request.getContextPath()%>/plugins/datatables/jquery.dataTables.js"></script>
<%--<script src="<%=request.getContextPath()%>/bootstrap/js/bootstrap-treeview.min.js"></script>--%>
<script>
    $(function () {
//添加、修改异步提交地址
		var str = "";
    	<shiro:hasAnyRoles name = "admin">
    	 str+= "<div class='btn-group'>" +
         "<button id='editRow' class='btn btn-primary btn-sm' type='button'><i class='fa fa-edit'></i></button>" +
         "<button id='delRow' class='btn btn-primary btn-sm' type='button'><i class='fa fa-trash-o'></i></button>" +
         "</div>"
    	 </shiro:hasAnyRoles>
         
        var url = "";
        var tables = $("#dataTable").dataTable({
            serverSide: true,//分页，取数据等等的都放到服务端去
//            processing: true,//载入数据的时候是否显示“载入中”
            pageLength: 10,  //首次加载的数据条数
            ordering: false, //排序操作在服务端进行，所以可以关了。
            pagingType: "full_numbers",
            autoWidth: true,
            stateSave: true,//保持翻页状态，和comTable.fnDraw(false);结合使用
            searching: false,//禁用datatables搜索
            ajax: {
                type: "post",
                url: "<%=request.getContextPath()%>dataGrid",
                dataSrc: "data",
                dataType:'json',
//                data: function (d) {
//                    var param = {};
//                    param.draw = d.draw;
//                    param.start = d.start;
//                    param.length = d.length;
//                    var formData = $("#queryForm").serializeArray();//把form里面的数据序列化成数组
//                    formData.forEach(function (e) {
//                        param[e.name] = e.value;
//                    });
//                    return param;//自定义需要传递的参数。
//                }
//            },
                data:{
                    name:"test",
                    loginName:15901794296
                }
            },
            columns: [//对应上面thead里面的序列
                {"data": "null"},
                {"data": "id"},
                {"data": 'loginName'},
                {"data": 'name'},
                {"data": 'phone'},
                {"data": 'createTime'},
                {"data":'columnDefs'}
//                {
//                    "data": 'createDate',
//                    "render": function (data, type, full, callback) {
//                        return data.substr(0, 19)
//                    }
//                },
//                {
//                    "data": 'updateTime', defaultContent: "",
//                    "render": function (data, type, full, callback) {
//                        if (data != null && data != "") {
//                            return data.substr(0, 19)
//                        } else {
//                            return data;
//                        }
//                    }
//                },
//                {"data": null, "width": "60px"},

            ],

//操作按钮
            columnDefs: [
                {
                    targets: 0,
                    defaultContent: "<input type='checkbox' name='checkList'>"
                },
                {
                    targets: -1,
                    defaultContent: str
                }
            ],
            language: {
                lengthMenu: "",
                processing: "",
                paginate: {
                    previous: "<",
                    next: ">",
                    first: "<<",
                    last: ">>"
                },
                zeroRecords: "",
                info: "",
                infoEmpty: "",
                infoFiltered: "",
                sSearch: "",
            },
//在每次table被draw完后回调函数
            fnDrawCallback: function () {
                var api = this.api();
//获取到本页开始的条数
                var startIndex = api.context[0]._iDisplayStart;
                api.column(1).nodes().each(function (cell, i) {
                    cell.innerHTML = startIndex + i + 1;
                });
            }
        });

//查询按钮
        $("#btn-query").on("click", function () {
            tables.fnDraw();//查询后不需要保持分页状态，回首页
        });

//添加
        $("#btn-add").on("click", function () {
            url = "";
            $("input[name=typeId]").val(0);
            $("input[name=typeNameCn]").val("");
            $("input[name=typeNameEn]").val("");
            $("#editModal").modal("show");
        });

//批量删除
        $("#btn-delAll").on("click", function () {

        });

//导出
        $("#btn-export").on("click", function () {
        });

//刷新
        $("#btn-re").on("click", function () {
            tables.fnDraw(false);//刷新保持分页状态
        });

//checkbox全选
        $("#checkAll").on("click", function () {
            if ($(this).prop("checked") === true) {
                $("input[name='checkList']").prop("checked", $(this).prop("checked"));
                $("#dataTable tbody tr").addClass('selected');
                $(this).hasClass('selected')
            } else {
                $("input[name='checkList']").prop("checked", false);
                $("#dataTable tbody tr").removeClass('selected');
            }
        });

//修改
        $("#dataTable tbody").on("click", "#editRow", function () {
            var data = tables.api().row($(this).parents("tr")).data();
            $("input[name=typeId]").val(data.typeIdStr);
            $("input[name=typeNameCn]").val(data.typeNameCn);
            $("input[name=typeNameEn]").val(data.typeNameEn);

            url = "";

            $("#editModal").modal("show");
        });

        $("#btn-submit").on("click", function () {
            $.ajax({
                cache: false,
                type: "POST",
                url: url,
                data: $("#editForm").serialize(),
                async: false,
                error: function (request) {
                    showFail("Server Connection Error<%=request.getContextPath()%>.");
                },
                success: function (data) {
                    if (data.status == 1) {
                        $("#editModal").modal("hide");
                        showSuccess("");
                        tables.fnDraw();
                    } else {
                        showFail("");
                    }
                }
            });
        });

//删除
        $("#dataTable tbody").on("click", "#delRow", function () {
            var data = tables.api().row($(this).parents("tr")).data();
            if (confirm("是否确认删除这条信息?")) {
                $.ajax({
                    url: '',
                    type: 'delete',
                    dataType: "json",
                    cache: "false",
                    success: function (data) {
                        if (data.status == 1) {
                            showSuccess();
                            tables.api().row().remove().draw(false);
                        } else {
                            showFail();
                        }
                    },
                    error: function (err) {
                        showFail("Server Connection Error<%=request.getContextPath()%>.");
                    }
                });
            }
        });


    });
</script>
