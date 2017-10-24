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
            <input type="hidden" name="loginagentId" id="loginagentId" value="<shiro:principal property="limitAgentId"/>">
            <div class="form-group">
                <label for="agentNumber" class="col-sm-1 control-label">代理商账号</label>
                <div class="col-sm-2" >
                    <select name="agentNumber" id="agentNumber" class="form-control agentNumber">

                    </select>
                </div>

                <div class="pull-right" style="margin-top: 5px;">
                    <div class="btn-group">
                        <shiro:hasPermission name="28search">
                            <button type="button" class="btn btn-primary btn-sm" id="btn-query">
                                <i class="fa fa-search"></i> 查询
                            </button>
                            <button type="button" class="btn btn-primary btn-sm" id="btn-re">
                                <i class="fa fa-refresh"></i> 刷新
                            </button>
                        </shiro:hasPermission>
                    </div>
                    <shiro:hasPermission name="28add">
                        <button type="button" class="btn btn-primary btn-sm toadd" id="btn-query">
                            新增代理商
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
            <th style="width: 10%;">代理商账号</th>
            <th style="width: 10%;">昵称</th>
            <th style="width: 20%;">手机号</th>
            <th style="width: 20%;">邮箱</th>
            <th style="width: 20%;">备注</th>
            <th style="width: 20%;">操作</th>
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
                <h4 class="modal-title" id="myModalLabel">修改代理商</h4>
            </div>

            <div class="modal-body" style=" width: 100%; ">
                <form role="form" class="form-horizontal" id="updateForm" style=" width: 100%; ">
                    <input type="hidden"  class="userId" value="">
                    <input type="hidden"  class="agentId" value="">
                    <div class="form-group" >
                        <label class="col-sm-4 control-label" >代理商账号</label>
                        <div class="col-sm-8">
                            <input type="text" name="loginName"  class="form-control updateloginName" readonly="readonly">
                        </div>
                    </div>
                     <div class="form-group" >
                        <label class="col-sm-4 control-label" >昵称</label>
                        <div class="col-sm-8">
                            <input type="text" name="agentName"  class="form-control updateagentName">
                        </div>
                    </div>
                    <div class="form-group" >
                        <label class="col-sm-4 control-label" >手机号</label>
                        <div class="col-sm-8">
                            <input type="text" name="phone"  class="form-control updatephone">
                        </div>
                    </div>
                    <div class="form-group" >
                        <label class="col-sm-4 control-label" >返水比例</label>
                        <div class="col-sm-8">
                            <div class="input-group">
                                <input type="text" class="form-control updatedefectionProportion" aria-label="Amount (to the nearest dollar)" onkeyup="value=value.replace(/[^\d\.]/g,'')">
                                <span class="input-group-addon">‰</span>
                            </div>
                        </div>
                    </div>
                    <div class="form-group" >
                        <label class="col-sm-4 control-label" >邮箱</label>
                        <div class="col-sm-8">
                            <input type="text" name="email"  class="form-control updateemail" >
                        </div>
                    </div>
                    <div class="form-group" >
                        <label class="col-sm-4 control-label" >备注</label>
                        <div class="col-sm-8">
                             <textarea class="form-control updateremarks"  name="remarks"  >

                             </textarea>
                        </div>
                    </div>
                    <div class="form-group" >
                        <label class="col-sm-4 control-label" >专属链接</label>
                        <div class="col-sm-8">
                            <div class="input-group">
                                <input type="text" class="form-control linkUrl" readonly="readonly" >
                                <span class="input-group-addon" id="copyUrl">复制</span>
                            </div>
                        </div>
                    </div>
                    <div class="form-group" >
                        <label class="col-sm-4 control-label">链接二维码</label>
                        <div class="col-sm-8">
                            <div id="qrcode">

                            </div>
                            <button  class="btn btn-default" type="button" id="saveLinkImage">下载</button>
                            <a id="download" download="" style="display: none;"></a>
                        </div>
                    </div>
                </form>

                <div class="text-center" style="margin-top: 50px">
                    <shiro:hasPermission name="28update">
                        <div class="btn-group">
                            <button type="button" class="btn btn-primary btn-lg" id="okUpdate">
                                确认修改
                            </button>
                        </div>
                    </shiro:hasPermission>
                    <button type="button" class="btn btn-default btn-lg btnCancel"  >
                        返回列表
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>




<div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog"  >
        <div class="modal-content"  >
            <div class="modal-header"  >
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">&times;</span>
                    <span class="sr-only"></span>
                </button>
                <h4 class="modal-title">新增代理商</h4>
            </div>

            <div class="modal-body" style=" width: 100%; ">
                <form role="form" class="form-horizontal" id="addForm" style=" width: 100%; ">
                    <div class="form-group" >
                        <label class="col-sm-4 control-label" >代理商账号</label>
                        <div class="col-sm-8">
                            <input type="text" name="loginName"  class="form-control addloginName">
                        </div>
                    </div>
                    <div class="form-group" >
                        <label class="col-sm-4 control-label" >密码</label>
                        <div class="col-sm-8">
                            <input type="text" name="passWord"  class="form-control addpassWord">
                        </div>
                    </div>
                    <div class="form-group" >
                        <label class="col-sm-4 control-label" >昵称</label>
                        <div class="col-sm-8">
                            <input type="text" name="agentName"  class="form-control addagentName">
                        </div>
                    </div>
                    <div class="form-group" >
                        <label class="col-sm-4 control-label" >手机号</label>
                        <div class="col-sm-8">
                            <input type="text" name="phone"  class="form-control addphone">
                        </div>
                    </div>
                    <div class="form-group" >
                        <label class="col-sm-4 control-label" >返水比例</label>
                        <div class="col-sm-8">
                            <div class="input-group">
                                <input type="text" class="form-control adddefectionProportion" aria-label="Amount (to the nearest dollar)" onkeyup="value=value.replace(/[^\d\.]/g,'')"/>
                                <span class="input-group-addon">‰</span>
                            </div>
                        </div>
                    </div>
                    <div class="form-group" >
                        <label class="col-sm-4 control-label" >邮箱</label>
                        <div class="col-sm-8">
                            <input type="text" name="email"  class="form-control addemail" >
                        </div>
                    </div>
                    <div class="form-group" >
                        <label class="col-sm-4 control-label" >备注</label>
                        <div class="col-sm-8">
                             <textarea class="form-control addremarks"  name="remarks"  >

                             </textarea>
                        </div>
                    </div>
                </form>

                <div class="text-center" style="margin-top: 50px">
                    <shiro:hasPermission name="28add">
                        <div class="btn-group">
                            <button type="button" class="btn btn-primary btn-lg" id="okAdd">
                                确认新增
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
        <shiro:hasPermission name="28update">
        str+= "<div class='btn-group'>" +
            "<button  class='btn btn-primary btn-sm toupdate'  id='btn-query'  type='button'>修改</button>" +
            "</div>"
        </shiro:hasPermission>

        var tables = $("#dataTable").dataTable(
            //URL
            kk.getDatatableSettings('agent/system/dataGrid',
                //查询条件
                'queryForm',
                //对应上面thead里面的序列
                [
                    {"data": "agentNumber"},
                    {"data": "agentName"},
                    {"data": 'phone'},
                    {"data": 'email'},
                    {"data": 'remarks'},
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
            $("#addModal").modal("show");
        });

        //新增
        $("#okAdd").on("click", function () {
            if($(".addloginName").val() == ""){
                layer.msg("代理商账号不能为空！", {icon: 2}); return;
            }
            if(!loginNameIsHave($(".addloginName").val())){
                layer.msg("代理商账号已存在，请更换账号！", {icon: 2});return;
            }
            if($(".addpassWord").val() == ""){
                layer.msg("密码不能为空！", {icon: 2});return;
            }
            if($(".addagentName").val() == ""){
                layer.msg("昵称不能为空！", {icon: 2});return;
            }
            if($(".addphone").val() == ""){
                layer.msg("手机号不能为空！", {icon: 2});return;
            }else{
                var pattern = /(13\d|14[57]|15[^4,\D]|17[13678]|18\d)\d{8}|170[0589]\d{7}/,
                    str = $(".addphone").val();
                if(!pattern.test(str)){
                    layer.msg("手机格式错误！", {icon: 2});return;
                }
            }
            if($(".adddefectionProportion").val() == ""){
                layer.msg("返水比例不能为空！", {icon: 2});return;
            }else{
                var pattern = /^\d+(\.\d{2})?$/,
                    str = $(".adddefectionProportion").val();
                if(!pattern.test(str)){
                    layer.msg("返水比例格式错误！", {icon: 2});return;
                }else{
                    if(parseFloat(str) > 100){
                        layer.msg("返水比例不能超过100！", {icon: 2});return;
                    }
                }
            }
            if($(".addemail").val() == ""){
                layer.msg("邮箱不能为空！", {icon: 2});return;
            }else{
                var pattern = /\w[-\w.+]*@([A-Za-z0-9][-A-Za-z0-9]+\.)+[A-Za-z]{2,14}/,
                    str = $(".addemail").val();
                if(!pattern.test(str)){
                    layer.msg("邮箱格式错误！", {icon: 2});return;
                }
            }


            $.ajax({
                type: "POST",
                url: kk.CONSTS.URL_BASE_API+"agent/system/addAgent",
                data: {
                    "agentName"   : $(".addagentName").val(),
                    "agentNumber" : $(".addloginName").val(),
                    "passWord"   : $(".addpassWord").val(),
                    "phone" : $(".addphone").val(),
                    "defectionProportion" : $(".adddefectionProportion").val(),
                    "email" : $(".addemail").val(),
                    "remarks": $(".addremarks").val()
                },
                async: false,
                success: function (data) {
                    if (data.data == true) {
                        layer.msg('新增成功！');
                        $("#okAdd").hide();
                    } else {
                        layer.msg("操作失败！", {icon: 2});
                    }
                },error: function(error) {
                    layer.msg(error.responseText, {icon: 2});
                }
            });
        });


        //修改
        $("#dataTable tbody").on("click", ".toupdate", function () {
            var data = tables.api().row($(this).parents("tr")).data();
            $(".updateloginName").val(data.agentNumber);
            $(".updateagentName").val(data.agentName);
            $(".updatephone").val(data.phone);
            $(".updateemail").val(data.email);
            $(".updateremarks").val(data.remarks);
            $(".updatedefectionProportion").val(data.defectionProportion);
            $(".userId").val(data.userId);
            $(".agentId").val(data.agentId);

            var linkUrl= kk.CONSTS.URL_BASE_AGENT_LINKURL+data.agentId;
            $(".linkUrl").val(linkUrl);
            //使用canvas生成
            jQuery('#qrcode').qrcode({
                render: "canvas",
                width: 85,
                height: 85,
                text: linkUrl
            });
            $("#download").attr("download",data.agentNumber);
            $("#editModal").modal("show");
        });





        //复制
        $("#copyUrl").click(function(){
            var textToClipboard=$(".linkUrl").val();
            var success = true;
            if (window.clipboardData) { // Internet Explorer
                window.clipboardData.setData ("Text", textToClipboard);
            }
            else {
                // create a temporary element for the execCommand method
                var forExecElement = CreateElementForExecCommand (textToClipboard);

                /* Select the contents of the element
                    (the execCommand for 'copy' method works on the selection) */
                SelectContent (forExecElement);

                var supported = true;

                // UniversalXPConnect privilege is required for clipboard access in Firefox
                try {
                    if (window.netscape && netscape.security) {
                        netscape.security.PrivilegeManager.enablePrivilege ("UniversalXPConnect");
                    }

                    // Copy the selected content to the clipboard
                    // Works in Firefox and in Safari before version 5
                    success = document.execCommand ("copy", false, null);
                }
                catch (e) {
                    success = false;
                }

                // remove the temporary element
                document.body.removeChild (forExecElement);
            }

            if (success) {
                 layer.msg('复制成功！');return;
            }
            else {
                layer.msg("复制失败，请使用CTRL+C！", {icon: 2});return;
            }
        });
        function CreateElementForExecCommand (textToClipboard) {
            var forExecElement = document.createElement ("div");
            // place outside the visible area
            forExecElement.style.position = "absolute";
            forExecElement.style.left = "-10000px";
            forExecElement.style.top = "-10000px";
            // write the necessary text into the element and append to the document
            forExecElement.textContent = textToClipboard;
            document.body.appendChild (forExecElement);
            // the contentEditable mode is necessary for the  execCommand method in Firefox
            forExecElement.contentEditable = true;

            return forExecElement;
        }
        function SelectContent (element) {
            // first create a range
            var rangeToSelect = document.createRange ();
            rangeToSelect.selectNodeContents (element);

            // select the contents
            var selection = window.getSelection ();
            selection.removeAllRanges ();
            selection.addRange (rangeToSelect);
        }

        //下载
        $("#saveLinkImage").click(function(){
            var canvas = $('#qrcode').find("canvas").get(0);
            var url = canvas.toDataURL('image/jpeg');
            $("#download").attr('href', url).get(0).click();
            return false;
        });


        $("#okUpdate").on("click", function () {
            if($(".updateagentName").val() == ""){
                layer.msg("昵称不能为空！", {icon: 2});return;
            }
            if($(".updatephone").val() == ""){
                layer.msg("手机号不能为空！", {icon: 2});return;
            }else{
                var pattern = /(13\d|14[57]|15[^4,\D]|17[13678]|18\d)\d{8}|170[0589]\d{7}/,
                    str = $(".updatephone").val();
                if(!pattern.test(str)){
                    layer.msg("手机格式错误！", {icon: 2});return;
                }
            }
            if($(".updatedefectionProportion").val() == ""){
                layer.msg("返水比例不能为空！", {icon: 2});return;
            }else{
                var pattern = /^\d+(\.\d{2})?$/,
                    str = $(".updatedefectionProportion").val();
                if(!pattern.test(str)){
                    layer.msg("返水比例格式错误！", {icon: 2});return;
                }else{
                    if(parseFloat(str) > 100){
                        layer.msg("返水比例不能超过100！", {icon: 2});return;
                    }
                }
            }
            if($(".updateemail").val() == ""){
                layer.msg("邮箱不能为空！", {icon: 2});return;
            }else{
                var pattern = /\w[-\w.+]*@([A-Za-z0-9][-A-Za-z0-9]+\.)+[A-Za-z]{2,14}/,
                    str = $(".updateemail").val();
                if(!pattern.test(str)){
                    layer.msg("邮箱格式错误！", {icon: 2});return;
                }
            }
            $.ajax({
                type: "POST",
                url: kk.CONSTS.URL_BASE_API+"agent/system/updateAgent",
                data: {
                    "userId"   : $(".userId").val(),
                    "agentId"   : $(".agentId").val(),
                    "agentName"   : $(".updateagentName").val(),
                    "phone" : $(".updatephone").val(),
                    "defectionProportion" : $(".updatedefectionProportion").val(),
                    "email" : $(".updateemail").val(),
                    "remarks": $(".updateremarks").val()
                },
                async: false,
                success: function (data) {
                    if (data.data == true) {
                        layer.msg('修改成功！');
                        $("#okUpdate").hide();
                    } else {
                        layer.msg("操作失败！", {icon: 2});
                    }
                },error: function(error) {
                    layer.msg(error.responseText, {icon: 2});
                }
            });
        });

        //判断登录账号是否存在
        function  loginNameIsHave(loginName) {
            var flag=true;
            $.ajax({
                type: "POST",
                url: kk.CONSTS.URL_BASE_API+"user/system/loginNameIsHave",
                data: {
                    "loginName":loginName
                },
                async: false,
                success: function (data) {
                    flag=data.data;
                }
            });
            return flag;
        }

        //代理商列表
        if(true) {
            $.ajax({
                type: "POST",
                url: kk.CONSTS.URL_BASE_API+"agent/system/getAgentList",
                data: {},
                async: false,
                success: function (data) {
                    var agentList=data.data;
                    $(".agentNumber").append("<option value=''>全部</option>");
                    for(var i=0 ; i <agentList.length ;i++){
                        $(".agentNumber").append("<option value='"+agentList[i].loginName+"'>"+agentList[i].loginName+"</option>");
                    }
                }
            });
        }



     });
</script>
