<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@page   import="com.agdress.commons.utils.SystemConfig"  %>
<!DOCTYPE html>
<html style=" overflow: hidden;">
<%@ include file="../../currency/top.jsp"%>
<body class="hold-transition skin-blue sidebar-mini fixed">
<div class="wrapper">

    <header class="main-header">
        <!-- Logo -->
        <a href="#" class="logo" >
            <!-- mini logo for sidebar mini 50x50 pixels -->
            <span class="logo-mini"><b>X</b>HE</span>
            <!-- logo for regular state and mobile devices -->
            <span class="logo-lg"><b>星河</b>娱乐</span>
        </a>
        <!-- Header Navbar: style can be found in header.less -->
        <nav class="navbar navbar-static-top">
            <!-- Sidebar toggle button-->
            <a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button" >
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </a>

            <div class="navbar-custom-menu">
                <ul class="nav navbar-nav">
                    <li class="dropdown notifications-menu" style="">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="true">
                            <i class="fa fa-bell-o"></i>
                            <span class="label label-warning countnumber"></span><!-- 左上角序号 -->
                        </a>
                        <ul class="dropdown-menu">
                            <li class="header countnumber2" style="text-align: center;"></li>
                            <li>
                                <!-- inner menu: contains the actual data -->
                                    <div class="slimScrollDiv" style="position: relative; overflow: hidden; width: auto;">
                                        <ul class="menu listMessage" style="overflow: hidden; width: 100%;;">
                                            <!-- 消息集合展示-->
                                            <%--<li>--%>
                                                <%--<a href="#">--%>
                                                    <%--<i class="fa fa-user text-red"></i> 消息内容--%>
                                                <%--</a>--%>
                                            <%--</li>--%>
                                        </ul>
                                    <div class="slimScrollBar" style="background: rgb(0, 0, 0); width: 3px; position: absolute; top: 0px; opacity: 0.4; display: none; border-radius: 7px; z-index: 99; right: 1px; height: 195.122px;"></div><div class="slimScrollRail" style="width: 3px; height: 100%; position: absolute; top: 0px; display: none; border-radius: 7px; background: rgb(51, 51, 51); opacity: 0.2; z-index: 90; right: 1px;"></div></div>
                            </li>
                            <li class="footer"><a class="nav-link"  onclick="addTabs({id:'42',title: '消息列表',close: true,url: 'message/dataGrid'});">查看更多</a></li>
                        </ul>
                    </li>

                    <li class="dropdown user user-menu">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                            <img src="<%=request.getContextPath()%>/dist/img/user7-128x128.jpg" class="user-image" alt="User Image">
                            <span class="hidden-xs">
                            	<!-- 显示登录用户名 -->
                            	<shiro:principal property="name" />
                            </span>
                        </a>
                        <ul class="dropdown-menu">
                            <!-- User image -->
                            <li class="user-header">
                                <img src="<%=request.getContextPath()%>/dist/img/user7-128x128.jpg" class="img-circle" alt="User Image">

                                <p>
                                    个人介绍
                                    <small>
                                        <shiro:principal property="loginName" />(<shiro:principal property="name" />)
                                    </small>
                                </p>
                            </li>
                            <!-- Menu Body -->
                            <%--<li class="user-body" style="display: none;">--%>
                                <%--<div class="row">--%>
                                    <%--<div class="col-xs-4 text-center">--%>
                                        <%--<a href="#">关注</a>--%>
                                    <%--</div>--%>
                                    <%--<div class="col-xs-4 text-center">--%>
                                        <%--<a href="#">粉丝</a>--%>
                                    <%--</div>--%>
                                    <%--<div class="col-xs-4 text-center">--%>
                                        <%--<a href="#">好友</a>--%>
                                    <%--</div>--%>
                                <%--</div>--%>
                                <%--<!-- /.row -->--%>
                            <%--</li>--%>
                            <!-- Menu Footer-->
                            <li class="user-footer">
                                <div class="pull-left">
                                    <a  href="#" class="btn btn-default btn-flat" data-toggle="modal" data-target="#editModal">修改密码</a>
                                </div>
                                <div class="pull-right">
                                      <a href="#" class="btn btn-default btn-flat" data-toggle="modal" data-target="#myModal">注销</a>
                                </div>
                            </li>
                        </ul>
                    </li>
                </ul>
            </div>
        </nav>
    </header>



    <!-- Left side column. contains the logo and sidebar -->
    <aside class="main-sidebar" >
        <!-- 左侧边栏 -->
        <section class="sidebar">
            <%--<!-- Sidebar user panel -->--%>
            <%--<div class="user-panel">--%>
                <%--<div class="pull-left image">--%>
                    <%--<img src="<%=request.getContextPath()%>/dist/img/user7-128x128.jpg" class="img-circle" alt="User Image">--%>
                <%--</div>--%>
                <%--<div class="pull-left info">--%>
                    <%--<p><shiro:principal property="name"/></p>--%>
                    <%--<a href="#"><i class="fa fa-circle text-success"></i> 在线 </a>--%>
                <%--</div>--%>
            <%--</div>--%>
            <%--<!-- 搜索框 -->--%>
            <%--<form action="#" method="get" class="sidebar-form">--%>
                <%--<div class="input-group">--%>
                    <%--<input type="text" name="q" class="form-control" placeholder="搜索...">--%>
                    <%--<span class="input-group-btn">--%>
                <%--<button type="button" name="search" id="search-btn" class="btn btn-flat" onclick="search_menu()"><i class="fa fa-search"></i>--%>
                <%--</button>--%>
              <%--</span>--%>
                <%--</div>--%>
            <%--</form>--%>
            <ul class="sidebar-menu">

            </ul>
        </section>
        <!-- /.sidebar -->
    </aside>

    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper" id="content-wrapper" style="min-height: 421px;" >
        <!--bootstrap tab风格 多标签页-->
        <div class="content-tabs">
            <button class="roll-nav roll-left tabLeft" onclick="scrollTabLeft()">
                <i class="fa fa-backward"></i>
            </button>
            <nav class="page-tabs menuTabs tab-ui-menu" id="tab-menu">
                <div class="page-tabs-content" style="margin-left: 0px;">

                </div>
            </nav>
            <button class="roll-nav roll-right tabRight" onclick="scrollTabRight()">
                <i class="fa fa-forward" style="margin-left: 3px;"></i>
            </button>
            <div class="btn-group roll-nav roll-right">
                <button class="dropdown tabClose" data-toggle="dropdown">
                    页签操作<i class="fa fa-caret-down" style="padding-left: 3px;"></i>
                </button>
                <ul class="dropdown-menu dropdown-menu-right" style="min-width: 128px;">
                    <li><a class="tabReload" href="javascript:refreshTab();">刷新当前</a></li>
                    <li><a class="tabCloseCurrent" href="javascript:closeCurrentTab();">关闭当前</a></li>
                    <li><a class="tabCloseAll" href="javascript:closeOtherTabs(true);">全部关闭</a></li>
                    <li><a class="tabCloseOther" href="javascript:closeOtherTabs();">除此之外全部关闭</a></li>
                </ul>
            </div>
            <button class="roll-nav roll-right fullscreen" onclick="App.handleFullScreen()"><i
                    class="fa fa-arrows-alt"></i></button>
        </div>
        <div class="content-iframe " style="background-color: #ffffff; ">
            <div class="tab-content " id="tab-content">

            </div>
        </div>
    </div>
    <!-- /.content-wrapper -->



    <footer class="main-footer">
        <div class="pull-right hidden-xs">
            <b>Version</b> 1.0.0
        </div>
        <%--<strong>Copyright &copy; 2014-2016 <a href="http://almsaeedstudio.com">Almsaeed Studio</a>.</strong> All rights reserved.--%>
        <strong>Copyright &copy; 2017 Agdress Dev Group.</strong> All rights reserved.
    </footer>
	<!--隐藏的退出弹窗点击退出显示-->
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"
                        aria-hidden="true">&times;</button>
                    <h4 class="modal-title" id="myModalLabel">确定要退出吗？</h4>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">我在想想
                    </button>
                    <button type="button" class="btn btn-primary" id="loginOut">
                        确定
                    </button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal -->
    </div>

    <!--隐藏的退出弹窗点击退出显示-->
    <div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabe2" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"
                            aria-hidden="true">&times;</button>
                    <h4 class="modal-title" id="myModalLabe2">修改密码</h4>
                </div>
                <div class="modal-body" style=" width: 100%; ">
                    <form role="form" class="form-horizontal" id="updateForm" style=" width: 100%; ">
                        <input type="hidden"  class="userId" value="">
                        <input type="hidden"  class="agentId" value="">
                        <div class="form-group" >
                            <label class="col-sm-3 control-label" >账号</label>
                            <div class="col-sm-6">
                                <input type="text" name="loginName"  class="form-control loginName" readonly="readonly" value="<shiro:principal property="loginName"/>">
                            </div>
                        </div>
                        <div class="form-group" >
                            <label class="col-sm-3 control-label" >密码</label>
                            <div class="col-sm-6">
                                <input type="text" name="passWord"  class="form-control passWord" onkeyup="value=value.replace(/[^\w\/]/ig,'')">
                            </div>
                        </div>
                        <div class="form-group showfor" style="display: none;" >
                            <label class="col-sm-3 control-label" >手机号</label>
                            <div class="col-sm-6">
                                <div class="input-group">
                                    <input type="text" class="form-control phone" disabled value="<shiro:principal property="phone"/>"  >
                                    <span class="input-group-btn">
                                            <button  class="btn btn-default" type="button" id="sendMessage">发送验证码</button>
                                    </span>
                                </div>
                            </div>

                        </div>
                         <div class="form-group showfor" style="display: none;" >
                            <label class="col-sm-3 control-label" >验证码</label>
                            <div class="col-sm-6">
                                <input type="text" name="messageCode"  class="form-control" id="messageCode">
                            </div>

                        </div>
                    </form>

                    <div class="text-center" style="margin-top: 50px">
                        <div class="btn-group">
                            <button type="button" class="btn btn-primary btn-lg" id="okUpdate">
                                提交
                            </button>
                        </div>
                        <button type="button" class="btn btn-default btn-lg btnCancel"  >
                            返回
                        </button>
                    </div>
                </div>
              </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal -->
    </div>
</div>
<%@ include file="../../currency/js.jsp"%>
<script type="text/javascript">

    document.title="星河娱乐 | 管理平台";

    $(function () {

        <%--agdress.CONSTS.URL_BASE_IMG = "<%=SystemConfig.getInstance().getURL_BASE_IMG()%>";--%>
        <%--agdress.CONSTS.URL_BASE_API = "<%=SystemConfig.getInstance().getURL_BASE_API()%>";--%>
        <%--agdress.CONSTS.URL_BASE_CMS = "<%=SystemConfig.getInstance().getURL_BASE_CMS()%>";--%>

        App.setbasePath("../");
        App.setGlobalImgPath("dist/img/");

        App.fixIframeCotent();

        function menu() {
            $.ajax({
                type : "POST",  //提交方式
                url : agdress.CONSTS.URL_BASE_API+"ss_modules/tree",
                data:{"roles": <shiro:principal property="rolesstr"/> },
                success : function(myjson) {//返回数据根据结果进行相应的处理
                    var menus = []
                    for(i=0;i<myjson.length;i++){
                        if(myjson[i].pid==0){
                            var menu = {
                                id:myjson[i].id,
                                text: myjson[i].text,
                                icon: myjson[i].iconCls,
                                children: []
                            }
                            menus.push(menu)
                        }
                    }
                    for(i=0;i<myjson.length;i++){
                        if(myjson[i].pid!=0){
                            var menu = {
                                id: myjson[i].id,
                                text: myjson[i].text,
                                icon: myjson[i].iconCls,
                                url: myjson[i].attributes,
                                targetType: myjson[i].targetType
                            }
                            for(j=0;j<menus.length;j++){
                                if(menus[j].id==myjson[i].pid){
                                    menus[j].children.push(menu)
                                }
                            }
                        }
                    }
                    $('.sidebar-menu').sidebarMenu({data: menus, param: {strUser: 'admin'}});
                },error: function(error) {
                    layer.msg(error.responseText, {icon: 2});
                }
            });
        }

        menu();

         $("#loginOut").click(function(){
             $.ajax({
                 type :"post",
                 url :agdress.CONSTS.URL_BASE_CMS+"logout",
                 success : function(data){
                	 if (data) {
                		  window.location.href = agdress.CONSTS.URL_BASE_CMS+'login';
					}
                 }
             });
         });

        var role=<shiro:principal property="rolesstr"/>;
        if(role == 5){
            $(".showfor").show();
        }

        //取消
        $(".btnCancel").on("click", function () {
            $("#editModal").modal("hide");
            $(".passWord").val("");
        });

         //发送验证码
        $("#sendMessage").on("click", function () {
            agdress.post('captcha/sms',JSON.stringify({mobile : $(".phone").val()}), function (result) {
                layer.msg('发送成功！');
             },function (err) {
                 layer.msg('获取失败！'+ err.message, {icon: 2});
            },"application/json");
        });


        //确认提交密码
        $("#okUpdate").on("click", function () {
            if($(".passWord").val() == ""){
                layer.msg("密码不能为空！", {icon: 2});return;
            }
            var messageCode="";
            if(role == 5){
                messageCode=$("#messageCode").val();
                if(messageCode == ""){
                    layer.msg("验证码不能为空！", {icon: 2});return;
                }
            }
            $.ajax({
                type: "POST",
                url: agdress.CONSTS.URL_BASE_API+"ss_user/updatePassword",
                data: {
                    "userId"   : <shiro:principal property="id"/>,
                    "passWord"   : $(".passWord").val(),
                    "messageCode"   : messageCode
                },
                async: false,
                success: function (data) {
                    layer.msg('修改成功！');
                    $("#loginOut").click();
                },error: function(error) {
                    layer.msg(error.responseText, {icon: 2});
                }
            });
        });



    });

    //打开新tab页
    function openNewTab(id,title,url) {
        addTabs({
            id: id,
            title: title,
            close: true,
            url: url,
            urlType: "relative"
        });
    };

    function closeMyTab(id) {
        closeTabByPageId(id);
    }

    messageList();
    function messageList() {
        //获取消息通知
        $.ajax({
            type : "POST",  //提交方式
            url : agdress.CONSTS.URL_BASE_API+"message/listMessage",
            data:{"userId": <shiro:principal property="id"/> ,"roleId":<shiro:principal property="rolesstr"/>},
            success : function(myjson) {
                console.log(myjson);
                var countnumber=myjson.data.countnumber;
                if(countnumber >0){
                    $(".countnumber").html(countnumber);
                    $(".countnumber2").html("你有 "+countnumber+" 条消息未读");
                }else{
                    $(".countnumber").html("");
                    $(".countnumber2").html("你有 0 条消息未读");
                }
                var listMessage=myjson.data.listMessage;
                console.log(listMessage)
                $(".listMessage").empty();
                for(var i=0;i<listMessage.length;i++){
                    var str="";
                    if(listMessage[i].messageType.code == 50){
                        str="addTabs({id:'"+listMessage[i].messageContentId+"',title: '出金审核列表"+listMessage[i].messageContentId+"',close: true,url: 'audit/withdrawal?tradeNo="+listMessage[i].tradeNo+"&messageContentId="+listMessage[i].messageContentId+"'})";
                    }else{
                        str="addTabs({id:'"+listMessage[i].messageContentId+"',title: '账户出入金明细"+listMessage[i].messageContentId+"',close: true,url: 'ss_ac_detail/manager?tradeNo="+listMessage[i].tradeNo+"&messageContentId="+listMessage[i].messageContentId+"'})";
                    }

                    $(".listMessage").append("<li>  <a onclick=\""+str+"\"> <i class=\""+listMessage[i].icon+"\"></i>"+listMessage[i].content+"</a> </li>");
                }
            }
        });
    }



</script>

</body>
</html>