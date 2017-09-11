<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>玩家详情</title>
    <%@ include file="../../../currency/top.jsp"%>
</head>

<body class="hold-transition skin-blue sidebar-mini">
<!-- Main content -->
<section class="content">
    <form role="form" class="form-horizontal" id="upForm">
        <input type="hidden"  class="cardId" value="">
        <input type="hidden"  class="accountId" value="">
         <div class="form-group">
            <label class="col-sm-2 control-label">头像</label>
            <div class="col-sm-3">
                <div id="layer-photos">
                    <img class="user-image headUrl" name="headUrl" style="width: 80px;height: 80px;"
                         src="https://image.caiecai.net/headers/header.png"
                         layer-src="https://image.caiecai.net/headers/header.png" src=="https://image.caiecai.net/headers/header.png" alt="头像"/>
                </div>
            </div>

         </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">昵称</label>
            <div class="col-sm-3">
                <input type="text" class="form-control nickName" name="nickName"  >
            </div>
            <label class="col-sm-2 control-label">手机号</label>
            <div class="col-sm-3">
                <input type="text" class="form-control phone" name="phone"  >
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">用户ID</label>
            <div class="col-sm-3">
                <input type="text" class="form-control bgLoginId" disabled>
            </div>
            <label class="col-sm-2 control-label" > 专属业务员</label>
            <div class="col-sm-3">
                <select  class="form-control beuserList" name="beUserId" >

                </select>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">账号余额</label>
            <div class="col-sm-3">
                <input type="text" class="form-control balance"  disabled >
            </div>
            <label class="col-sm-2 control-label">转码总量</label>
            <div class="col-sm-3">
                <input type="text" class="form-control totalLottery"  disabled >
            </div>
         </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">充值总额</label>
            <div class="col-sm-3">
                <div class="input-group">
                    <input type="text" class="form-control totalRecharge"   disabled >
                    <shiro:hasPermission name="20update">
                                     <span class="input-group-btn">
                                        <button  class="btn btn-default" type="button" id="listrecharge">查看明细</button>
                                    </span>
                    </shiro:hasPermission>
                </div>
            </div>
            <label class="col-sm-2 control-label"> 提现总额</label>
            <div class="col-sm-3">
                <div class="input-group">
                    <input type="text" class="form-control totalWithdraw" disabled   >
                    <shiro:hasPermission name="20update">
                                     <span class="input-group-btn">
                                        <button  class="btn btn-default" type="button" id="listwithdraw">查看明细</button>
                                    </span>
                    </shiro:hasPermission>
                </div>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">赢输统计</label>
            <div class="col-sm-3">
                <div class="input-group">
                    <input type="text" class="form-control actionTotle" disabled   >
                    <shiro:hasPermission name="20update">
                                     <span class="input-group-btn">
                                        <button  class="btn btn-default" type="button" id="listaction">查看明细</button>
                                    </span>
                    </shiro:hasPermission>
                </div>
            </div>
            <label class="col-sm-2 control-label" > 银行类型 </label>
            <div class="col-sm-3">
                <select  class="form-control bankEntityList" name="bankType">

                </select>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">最近登录</label>
            <div class="col-sm-3">
                <input type="text" class="form-control updateDate"  disabled >
            </div>
            <label class="col-sm-2 control-label">开户行</label>
            <div class="col-sm-3">
                <input type="text" class="form-control cardBank" name="cardBank"   >
            </div>
         </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">注册时间</label>
            <div class="col-sm-3">
                <input type="text" class="form-control createDate"  disabled >
            </div>
            <label class="col-sm-2 control-label">持卡人</label>
            <div class="col-sm-3">
                <input type="text" class="form-control cardName" name="cardName"   >
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label"> </label>
            <div class="col-sm-3">

            </div>
            <label class="col-sm-2 control-label">银行卡号</label>
            <div class="col-sm-3">
                <input type="text" class="form-control cardNo" name="cardNo"   >
            </div>
        </div>


        <div class="text-center" style="margin-top: 50px">
            <shiro:hasPermission name="20update">
                <button type="submit" class="btn btn-primary btn-lg" >
                    保存信息
                </button>
                <button type="button" class="btn btn-primary btn-lg" id="btnRecharge">
                    给TA充值
                </button>
            </shiro:hasPermission>
            <button type="button" class="btn btn-default btn-lg" id="btnClose">
                返回列表
            </button>
        </div>
     </form>

</section>
<!-- /.content -->

<%--给TA充值--%>
<div class="modal fade" id="systemGift" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
             <div class="modal-header" >
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">&times;</span>
                    <span class="sr-only"></span>
                </button>
                <h4 class="modal-title" id="myModalLabel">给TA充值</h4>
            </div>

            <div class="modal-body">
                <form class="form-horizontal"  id="editForm" action="" method="post">
                     <div class="form-group">
                        <label for="addbalance" class="col-sm-3 control-label">充值金额</label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control addbalance" name="addbalance" id="addbalance">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="remarks" class="col-sm-3 control-label">赠送原因</label>
                        <div class="col-sm-9">
                            <textarea class="form-control" name="remarks" id="remarks"></textarea>
                        </div>
                    </div>
                     <div class="modal-footer">
                         <button type="submit" class="btn btn-primary btn-lg"  >
                             确认充值
                         </button>
                     </div>
                </form>
            </div>
            <!-- modal-body END -->
        </div>
    </div>
</div>
</body>
</html>
<%@ include file="../../../currency/js.jsp"%>
<script>
    var id = agdress.getQueryString("userId");
    window.userId = id;

    $(function () {

        loadForm();
        //加载页面数据
        function loadForm() {
             //获取玩家详情
            agdress.post('ss_user/findById',JSON.stringify({userId :  window.userId}),function (result) {
//                console.log(result);
                bindFormData(result);
                //TODO
            },function (err) {
                layer.msg('玩家详情获取失败！'+ err.message, {icon: 2});
            },"application/json");
        }

        //页面数据绑定
        function bindFormData(usepd) {

//            $(".head_url").attr("src",usepd.head_url);
//            $(".head_url").attr("layer-src",usepd.head_url);
//            $(".head_url").attr("alt",usepd.nickname);
            var imgurl=usepd.headUrl;
            if(imgurl == ""){
                imgurl="../../apiresources/img/icon.png";
            }
            $(".headUrl").attr("src",imgurl);
            $(".headUrl").attr("layer-src",imgurl);
            $(".headUrl").attr("alt",usepd.nickName);

            $(".phone").val(usepd.phone);
            $(".bgLoginId").val(usepd.bgLoginId);
            $(".nickName").val(usepd.nickName);


            $(".createDate").val( agdress.timeStamp2String(usepd.createDate));
            $(".updateDate").val(agdress.timeStamp2String(usepd.updateDate));
            //银行卡
            $(".cardBank").val(usepd.cardBank);
            $(".cardNo").val(usepd.cardNo);
            $(".cardName").val(usepd.cardName);
            $(".cardId").val(usepd.cardId);
            //余额以及总额
            $(".accountId").val(usepd.accountId);
            $(".balance").val(usepd.balance);
            $(".totalRecharge").val(usepd.totalRecharge);
            $(".totalWithdraw").val(usepd.totalWithdraw);
            $(".actionTotle").val(usepd.actionTotle);
            $(".totalLottery").val(usepd.totalLottery);
            //循环业务员
            var beuserList=usepd.beuserList;
            $(".beuserList").empty();
            for(var i =0 ;i <beuserList.length ; i++){
                $(".beuserList").append("<option value="+beuserList[i].userId+">"+beuserList[i].nickName+"</option>");
            }
            $(".beuserList").val(usepd.beUserId);
            //循环银行卡信息
            var bankEntityList=usepd.bankEntityList;
            $(".bankEntityList").empty();
            for(var i =0 ;i <bankEntityList.length ; i++){
                $(".bankEntityList").append("<option value="+bankEntityList[i].bankType+">"+bankEntityList[i].bankName+"</option>");
            }
            $(".bankEntityList").val(usepd.bankType);

            layer.photos({
                photos:'#layer-photos'
                ,anim: 5
            });


        };

        //表单验证
        $("#editForm").bootstrapValidator({
            message: 'This value is not valid',
            feedbackIcons: {/*输入框不同状态，显示图片的样式*/
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {/*验证*/
                 addbalance: {
                    validators: {
                        notEmpty: {/*非空提示*/
                            message: '请输入充值金额！'
                        },
                        regexp: {
                            regexp: /^[0-9]*$/,
                            message: '只能是数值格式！'
                        }
                    }
                },
                stringLength: {/*长度提示*/
                    min: 5,
                    max: 100,
                    message: '请输入5到50个汉字！'
                }
            }
        }).on('success.form.bv', function(e) {
            // Prevent form submission
            e.preventDefault();
            layer.confirm('确定给TA充值吗？', {
                btn: ['确定','取消'] //按钮
            }, function(index) {
                $.ajax({
                    type: "POST",
                    url: agdress.CONSTS.URL_BASE_API+"ss_user/updateUserBalance",
                    data: {
                        "accountId" : $(".accountId").val(),
                        "userId"    :  window.userId,
                        "addbalance" : $(".addbalance").val(),
                        "remarks"    : $("#remarks").val(),
                        "updateBy"  : <shiro:principal property="id"/>
                    },
                    async: false,
                    success: function (data) {
                        layer.msg('充值成功！');
                        $("#systemGift").modal("hide");
                        loadForm();
                    },error: function(error) {
                        layer.msg(error.responseText, {icon: 2});
                    }
                });
                layer.close(index);
            }, function(index){
                layer.close(index);
            });
        });

        //给TA充值
        $("#btnRecharge").on("click", function () {
             $("#systemGift").modal("show");
        });

        //关闭页面
        $("#btnClose").on('click',function () {
            var id = "user_"+window.userId;
            window.parent.closeMyTab(id);
        });

        //查看充值记录
        $("#listrecharge").on("click", function () {
            var url = 'ss_ac_detail/manager?userId='+window.userId+'&tradeType=1011';
            var id = "Account_10"+window.userId;
            var title = "充值明细【" + $(".nickName").val() +"】";
            window.parent.openNewTab(id,title,url);
            return;
        });


        //查看提现记录
        $("#listwithdraw").on("click", function () {
            var url = 'ss_ac_detail/manager?userId='+window.userId+'&tradeType=50';
            var id = "Account_50"+window.userId;
            var title = "提现明细【" + $(".nickName").val() +"】";
            window.parent.openNewTab(id,title,url);
            return;
        });

        //查看输赢记录
        $("#listaction").on("click", function () {
            var url = 'ss_ac_detail/manager?userId='+window.userId+'&tradeType=3040';
            var id = "Account_3040"+window.userId;
            var title = "输赢明细【" + $(".nickName").val() +"】";
            window.parent.openNewTab(id,title,url);
            return;
        });



        //保存信息表单验证
        $("#upForm").bootstrapValidator({
            message: 'This value is not valid',
            feedbackIcons: {/*输入框不同状态，显示图片的样式*/
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {/*验证*/
                phone: {
                    validators: {
                        notEmpty: {/*非空提示*/
                            message: '请输入电话号码！'
                        },
                        regexp: {
                            regexp: /^(13[0-9]|15[0-9]|18[0-9]|147|145|149|170|171|173|175|176|177|178)\d{8}$/,
                            message: '输入正确的手机号码！'
                        }
                    }
                },
                nickName: {
                    validators: {
                        notEmpty: {/*非空提示*/
                            message: '请输入昵称！'
                        }
                    }
                },
                cardName: {
                    validators: {
                        notEmpty: {/*非空提示*/
                            message: '请输入持卡人！'
                        }
                    }
                },
                cardNo: {
                    validators: {
                        notEmpty: {/*非空提示*/
                            message: '请输入银行卡号！'
                        },
                        regexp: {
                            regexp: /^([1-9]{1})(\d{14}|\d{18})$/,
                            message: '输入正确的银行卡号！'
                        }
                    }
                },
                cardBank: {
                    validators: {
                        notEmpty: {/*非空提示*/
                            message: '请输入开户行！'
                        }
                    }
                },
                beUserId: {
                    validators: {
                        notEmpty: {/*非空提示*/
                            message: '请选择业务员！'
                        }
                    }
                },
                bankType: {
                    validators: {
                        notEmpty: {/*非空提示*/
                            message: '请选择银行类型！'
                        }
                    }
                }
            }
        }).on('success.form.bv', function(e) {
            // Prevent form submission
            e.preventDefault();
            var updateBy=<shiro:principal property="id"/>;
            $.ajax({
                type: "POST",
                url: agdress.CONSTS.URL_BASE_API+"ss_user/updateUserSomeInfor",
                data: {
                    "userId"   : window.userId ,
                    "phone"     : $(".phone").val(),
                    "nickName"  : $(".nickName").val(),
                    "cardId"   : $(".cardId").val(),
                    "cardName" : $(".cardName").val(),
                    "cardNo"   : $(".cardNo").val(),
                    "cardBank" : $(".cardBank").val(),
                    "bankType" : $(".bankEntityList").val(),
                    "beUserId": $(".beuserList").val(),
                    "updateBy" : updateBy
                },
                async: false,
                success: function (data) {
                    layer.msg('修改成功！');
                    loadForm();
                },error: function(error) {
                    layer.msg(error.responseText, {icon: 2});
                }
            });
        });


    });
</script>

