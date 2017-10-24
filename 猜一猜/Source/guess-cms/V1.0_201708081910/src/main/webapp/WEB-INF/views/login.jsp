<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap/css/bootstrapValidator.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/dist/css/AdminLTE.min.css">
    <script src="<%=request.getContextPath()%>/plugins/jQuery/jquery-2.2.3.min.js"></script>
    <script src="<%=request.getContextPath()%>/bootstrap/js/bootstrap.min.js"></script>
    <script src="<%=request.getContextPath()%>/bootstrap/js/bootstrapValidator.js"></script>
    <script src="<%=request.getContextPath()%>/layer/2.1/layer.js"></script>
    <script language="javascript">
      if (top != window)    
      top.location.href = window.location.href;    
  	</script>   
    <title>登录</title>
</head>
<body class="hold-transition login-page">
<div class="login-box">
    <div class="login-logo">
        猜一猜管理平台
    </div><!-- /.login-logo -->
    <div class="login-box-body">
        <p class="login-box-msg"></p>
        <form id="form_login" action="" method="post">
            <div class="form-group has-feedback">
                <input name="jg_login_user" type="text" class="form-control" id="userName" placeholder="您的用户名">
                <span class="glyphicon glyphicon-user form-control-feedback"></span>
            </div>
            <div class="form-group has-feedback">
                <input name="jg_login_pwd" type="password" class="form-control" id="password" placeholder="密码">
                <span class="glyphicon glyphicon-lock form-control-feedback"></span>
            </div>
            <div class="form-group">
                <div class="row">
                    <div class="col-xs-6">
                        <input name="jg_login_verify" type="text" class="form-control" id="validCode" placeholder="请输入验证码"/>
                    </div>
                    <div class="col-xs-6 text-right">
                        <img id="img_verify" style="max-width:100%;" src="<%=request.getContextPath()%>captcha-image"/>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-xs-8">
                    <div class="col-xs-8">
                        <div class="checkbox pull-right">
                            <a href="#">忘记密码</a>
                            <span>&nbsp;/&nbsp;</span>
                            <a href="#" class="text-center">注册</a>
                        </div>
                    </div>
                </div><!-- /.col -->
                <div class="col-xs-4">
                    <button id="btn_login" type="submit" class="btn btn-primary btn-block btn-flat">登录
                    </button>
                </div><!-- /.col -->
            </div>
        </form>
    </div><!-- /.login-box-body -->
</div><!-- /.login-box -->
</body>
</html>
<script>
    $(document).ready(function() {

        //登录表单验证
        $('#form_login').bootstrapValidator({
            message: '提交数据不能全为空',
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
                /*验证*/
                jg_login_user: {
                    /*键名username和input name值对应*/
                    message: '用户验证失败',
                    validators: {
                        notEmpty: {
                            /*非空提示*/
                            message: '用户名不能为空'
                        },
                        regexp: {
                            /* 只需加此键值对，包含正则表达式，和提示 */
                            regexp: /[a-zA-Z0-9_]{2,16}/ ,
                            message: '请正确输入您的用户名'
                        }
                    }
                },
                jg_login_pwd: {
                    message: '密码无效',
                    validators: {
                        notEmpty: {
                            message: '密码不能为空'
                        },
                        stringLength: {
                            min: 1,
                            max: 6,
                            message: '密码长度必须在6到30之间'
                        }
                    }
                }
            } //验证内容
        }).on('success.form.bv', function (e) {
            e.preventDefault();
            var $form = $(e.target);
            var bv = $form.data('bootstrapValidator');
            //这里提交表单
            $.post('<%=request.getContextPath()%>login', {
            		loginName: $("#userName").val(),
            		passWord: $("#password").val(),
            		validCode: $("#validCode").val(),
            }, function (result) {
            	if (result.msg == "") {
            		window.location.href='<%=request.getContextPath()%>index';
				}else{
					layer.msg(result.msg, { icon: 2 })
				}
            });
        });

        //验证图片点击后重新获取验证码
        $("#img_verify").on("click", function () {
            $(this).attr("src", "<%=request.getContextPath()%>captcha-image?t=" + Math.random());
        });
    })
</script>