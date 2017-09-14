<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html>
<html style=" overflow: hidden;">
<%@ include file="../../currency/top.jsp"%>
<body class="hold-transition skin-blue sidebar-mini fixed">
<div class="wrapper">

    <header class="main-header">
        <!-- Logo -->
        <a href="#" class="logo" >
            <!-- mini logo for sidebar mini 50x50 pixels -->
            <span class="logo-mini">星河娱乐</span>
            <!-- logo for regular state and mobile devices -->
            <span class="logo-lg">星河娱乐</span>
        </a>
        <!-- Header Navbar: style can be found in header.less -->
        <nav class="navbar navbar-static-top">
            <!-- Sidebar toggle button-->
            <a style=" display: none; " href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button" >
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </a>

            <div class="navbar-custom-menu">
                <ul class="nav navbar-nav">
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
                                <%--<div class="pull-left">--%>
                                    <%--<a href="#" class="btn btn-default btn-flat">修改</a>--%>
                                <%--</div>--%>
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
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog"
        aria-labelledby="myModalLabel" aria-hidden="true">
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
</div>
<%@ include file="../../currency/js.jsp"%>
<script type="text/javascript">

    document.title="星河娱乐 | 管理平台";

    var roles=<shiro:principal property="rolesstr"/>;
//    var roles=1;
    $(function () {


        App.setbasePath("../");
        App.setGlobalImgPath("dist/img/");

        App.fixIframeCotent();
        $.ajax({
             type : "POST",  //提交方式
             url : agdress.CONSTS.URL_BASE_API+"ss_modules/tree",
             data:{"roles":roles},
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
             }
         });


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
</script>

</body>
</html>