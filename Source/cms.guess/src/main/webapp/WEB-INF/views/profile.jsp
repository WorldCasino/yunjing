<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>  
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>AdminLTE 2 | Dashboard</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap/css/bootstrap.min.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/dist/css/font-awesome.min.css">
    <!-- Ionicons -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/dist/css/ionicons.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/dist/css/AdminLTE.min.css">
    <!-- AdminLTE Skins. Choose a skin from the css/skins
         folder instead of downloading all of them to reduce the load. -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/dist/css/skins/all-skins.min.css">
    <!--bootstrap上传图片-->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap/fileinput/css/fileinput.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap/css/bootstrapValidator.css">
</head>
<body class="hold-transition skin-blue sidebar-mini">
<section class="content-header">
    <div class="box-header">
        <h3 class="box-title">个人基本信息</h3>
    </div>
</section>

<!-- Main content -->
<section class="content">
    <form role="form" class="form-horizontal" id="upForm">
        <div class="form-group">
            <label class="col-sm-2 control-label">姓名</label>
            <div class="col-sm-6">
                <input type="text" class="form-control" id="name"  readOnly="true" name="name" value="<shiro:principal property="name" />">
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-2 control-label">电话号码</label>
            <div class="col-sm-6">
                <input type="text" class="form-control" id="tel" name="tel" placeholder="请输入您的电话号码">
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-2 control-label" >请输入身份号码</label>
            <div class="col-sm-6">
                <input type="text" class="form-control" id="idCard" name="idCard" placeholder="请输入有效证件号码">
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-2 control-label">身份证照片上传</label>
            <div class="col-md-6">
                <input id="imgUp" name="imgUp" type ="file" multiple  class="file-loading">
            </div>
        </div>

    </form>
</section>
<!-- /.content -->

<!-- jQuery 2.2.3 -->
<script src="<%=request.getContextPath()%>/plugins/jQuery/jquery-2.2.3.min.js"></script>
<!-- Bootstrap 3.3.6 -->
<script src="<%=request.getContextPath()%>/bootstrap/js/bootstrap.min.js"></script>
<script src="<%=request.getContextPath()%>/bootstrap/js/bootstrapValidator.js"></script>
<!-- Slimscroll -->
<script src="<%=request.getContextPath()%>/plugins/slimScroll/jquery.slimscroll.min.js"></script>
<!-- FastClick -->
<script src="<%=request.getContextPath()%>/plugins/fastclick/fastclick.js"></script>
<!-- AdminLTE App -->
<script src="<%=request.getContextPath()%>/dist/js/app.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="<%=request.getContextPath()%>/dist/js/demo.js"></script>
<!--tabs-->
<script src="<%=request.getContextPath()%>/dist/js/app_iframe.js"></script>
<script src="<%=request.getContextPath()%>/bootstrap/fileinput/js/fileinput.min.js"></script>
<script src="<%=request.getContextPath()%>/bootstrap/fileinput/js/locales/zh.js"></script>
</body>
</html>
<script>

    $(function () {
        //0.初始化fileinput
        var oFileInput = new FileInput();
        oFileInput.Init("imgUp", "<%=request.getContextPath()%>pic/upload");

    });
    //初始化fileinput
    var FileInput = function () {
        var oFile = new Object();
        //初始化fileinput控件（第一次初始化）
        oFile.Init = function(ctrlName, uploadUrl) {
            var control = $('#' + ctrlName);
            //初始化上传控件的样式
            control.fileinput({
                language: 'zh', //设置语言
                uploadUrl: uploadUrl, //上传的地址
                allowedFileExtensions: ['jpg', 'gif', 'png'],//接收的文件后缀
                showUpload: true, //是否显示上传按钮
                showCaption: false,//是否显示标题
                browseClass: "btn btn-primary", //按钮样式
                dropZoneEnabled: false,//是否显示拖拽区域
//                minImageWidth: 50, //图片的最小宽度
//                minImageHeight: 50,//图片的最小高度
//                maxImageWidth: 120,//图片的最大宽度
//                maxImageHeight: 120,//图片的最大高度
                maxFileSize: 2048,//单位为kb，如果为0表示不限制文件大小
                //minFileCount: 0,
                maxFileCount: 3, //表示允许同时上传的最大文件个数
                enctype: 'multipart/form-data',
                validateInitialCount:true,
                previewFileIcon: "<i class='glyphicon glyphicon-king'></i>",	
                msgFilesTooMany: "选择上传的文件数量({n}) 超过允许的最大数值{m}！",
            });
            //导入文件上传完成之后的事件
            $("#imgUp").on("fileuploaded", function (event, data, previewId, index) {
//                $("#myChange").modal("hide");
                var data = data.response.lstOrderImport;
                if (data == undefined) {
                    toastr.error('文件格式类型不正确');
                    return;
                }
            });
        }
        return oFile;
    };

</script>
