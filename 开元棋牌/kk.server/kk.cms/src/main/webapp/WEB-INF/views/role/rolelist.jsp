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
                <label for="roleName" class="col-sm-2 control-label">角色名称</label>
                <div class="col-sm-2" >
                    <input type="text" name="roleName" id="roleName" class="form-control">
                </div>
                 <div class="pull-right" style="margin-top: 5px;">
                     <shiro:hasPermission name="17add">
                         <button type="button" class="btn btn-primary btn-sm toadd">
                             添加
                         </button>
                     </shiro:hasPermission>
                     <div class="btn-group">
                         <shiro:hasPermission name="17search">
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
            <th style="width: 10%;">角色名称</th>
            <th style="width: 10%;">创建时间</th>
            <th style="width: 10%;">操作</th>
        </tr>
        </thead>
        <tbody></tbody>
    </table>
</div>


<div class="modal fade" id="editModal1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="width:50%;">
        <div class="modal-content" style=" width: 100%; ">
            <div class="modal-header" style=" width: 100%; ">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">&times;</span>
                    <span class="sr-only"></span>
                </button>
                <h4 class="modal-title" >新增角色</h4>
            </div>

            <div class="modal-body" style=" width: 100%; ">
                <form role="form" class="form-horizontal" id="detailForm" style=" width: 100%; ">
                    <div class="form-group" >
                        <label class="col-sm-3 control-label" >角色名称</label>
                        <div class="col-sm-4">
                            <input type="text" name="roleName" class="roleName" class="form-control">
                        </div>
                    </div>
                  </form>

                <div class="text-center" style="margin-top: 50px">
                    <shiro:hasPermission name="17add">
                        <div class="btn-group">
                            <button type="button" class="btn btn-primary btn-lg" id="okAdd">
                                添加角色
                            </button>
                        </div>
                    </shiro:hasPermission>
                    <button type="button" class="btn btn-default btn-lg btnCancel" >
                               返回列表
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>


<div class="modal fade" id="editModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="width:80%;">
        <div class="modal-content" style=" width: 100%; ">
            <div class="modal-header" style=" width: 100%; ">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">&times;</span>
                    <span class="sr-only"></span>
                </button>
                <h4 class="modal-title">修改权限</h4>
            </div>

            <div class="modal-body" style=" width: 100%; ">
                <form role="form" class="form-horizontal" style=" width: 100%; ">
                    <input type="hidden"  class="userId" value="">
                    <div class="form-group"  >
                        <label class="col-sm-3 control-label" >角色</label>
                        <div class="col-sm-4">
                            <select  name="roleId" class="form-control roleId " onchange="showDetailUpdate(this.value)">

                            </select>
                        </div>
                    </div>
                    <div class="form-group"  >
                        <label class="col-sm-3 control-label" >权限管理</label>
                        <div class="col-sm-6">
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <td>模块</td>
                                    <td>子模块</td>
                                    <td>操作</td>
                                </tr>
                             </thead>
                            <tbody class="modulesList">


                            </tbody>
                        </table>
                        </div>
                    </div>
                </form>
                 <div class="text-center" style="margin-top: 50px">
                    <shiro:hasPermission name="17update">
                        <div class="btn-group">
                            <button type="button" class="btn btn-primary btn-lg" id="okUpdate">
                                确认修改
                            </button>
                        </div>
                    </shiro:hasPermission>
                     <button type="button" class="btn btn-default btn-lg btnCancel" >
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
        //添加、修改异步提交地址
        var str = "";
        <shiro:hasPermission name="13update">
        str+= "<div class='btn-group'>" +
            "<button  class='btn btn-primary btn-sm toupdate'  id='btn-query'  type='button'>权限设置</button>" +
            "</div>"
        </shiro:hasPermission>



        var tables = $("#dataTable").dataTable(
            //URL
            kk.getDatatableSettings('role/system/dataGrid',
                //查询条件
                'queryForm',
                //对应上面thead里面的序列
                [
                    {"data": "roleName"},
                    {
                        "data": 'createDate',
                        "render": function (data, type, full, callback) {
                            return kk.timeStamp2String(data)
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
        $(".btnCancel").on("click", function () {
            window.location.reload();
        });

        //添加
        $(".toadd").on("click", function () {
            $(".roleName").val("");
            $("#editModal1").modal("show");
            $("#editModal2").modal("hide");
        });
        //新增角色
        $("#okAdd").on("click", function () {
            $.ajax({
                type: "POST",
                url: kk.CONSTS.URL_BASE_API+"role/system/addRole",
                data: {
                    "roleName":$(".roleName").val()
                },
                async: false,
                success: function (data) {
                    if (data.data == true) {
                        layer.msg('新增成功！');
                        $("#okAdd").hide();
                    } else {
                        ayer.msg('新增失败！');
                     }
                }
            });
        });

        //修改权限
        $("#dataTable tbody").on("click", ".toupdate", function () {
            var data = tables.api().row($(this).parents("tr")).data();
            $(".roleId").val(data.roleId);
            //操作选中-所有checkbox指定一个class循环
            showDetailUpdate(data.roleId);
            $("#editModal2").modal("show");
            $("#editModal1").modal("hide");
        });





        //修改
        $("#okUpdate").on("click", function () {
            //获取所有的菜单选中的ID
            var modulesStr="";
            $(".cd").each(function(){
                if ($(this).is(":checked")) {
                    modulesStr+=$(this).val()+",";
                }
            });
            $.ajax({
                type: "POST",
                url: kk.CONSTS.URL_BASE_API+"role/system/updateRoleModules",
                data: {
                    "roleId":$(".roleId").val(),
                    "modulesStr":modulesStr
                },
                async: false,
                success: function (data) {
                    if (data.data == true) {
                        layer.msg('修改成功！');
                    } else {
                        layer.msg('修改失败！');
                    }
                }
            });
        });


        //角色列表
        if(true) {
            $.ajax({
                type: "POST",
                url: kk.CONSTS.URL_BASE_API+"role/system/getRoleList",
                data: {},
                async: false,
                success: function (data) {
                    var roleList=data.data;
                    $(".roleId").empty();
                    for(var i=0 ; i <roleList.length ;i++){
                        $(".roleId").append("<option value='"+roleList[i].roleId+"'>"+roleList[i].roleName+"</option>");
                    }
                }
            });
        }


        //菜单列表
        if(true) {
            $.ajax({
                type: "POST",
                url: kk.CONSTS.URL_BASE_API+"modules/system/getModuleList",
                data: {},
                async: false,
                success: function (data) {
                    var selectList=data;
                    console.log(data);
                    for(var i=0 ; i <selectList.length ;i++){
                         $(".modulesList").append("<tr> <td colspan='3'><input type='checkbox' class='cd' value='"+selectList[i].moduleId+"'>"+selectList[i].name+"</td> </tr>");
                         var selectList2=selectList[i].list;
                         for(var j=0 ; j <selectList2.length ;j++){
                             var selectList3=selectList2[j].list;
                             var str=" ";
                             for(var h=0 ; h <selectList3.length ;h++){
                                 str+="<input type='checkbox' class='cd' value='"+selectList3[h].moduleId+"'>"+selectList3[h].name+" ";
                             }
                             $(".modulesList").append("<tr> <td></td> <td><input type='checkbox' class='cd' value='"+selectList2[j].moduleId+"'>"+selectList2[j].name+"</td> <td>  "+str+"</td> </tr>");
                         }

                    }
                }
            });
        }


    });


    function showDetailUpdate(roleId){
        $.ajax({
            type: "POST",
            url: kk.CONSTS.URL_BASE_API+"role/system/findModulesById",
            data:  {
                "roleId" : roleId
            },
            async: false,
            success: function (data) {
                var modules=data.data;
                if (data.message == "succeed") {
                    $(".cd").each(function(){
                        if(modules.indexOf($(this).val()) >= 0){
                            $(this).prop("checked",true);
                        }else{
                            $(this).prop("checked",false);
                        }
                    });
                }else{
                    alert("信息有误");
                }
            }
        });
    }
</script>
