<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>猜一猜 | 仪表盘</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">

  <!-- Pace -->
  <link rel="stylesheet" href="<%=request.getContextPath()%>/plugins/pace-master/themes/blue/pace-theme-flash.css">
  <script type="text/javascript" src="<%=request.getContextPath()%>/plugins/pace-master/pace.min.js"></script>
  <!-- Bootstrap 3.3.6 -->
  <link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap/css/bootstrap.min.css">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="<%=request.getContextPath()%>/dist/css/font-awesome.min.css">
  <!-- Ionicons -->
  <link rel="stylesheet" href="<%=request.getContextPath()%>/dist/css/ionicons.min.css">
  <!-- jvectormap -->
  <link rel="stylesheet" href="<%=request.getContextPath()%>/plugins/jvectormap/jquery-jvectormap-1.2.2.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="<%=request.getContextPath()%>/dist/css/AdminLTE.min.css">
  <!-- AdminLTE Skins. Choose a skin from the css/skins
       folder instead of downloading all of them to reduce the load. -->
  <link rel="stylesheet" href="<%=request.getContextPath()%>/dist/css/skins/all-skins.min.css">

  <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
  <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
  <!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
  <![endif]-->
</head>
<body class="hold-transition skin-blue sidebar-mini">
<!-- Content Header (Page header) -->
<section class="content-header">
    <div class="box-header">
        <div class="box-body" style="height: 800px">
            欢迎使用猜一猜管理平台

            <%--<div class="btn btn-reddit" id="btnWtfPost">--%>
                <%--<span class="fa fa-book"></span>--%>
                <%--什么鬼POST--%>
            <%--</div>--%>
            <%--<div class="btn btn-reddit" id="btnWtfAjax">--%>
                <%--<span class="fa fa-book"></span>--%>
                <%--什么鬼AJAX--%>
            <%--</div>--%>
        </div>
    </div>
</section>

<!-- Main content -->
<section class="content">

</section>
<!-- /.content -->

<!-- jQuery 2.2.3 -->
<script src="<%=request.getContextPath()%>/plugins/jQuery/jquery-2.2.3.min.js"></script>
<!-- Bootstrap 3.3.6 -->
<script src="<%=request.getContextPath()%>/bootstrap/js/bootstrap.min.js"></script>
<!-- FastClick -->
<script src="<%=request.getContextPath()%>/plugins/fastclick/fastclick.js"></script>
<!-- AdminLTE App -->
<script src="<%=request.getContextPath()%>/dist/js/app.min.js"></script>
<!-- Sparkline -->
<script src="<%=request.getContextPath()%>/plugins/sparkline/jquery.sparkline.min.js"></script>
<!-- jvectormap -->
<script src="<%=request.getContextPath()%>/plugins/jvectormap/jquery-jvectormap-1.2.2.min.js"></script>
<script src="<%=request.getContextPath()%>/plugins/jvectormap/jquery-jvectormap-world-mill-en.js"></script>
<!-- SlimScroll 1.3.0 -->
<script src="<%=request.getContextPath()%>/plugins/slimScroll/jquery.slimscroll.min.js"></script>
<!-- ChartJS 1.0.1 -->
<script src="<%=request.getContextPath()%>/plugins/chartjs/Chart.min.js"></script>
<script src="<%=request.getContextPath()%>/dist/js/demo.js"></script>
</body>
</html>

<script type="text/javascript">
    $(function () {
        <%--$("#btnWtfPost").click(function () {--%>
            <%--$.post('<%=request.getContextPath()%>api/client/captcha', {--%>
                <%--mobile: "15901794296",--%>
            <%--}, function (result) {--%>
                <%--alert(result);--%>
            <%--});--%>

        <%--});--%>

        <%--$("#btnWtfAjax").click(function () {--%>
            <%--$.ajax({--%>
                <%--type :"post",--%>
                <%--data:{mobile:"15901794296"},--%>
                <%--url : "<%=request.getContextPath()%>api/client/captcha",--%>
                <%--success : function(result){--%>
                    <%--alert(result);--%>
                <%--}--%>
            <%--});--%>
        <%--})--%>
    });
</script>
