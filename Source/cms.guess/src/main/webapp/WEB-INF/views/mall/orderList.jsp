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
                <label for="create_date" class="col-sm-1 control-label">下单时间</label>
                <div class="col-sm-3" >
                    <input type="text" name="create_date" id="create_date" class="form-control">
                    <input type="text" id = "createDateStart" name="createDateStart" class="form-control" style="display: none"/>
                    <input type="text" id = "createDateEnd" name="createDateEnd" class="form-control" style="display: none;"/>
                </div>

                <label for="task_content" class="col-sm-1 control-label">竞猜内容</label>
                <div class="col-sm-2">
                    <input type="text" id="task_content" name="task_content" class="form-control input-sm"/>
                </div>
                <label for="task_status" class="col-sm-1 control-label">竞猜状态</label>
                <div class="col-sm-2">
                    <select id ="task_status" name="task_status" class="form-control">
                        <option value="">全部</option>
                        <option value="10">已下单</option>
                        <option value="20">已支付</option>
                        <option value="30">审核中</option>
                        <option value="40">配送中</option>
                        <option value="50">已收货</option>
                        <option value="60">退款中</option>
                        <option value="70">退货中</option>
                        <option value="99">已取消</option>
                    </select>
                </div>
            </div>
        </form>

        <div class="pull-right" style="margin-top: 5px;">

            <button type="button" class="btn btn-primary btn-sm" id="btn-query">
                <i class="fa fa-search"></i> 查询
            </button>

            <div class="btn-group">
                <%--<button type="button" class="btn btn-primary btn-sm" id="btn-add">--%>
                    <%--<i class="fa fa-plus"></i> 发布--%>
                <%--</button>--%>
                <button type="button" class="btn btn-primary btn-sm" id="btn-delAll">
                    <i class="fa fa-remove"></i> 删除
                </button>
                <button type="button" class="btn btn-primary btn-sm" id="btn-lock">
                    <i class="fa fa-sign-in"></i> 锁定
                </button>
                <button type="button" class="btn btn-primary btn-sm" id="btn-lottery">
                    <i class="fa fa-sign-in"></i> 开奖
                </button>
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
            <!--<td><input type="checkbox" id="checkAll"></td>-->
            <th style="width: 1%;"></th>
            <th style="width: 8%;">类型</th>
            <th style="width: 10%;">图片</th>
            <th style="width: 14%;">内容</th>
            <th style="width: 7%;">状态</th>
            <th style="width: 7%;">单价</th>
            <th style="width: 7%;">注数</th>
            <th style="width: 8%;">总额</th>
            <th style="width: 14%;">答案</th>
            <th style="width: 12%;">发布时间</th>
            <th style="width: 12%;">开奖时间</th>
        </tr>
        </thead>
        <tbody></tbody>
    </table>
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

        $("input[name='create_date']").daterangepicker(cicada.DATE_RANGE_PICKER_OPTIONS,
            function(start, end, label) {
                $("#createDateStart").val(start.format("YYYY/MM/DD"));
                $("#createDateEnd").val(end.format("YYYY/MM/DD"));
        });

        //添加、修改异步提交地址
		var str = "";
    	<shiro:hasAnyRoles name = "admin">
    	 str+= "<div class='btn-group'>" +
         "<button id='audit' class='btn btn-primary btn-sm' type='button'><i class='fa fa-edit'></i></button>" +
         "</div>"
    	 </shiro:hasAnyRoles>

        var winHeight = $(window).height();
        $("div.content").css({"min-height":winHeight,"_height":winHeight+"px","height":"auto!important"});
        var tblHeight = $("div.content").height() - $("div.row-fluid").height();
        $("#dataTable").css({"min-height":tblHeight,"_height":tblHeight+"px","height":"auto!important"});

        console.log(tblHeight);
        var url = "";
        var tables = $("#dataTable").dataTable({
            sScrollY:'58vh',
            serverSide: true,//分页，取数据等等的都放到服务端去
            processing: true,//载入数据的时候是否显示“载入中”
            pageLength: 10,  //首次加载的数据条数
            ordering: false, //排序操作在服务端进行，所以可以关了。
            pagingType: "full_numbers",
            autoWidth: true,
            stateSave: true,//保持翻页状态，和comTable.fnDraw(false);结合使用
            searching: false,//禁用datatables搜索
            bPaginate:true,
            ajax: {
                    type: "post",
                    url: cicada.CONSTS.URL_BASE_API+'order/list',
                    dataSrc: "data",
                    dataType:'json',
                    contentType:"application/json",
                    data: function (d) {
                        var param = {};
                        param.draw = d.draw;
                        param.start = d.start;
                        param.length = d.length;
                        var formData = $("#queryForm").serializeArray();//把form里面的数据序列化成数组
                        formData.forEach(function (e) {
                            param[e.name] = e.value;
                        });
                        return JSON.stringify(param);//自定义需要传递的参数。
                    }
                },
            columns: [//对应上面thead里面的序列
                {
                    "data": "taskId",
                    "render":function (data,type,rowData,callback) {
                        return "<input type='checkbox' name='checkList' id = '"+data+"' />";
                    }
                },
                //
                {
                    "data": "taskType",
                    "render":function (data,type,rowData,callback) {
                        //return cicada.ENUMS.TASK_TYPE.getName(data);
                        return data.desc;
                    }
                },
                {
                    "data":"picturesVoList",
                    "render":function (data,type,rowData,callback) {
                        var str = "";
                        if((data || []).length > 0 && !cicada.isNullOrEmpty(data[0].picUrl)){
                            var imgUrl = data[0].picUrl;

                            str = "<div style='width: 80px;'>";
                            str +="   <div class='zoomImage' style='background-image:url("+imgUrl+")'></div>";
                            str +="</div>";
                        }
                        return str;
                    }
                },
                {"data": 'taskContent'},
                {
                    "data": 'taskStatus',
                    "render":function (data,type,rowData,callback) {
                        //return cicada.ENUMS.TASK_STATUS.getName(data);
                        return data.desc;
                    }
                },
                {"data": 'salePrice'},
                {"data": 'quantity'},
                {"data": 'saleAmount'},
                {
                    "data": 'answerVoList',
                    "render": function (data,type,rowData,callback) {
                        var str = "";
                        var i = 0;
                        if((data || []).length > 0) {
                            $(data).each(function () {
                                i++;
                                str = str + String.fromCharCode(i+64) + "：" + this.answer + "<br/>";
                            })
                        }
                        return str;
                    }
                },
                {
                    "data": 'createDate',
                    "render":function (data,type,rowData,callback) {
                        return cicada.timeStamp2Date(data).format(cicada.CONSTS.DATE_FORMAT_MD_HM);
                    }
                },
                {
                    "data": 'settleTime',
                    "render":function (data,type,rowData,callback) {
                        return cicada.timeStamp2Date(data).format(cicada.CONSTS.DATE_FORMAT_MD_HM);
                    }
                }
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
//                    cell.innerHTML = cicada.CONSTS.TASK_TYPE.getName(i+1);
                });
            }
        });

//查询按钮
        $("#btn-query").on("click", function () {
            tables.fnDraw();//查询后不需要保持分页状态，回首页
        });

//发布竞猜
        $("#btn-add").on("click", function () {
            url = "";
            $("input[name=typeId]").val(0);
            $("input[name=typeNameCn]").val("");
            $("input[name=typeNameEn]").val("");
            $("#editModal").modal("show");
        });

//批量删除
        $("#btn-delAll").on("click", function () {
            var ids = new Array();
            $('input:checkbox[name=checkList]:checked').each(function (i) {
                ids.push(this.id);
            })

            if(ids.length==0){
                layer.msg("请选择要删除的竞猜项目！");
                return;
            }
        });

//锁定竞猜
        $("#btn-lock").on("click", function () {
            var ids = new Array();
            $('input:checkbox[name=checkList]:checked').each(function (i) {
                ids.push(this.id);
            })

            if(ids.length==0){
                layer.msg("请选择要锁定的竞猜项目！");
                return;
            }

            layer.confirm('<span style="color:red">锁定后将无法下注！<br/>确定要锁定选中的竞猜项目吗？</span>', {
                title:"警告",
                btn: ['锁定','取消'] //按钮
            }, function(index){
                var data = {taskIds:ids};
                cicada.post('task/lock',JSON.stringify(data),function (result) {
                    layer.msg('锁定成功！');

                },function (err) {
                    layer.msg('锁定失败！'+ err.message, {icon: 2});
                },"application/json");

                layer.close(index);
            }, function(index){
                layer.close(index);
            });
        });

//开奖
        $("#btn-lottery").on("click", function () {
            var ids = new Array();
            $('input:checkbox[name=checkList]:checked').each(function (i) {
                ids.push(this.id);
            })

            if(ids.length==0){
                layer.msg("请选择要锁定的竞猜项目！");
                return;
            }else if(ids.length>1){
                layer.msg("只能选择一个竞猜项目开奖！");
                return;
            }
            var taskId = ids[0];
            var allData = $('#dataTable').dataTable().fnGetData();
            var rowData = cicada.getArrayItem(allData,"taskId",taskId)[0];

            if(rowData.taskStatus.code != cicada.ENUMS.TASK_STATUS.published){
                layer.msg("竞猜状态【"+cicada.ENUMS.TASK_STATUS.getName(rowData.taskStatus.code)+"】不能开奖！");
                return;
            }

            var content = "<div class='table'><div>" +
                "<label class='control-label col-sm-6'>请选择正确答案：</label>" +
                "<select class='form-control col-sm-6' style='width: 95%;margin-left: 10px;' id='answerId'><option value='0'></option></select>" +
                "</div>" +
                "<div class='pull-right' style='margin-top: 30px;margin-right: 10px;'>" +
                "<button type='button' class='btn btn-danger btn-sm' id='btnCommit'><i class='fa fa-save'></i> 开奖</button>" +
                "<button type='button' class='btn btn-default btn-sm' id='btnCancel'><i class='fa fa-close'></i> 取消</button>" +
                "</div>"+
                "</div>";

            layer.open({
                type: 1,
                area: ['350px', '200px'],
                fix: true,
                maxmin: false,
                shade: 0.4,
                title: '开奖',
                content:content
            });
            for(var i=0;i<rowData.answerVoList.length;i++){
                var ans = rowData.answerVoList[i];
                var op = "<option value='"+ans.answerId+"'>"+ans.answer+"</option>";
                $("#answerId").append(op);
            }

            var saveBtn = $("#btnCommit");
            var answerSelect = $("#answerId");
            var cancelBtn = $("#btnCancel");
            saveBtn.on("click", function () {
                var answerId = answerSelect.val();
                if (cicada.isNullOrEmpty(answerId) || answerId == 0) {
                    layer.msg("请先指定正确答案！",{icon:2});
                } else {
                    cicada.post('task/lottery',JSON.stringify({taskId:taskId,answerId:answerId}),function (result) {
                        layer.msg('开奖成功！');
                    },function (err) {
                        layer.msg('开奖失败！'+ err.message, {icon: 2});
                    },"application/json");

                    layer.closeAll();
                }
            });
            cancelBtn.on("click", function () {
                answerSelect.val(0);
                layer.closeAll();
            });
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
