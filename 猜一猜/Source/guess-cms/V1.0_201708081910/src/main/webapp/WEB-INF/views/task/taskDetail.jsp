<%@ page import="com.cicada.commons.utils.SystemConfig" %>
<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>竞猜详情</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/dist/css/font-awesome.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/dist/css/ionicons.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/dist/css/AdminLTE.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/dist/css/skins/all-skins.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/plugins/datatables/jquery.dataTables.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/plugins/datatables/dataTables.bootstrap.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/plugins/datetimepicker/css/bootstrap-datetimepicker.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap/fileinput/css/fileinput.min.css">
</head>

<body class="hold-transition skin-blue sidebar-mini">
    <%--<section class="content-header">--%>
        <%--<div class="box-header">--%>
            <%--<h3 class="box-title">竞猜详情</h3>--%>
        <%--</div>--%>
    <%--</section>--%>

    <!-- Main content -->
    <section class="content">
        <form role="form" class="form-horizontal" id="detailForm">
            <input type="hidden" name="task_id" value="0">
            <input type="hidden" name="user_id" value="1">
            <input type="hidden" name="answer_right_id" value="0">
            <input type="hidden" name="answer_err_id" value="0">
            <input type="hidden" name="answer_awin_id" value="0">
            <input type="hidden" name="answer_dogfall_id" value="0">
            <input type="hidden" name="answer_bwin_id" value="0">
            <%--竞猜类型--%>
            <div class="form-group">
                <label class="col-sm-2 control-label">竞猜类型</label>
                <div class="col-sm-8">
                    <select class="form-control" name="task_type">
                        <option value="0">图文竞猜</option>
                        <option value="1">足球竞猜</option>
                        <option value="2">篮球竞猜</option>
                        <option value="3">时事竞猜</option>
                    </select>
                </div>
            </div>
            <%--内容描述--%>
            <div class="form-group">
                <label class="col-sm-2 control-label">内容描述<br>(10-40个字)</label>
                <div class="col-sm-8">
                    <textarea class="form-control" name="task_content"></textarea>
                </div>
            </div>

            <%--答案图--%>
            <div class="form-group" id ="divImgRight">
                <label class="col-sm-2 control-label">答案图</label>
                <div class="col-md-8">
                    <div class="row">
                        <input id="file_right" name="img_right" type="file">
                    </div>
                </div>
            </div>
            <%--参考图--%>
            <div class="form-group" id ="divImgOthers">
                <label class="col-sm-2 control-label">参考图<br>(1~3张)</label>
                <div class="col-md-8">
                    <div class="row">
                        <input id="file_others" name="img_others" type="file" multiple>
                    </div>
                </div>
            </div>
            <%--正确答案--%>
            <div class="form-group" id="divAnswerRight">
                <label class="col-sm-2 control-label" id="lblRightAnswer">正确答案</label>
                <div class="col-sm-3">
                    <input type="text" class="form-control" name="answer_right">
                </div>
                <label class="col-sm-1 control-label" >赔率</label>
                <div class="col-sm-3">
                    <div class="input-group">
                         <span class="input-group-btn">
                           <button class="btn btn-default" type="button">-</button>
                         </span>
                        <input type="text" class="form-control" name="answer_right_odds" placeholder="正确答案赔率">
                        <span class="input-group-btn">
                           <button class="btn btn-default" type="button">+</button>
                         </span>
                    </div>
                </div>
            </div>
            <%--错误答案--%>
            <div class="form-group" id="divAnswerErr">
                <label class="col-sm-2 control-label" id="lblErrorAnswer">错误答案</label>
                <div class="col-sm-3">
                    <input type="text" class="form-control" name="answer_err">
                </div>
                <label class="col-sm-1 control-label" >赔率</label>
                <div class="col-sm-3">
                    <div class="input-group">
                         <span class="input-group-btn">
                           <button class="btn btn-default" type="button">-</button>
                         </span>
                        <input type="text" class="form-control" name="answer_err_odds" placeholder="错误答案赔率">
                        <span class="input-group-btn">
                           <button class="btn btn-default" type="button">+</button>
                         </span>
                    </div>
                </div>
            </div>

            <%--球队信息--%>
            <div class="form-group" style="display: none" id="divTeamInfo">
                <label class="col-sm-2 control-label">主场<br></label>
                <div class="col-sm-3">
                    <input type="text" class="form-control" name="team_name_a">
                    <%--<select class="form-control" name ="team_name_a">--%>
                        <%--<option value="0">中国</option>--%>
                        <%--<option value="1">美国</option>--%>
                    <%--</select>--%>
                </div>
                <label class="col-sm-1 control-label">客场<br></label>
                <div class="col-sm-3">
                    <input type="text" class="form-control" name="team_name_b">
                    <%--<select class="form-control" name ="team_name_b">--%>
                        <%--<option value="0">中国</option>--%>
                        <%--<option value="1">美国</option>--%>
                    <%--</select>--%>
                </div>
            </div>
            <%--答案一（足彩 主场胜）--%>
            <div class="form-group" style="display: none" id="divAnswerAWin">
                <label class="col-sm-2 control-label" >主胜&nbsp;&nbsp;赔率</label>
                <div class="col-sm-3">
                    <div class="input-group">
                         <span class="input-group-btn">
                           <button class="btn btn-default" type="button">-</button>
                         </span>
                        <input type="text" class="form-control" name="odds_a_win" placeholder="主场胜赔率">
                        <span class="input-group-btn">
                           <button class="btn btn-default" type="button">+</button>
                         </span>
                    </div>
                </div>
            </div>
            <%--答案二（足彩 平）--%>
            <div class="form-group" style="display: none" id="divAnswerDogfall">
                <label class="col-sm-2 control-label" >平局&nbsp;&nbsp;&nbsp;&nbsp;赔率</label>
                <div class="col-sm-3">
                    <div class="input-group">
                         <span class="input-group-btn">
                           <button class="btn btn-default" type="button">-</button>
                         </span>
                        <input type="text" class="form-control" name="odds_dogfall" placeholder="平局赔率">
                        <span class="input-group-btn">
                           <button class="btn btn-default" type="button">+</button>
                         </span>
                    </div>
                </div>
            </div>
            <%--答案三（足彩 主场负）--%>
            <div class="form-group" style="display: none" id="divAnswerBWin">
                <label class="col-sm-2 control-label" >客胜&nbsp;&nbsp;赔率</label>
                <div class="col-sm-3">
                    <div class="input-group">
                         <span class="input-group-btn">
                           <button class="btn btn-default" type="button">-</button>
                         </span>
                        <input type="text" class="form-control" name="odds_b_win" placeholder="客场胜赔率">
                        <span class="input-group-btn">
                           <button class="btn btn-default" type="button">+</button>
                         </span>
                    </div>
                </div>
            </div>

            <%--单注价格--%>
            <div class="form-group">
                <label class="col-sm-2 control-label" >单注价格</label>
                <div class="col-sm-3">
                    <input type="text" class="form-control" name="sale_price">
                </div>
                <label class="col-sm-2 control-label" >总注数(1-100)</label>
                <div class="col-sm-2">
                    <input type="text" class="form-control" name ="quantity">
                </div>
                <div class="col-sm-3">
                    <label class="control-label" >共：<span id ="sale_amount">2000</span>金币</label>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">锁定下注时间</label>
                <div class="col-sm-3 input-append date form_datetime">
                    <input type="text" class="form-control" name="lock_time" size="16" value="" readonly>
                    <span class="add-on"><i class="icon-th"></i></span>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label" >开奖时间</label>
                <div class="col-sm-3 input-append date form_datetime">
                    <input type="text" class="form-control" name="settle_time" size="16" value="" readonly>
                    <span class="add-on"><i class="icon-th"></i></span>
                </div>
                <label class="col-sm-2 control-label" >设为热门</label>
                <div class="col-sm-2">
                    <div class="checkbox-inline">
                        <input type="radio" name="hot" value="1" id ="hot_yes"><label for="hot_yes" style="cursor:pointer">&nbsp;&nbsp;是&nbsp;&nbsp;</label>
                    </div>
                    <div class="checkbox-inline">
                        <input type="radio" name="hot" value="0" checked id="hot_no"><label for="hot_no" style="cursor:pointer">&nbsp;&nbsp;否&nbsp;&nbsp;</label>
                    </div>
                </div>
            </div>

            <%--<div class="form-group">--%>
                <%--<img src="" name ="select_img" id="select_img">--%>
                <%--<input id="testfile" type="file" multiple>--%>
            <%--</div>--%>

            <div class="from-group text-center">
                <div class="btn-group">
                    <button type="button" class="btn btn-primary btn-sm" id="btnSave">
                        <i class="fa fa-plus"></i> 发布
                    </button>
                </div>
                 <div class="btn-group">
                    <button type="button" class="btn btn-primary btn-sm" id="btnCancel">
                        <i class="fa fa-remove"></i> 取消
                    </button>
                </div>
            </div>
        </form>
    </section>
    <!-- /.content -->
</body>
</html>
<script src="<%=request.getContextPath()%>/plugins/jQuery/jquery-2.2.3.min.js"></script>
<script src="<%=request.getContextPath()%>/bootstrap/js/bootstrap.js"></script>
<script src="<%=request.getContextPath()%>/bootstrap/js/bootstrapValidator.js"></script>
<script src="<%=request.getContextPath()%>/plugins/datatables/dataTables.bootstrap.js"></script>
<script src="<%=request.getContextPath()%>/plugins/datatables/jquery.dataTables.js"></script>
<script src="<%=request.getContextPath()%>/plugins/slimScroll/jquery.slimscroll.min.js"></script>
<script src="<%=request.getContextPath()%>/plugins/fastclick/fastclick.js"></script>
<script src="<%=request.getContextPath()%>/dist/js/app.min.js"></script>
<script src="<%=request.getContextPath()%>/plugins/datetimepicker/js/bootstrap-datetimepicker.min.js"></script>
<script src="<%=request.getContextPath()%>/plugins/datetimepicker/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script src="<%=request.getContextPath()%>/bootstrap/fileinput/js/plugins/canvas-to-blob.min.js"></script>
<script src="<%=request.getContextPath()%>/bootstrap/fileinput/js/plugins/piexif.min.js"></script>
<script src="<%=request.getContextPath()%>/bootstrap/fileinput/js/fileinput.min.js"></script>
<script src="<%=request.getContextPath()%>/bootstrap/fileinput/js/locales/zh.js"></script>
<script src="<%=request.getContextPath()%>/layer/2.1/layer.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/cicada.main.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/DateUtility.js"></script>
<script>
    $(function () {
        cicada.CONSTS.URL_BASE = "<%=SystemConfig.getInstance().getURL_BASE()%>";
        cicada.CONSTS.URL_BASE_API = "<%=SystemConfig.getInstance().getURL_BASE_API()%>";
        cicada.CONSTS.URL_BASE_IMG = "<%=SystemConfig.getInstance().getURL_BASE_IMG()%>";
        cicada.CONSTS.URL_BASE_IMG_TASK = "<%=SystemConfig.getInstance().getURL_BASE_IMG_TASK()%>";

        $("input[name='lock_time']").datetimepicker({language: "zh-CN",format: 'yyyy-mm-dd hh:ii',autoclose:true});
        $("input[name='settle_time']").datetimepicker({language: "zh-CN",format: 'yyyy-mm-dd hh:ii',autoclose:true});
        $("input[name='lock_time']").val("");
        $("input[name='settle_time']").val(new Date().addDate("HOUR",99).format(cicada.CONSTS.DATE_FORMAT_YMD_HM));

        cicada.initFileInput("file_right",1,cicada.CONSTS.URL_BASE+'pic/upload');
        cicada.initFileInput("file_others",3,cicada.CONSTS.URL_BASE+'pic/upload');

        $("select[name='task_type']").on("change",function () {
           var task_type = this.value;
           if(task_type == cicada.ENUMS.TASK_TYPE.normal || task_type == cicada.ENUMS.TASK_TYPE.coming){
               $("#divImgRight").show();
               $("#divImgOthers").show();
               $("#divAnswerRight").show();
               $("#divAnswerErr").show();

               $("#divTeamInfo").hide();
               $("#divAnswerAWin").hide();
               $("#divAnswerDogfall").hide();
               $("#divAnswerBWin").hide();

               $("#lblRightAnswer").html(task_type == cicada.ENUMS.TASK_TYPE.normal?"正确答案":"答案1")
               $("#lblErrorAnswer").html(task_type == cicada.ENUMS.TASK_TYPE.normal?"错误答案":"答案2")

           }else if(task_type == cicada.ENUMS.TASK_TYPE.basketball){
               $("#divImgRight").hide();
               $("#divImgOthers").hide();
               $("#divAnswerRight").hide();
               $("#divAnswerErr").hide();

               $("#divTeamInfo").show();
               $("#divAnswerAWin").show();
               $("#divAnswerDogfall").hide();//篮球没有平局
               $("#divAnswerBWin").show();
           }else{
               //足球
               $("#divImgRight").hide();
               $("#divImgOthers").hide();
               $("#divAnswerRight").hide();
               $("#divAnswerErr").hide();

               $("#divTeamInfo").show();
               $("#divAnswerAWin").show();
               $("#divAnswerDogfall").show();
               $("#divAnswerBWin").show();
           }
        });

        $("#btnSave").on("click",function () {
            var form = new FormData(document.getElementById("detailForm"));

            //验证数据有效性
            if(!checkData(form)) return;

            layer.confirm('确定要发布竞猜吗？', {
                btn: ['发布','取消'] //按钮
            }, function(index){

                var taskType = form.get("task_type");

                if(!cicada.isNullOrEmpty(form.get("lock_time")))
                    form.set("lock_time", new Date(form.get("lock_time")).format(cicada.CONSTS.DATE_FORMAT_YMD_HMS));
                if(!cicada.isNullOrEmpty(form.get("settle_time")))
                    form.set("settle_time", new Date(form.get("settle_time")).format(cicada.CONSTS.DATE_FORMAT_YMD_HMS));

                if( taskType == cicada.ENUMS.TASK_TYPE.normal
                    || taskType == cicada.ENUMS.TASK_TYPE.coming){
                    form.set("odds_a_win",0);
                    form.set("odds_dogfall",0);
                    form.set("odds_b_win",0);
                }else{

                    //篮球没有平局
                    if(taskType == cicada.ENUMS.TASK_TYPE.basketball){
                        form.set("odds_dogfall",0);
                    }

                    form.set("answer_right_odds",0);
                    form.set("answer_err_odds",0);

                    form.delete("img_right");
                    form.delete("img_others");

                }
                cicada.post('task/publish',form,function (result) {
                    layer.msg('发布成功！');
                    this.clearForm();
                },function (err) {

                    layer.msg('保存失败！'+ err.message, {icon: 2});
                });

                layer.close(index);
            }, function(index){
                layer.close(index);
            });
        });

        //表单验证
        $("#detailForm").bootstrapValidator({
            message: 'This value is not valid',
            feedbackIcons: {/*输入框不同状态，显示图片的样式*/
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {/*验证*/
                task_content: {/*键名task_content和input name值对应*/
                    validators: {
                        notEmpty: {/*非空提示*/
                            message: '请输入竞猜内容！'
                        },
                        stringLength: {/*长度提示*/
                            min: 10,
                            max: 40,
                            message: '竞猜内容只能输入10到40个汉字'
                        }
                    }
                },
                answer_right: {
                    validators: {
                        notEmpty: {/*非空提示*/
                            message: '请输入正确答案！'
                        },
                        stringLength: {/*长度提示*/
                            min: 1,
                            max: 6,
                            message: '正确答案不能超过6个字'
                        }
                    }
                },
                answer_err: {
                    validators: {
                        notEmpty: {/*非空提示*/
                            message: '请输入错误答案！'
                        },
                        stringLength: {/*长度提示*/
                            min: 1,
                            max: 6,
                            message: '正确答案不能超过6个字'
                        }
                    }
                },
                answer_right_odds: {
                    validators: {
                        regexp: {
                            regexp: /^\d+(\.\d{2})?$/,
                            message: '赔率只能是含2位小数的数值'
                        }
                    }
                },
                answer_err_odds: {
                    validators: {
                        regexp: {
                            regexp: /^\d+(\.\d{2})?$/,
                            message: '赔率只能是含2位小数的数值'
                        }
                    }
                },
                sale_price: {
                    validators: {
                        notEmpty: {/*非空提示*/
                            message: '请输入单注价格！'
                        },
                        regexp: {
                            regexp: /^[0-9]*$/,
                            message: '总注数只能是数值格式'
                        }
                    }
                },
                quantity: {
                    validators: {
                        notEmpty: {/*非空提示*/
                            message: '请输入总注数！'
                        },
                        regexp: {
                            regexp: /^[0-9]*$/,
                            message: '总注数只能是数值格式'
                        }
                    }
                }
            }
        })
//        .on('success.form.bv', function(e) {//点击提交之后
//            // Prevent form submission
//            e.preventDefault();
//
//            // Get the form instance
//            var $form = $(e.target);
//
//            // Get the BootstrapValidator instance
//            var bv = $form.data('bootstrapValidator');
//
//            // Use Ajax to submit form data 提交至form标签中的action，result自定义
//            $.post($form.attr('action'), $form.serialize(), function(result) {
////do something...
//            });
//        });

        /**
         * 验证数据有效性
         * @param formData
         * @returns {boolean}
         */
        function checkData(formData) {
            var errmsg = [];

            if(cicada.isNullOrEmpty(formData.get("task_content"))){
                errmsg.push("请输入竞猜内容描述！");
            }

            var taskType = formData.get("task_type");
            if(taskType == cicada.ENUMS.TASK_TYPE.normal || taskType == cicada.ENUMS.TASK_TYPE.coming){
                var imgRight = formData.get("img_right");
                var imgOthers = formData.getAll("img_others");

                var lblRight = (taskType == cicada.ENUMS.TASK_TYPE.normal?"正确答案":"答案一")
                var lblError = (taskType == cicada.ENUMS.TASK_TYPE.normal?"错误答案":"答案二")

                if(cicada.isNullOrEmpty(imgRight.name) && taskType == cicada.ENUMS.TASK_TYPE.normal){
                    errmsg.push("请选择一张答案图！");
                }
                if((imgOthers.length == 0 || imgOthers.length >3) && taskType == cicada.ENUMS.TASK_TYPE.normal){
                    errmsg.push("请选择1~3张参考图！");
                }
                if(cicada.isNullOrEmpty(formData.get("answer_right"))){
                    errmsg.push("请输入"+lblRight+"！");
                }
                if (cicada.isNullOrEmpty(formData.get("answer_right_odds"))){
                    errmsg.push("请设置"+lblRight+"赔率！");
                }
                if(cicada.isNullOrEmpty(formData.get("answer_err"))){
                    errmsg.push("请输入"+lblError+"！");
                }
                if (cicada.isNullOrEmpty(formData.get("answer_right_odds"))){
                    errmsg.push("请设置"+lblError+"赔率！");
                }
            }else{
                if(cicada.isNullOrEmpty(formData.get("team_name_a"))||cicada.isNullOrEmpty(formData.get("team_name_b"))){
                    errmsg.push("请输入球队信息！");
                }
                if (cicada.isNullOrEmpty(formData.get("odds_a_win"))){
                    errmsg.push("请设置主胜利赔率！");
                }
                if(taskType != cicada.ENUMS.TASK_TYPE.basketball
                    && cicada.isNullOrEmpty(formData.get("odds_dogfall"))){
                    errmsg.push("请设置平局赔率！");
                }
                if (cicada.isNullOrEmpty(formData.get("odds_b_win"))){
                    errmsg.push("请设置客胜利赔率！");
                }
            }

            if(cicada.isNullOrEmpty(formData.get("sale_price"))){
                errmsg.push("请设置单价！");
            }
            if(cicada.isNullOrEmpty(formData.get("quantity"))){
                errmsg.push("请输入总注数！");
            }
            if(cicada.isNullOrEmpty(formData.get("settle_time"))){
                errmsg.push("请设置开奖时间！");
            }

            if(cicada.isNullOrEmpty(errmsg) || errmsg.length === 0)
                return true;
            else{
                var msg = cicada.getMessageListHtml(errmsg);
                layer.msg(msg,{icon:2});
                return false;
            }
        }

        function clearForm() {
            //TODO 清空当前页面数据

        }
        
        //这个方法通过新建canvas标签并转为dataurl来进一步压缩，返回base64格式地址 再转成blob对象
        function getCompressedBlobImage(img, rate, quantity) {
            var canvas = document.createElement("canvas")
            console.log("原始尺寸")
            console.log(img.width)
            console.log(img.height)

            var ratio = img.width / img.height
            var compWidth = img.width * rate
            var compHeight = img.height * rate
            if (compWidth > 800 || compHeight > 800) {
                if (compWidth > compHeight) {
                    compWidth = 800
                    compHeight = compWidth / ratio
                } else {
                    compHeight = 800
                    compWidth = compHeight * ratio
                }
            }

            canvas.width = compWidth;
            canvas.height = compHeight;

            var ctx = canvas.getContext("2d");
            ctx.drawImage(img, 0, 0, img.width, img.height, 0, 0, compWidth, compHeight);
            console.log("压缩后尺寸")
            console.log(compWidth)
            console.log(compHeight)

            console.log("压缩质量")
            console.log(quantity)

            var dataURL = canvas.toDataURL("image/jpeg");

            //BASE64转换成blob对象
            var arr = dataurl.split(','), mime = arr[0].match(/:(.*?);/)[1],
                bstr = atob(arr[1]), n = bstr.length, u8arr = new Uint8Array(n);
            while(n--){
                u8arr[n] = bstr.charCodeAt(n);
            }
            return new Blob([u8arr], {type:mime});
        };
    });

</script>

