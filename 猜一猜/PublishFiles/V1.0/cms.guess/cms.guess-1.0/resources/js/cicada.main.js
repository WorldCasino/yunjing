(function(window,document){
    var cicada = function () {
    };

    /**
     * 系统常量
     * @type {{TASK_STATUS: [*], DAYS_OF_WEEK: [*], MONTH_NAMES: [*]}}
     */
    cicada.CONSTS ={
        /**
         * 视图URL
         */
        URL_BASE:"https://cms.caiecai.net/rest/",
        /**
         * 接口URL
         */
        URL_BASE_API:"https://cms.caiecai.net/rest/api/",

        /**
         * 图片服务器URL
         */
        URL_BASE_IMG:"https://image.caiecai.net/",
        URL_BASE_IMG_TASK:"https://image.caiecai.net/task/",

        DAYS_OF_WEEK:["日","一","二","三","四","五","六"],

        MONTH_NAMES:["一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"],

        /**
         * 日期格式
         */
        DATE_FORMAT:"yyyy-MM-dd",
        /**
         * 日期格式
         */
        DATE_FORMAT_YMD_HM:"yyyy-MM-dd HH:mm",
        /**
         * 日期格式
         */
        DATE_FORMAT_YMD_HMS:"yyyy-MM-dd HH:mm:ss",
        /**
         * 日期格式
         */
        DATE_FORMAT_MD_HM:"yy-MM-dd HH:mm"
    };

    /**
     * 系统用到的枚举类型
     * @type {{TASK_TYPE: {normal: number, football: number, basketball: number, coming: number, list: [*], getName: getName}, TASK_STATUS: {waitingAudit: number, published: number, complete: number, canceled: number, paused: number, list: [*], getName: getName}}}
     */
    cicada.ENUMS = {
        /**
         * 竞猜类型
         */
        TASK_TYPE:{
            normal:0,
            football:1,
            basketball:2,
            coming:3,
            list:[
                {id:0,name:"图文竞猜"},
                {id:1,name:"足球竞猜"},
                {id:2,name:"篮球竞猜"},
                {id:3,name:"时事竞猜"}
            ],
            getName:function (code) {
               return cicada.getEnumName(this.list,code);
            }
        },

        /**
         * 竞猜状态
         */
        TASK_STATUS:{
            waitingAudit:10,
            published:20,
            complete:30,
            canceled:40,
            paused:50,
            list:[
                {id:10,name:"审核中"},
                {id:20,name:"未开奖"},
                {id:30,name:"已开奖"},
                {id:40,name:"已取消"},
                {id:50,name:"已暂停"}
            ],
            getName:function (code) {
                return cicada.getEnumName(this.list,code);
            }
        },
        /**
         * 交易类型
         */
        TRADE_TYPE:{
            Recharge:0,
            RechargeReward:1,
            TaskReward:2,
            TaskCost:3,
            ItemExchange:4,
            TaskLotteryIncome:5,
            TaskLotteryExpend:6,
            RegisterReward:7,
            LoginReward:8,
            list:[
                {id:0,name:"充值金币",flag:1},
                {id:1,name:"充值送金币",flag:1},
                {id:2,name:"竞猜收入",flag:1},
                {id:3,name:"竞猜下注",flag:-1},
                {id:4,name:"商品兑换",flag:-1},
                {id:5,name:"发布竞猜盈利",flag:1},
                {id:6,name:"发布竞猜赔付",flag:-1},
                {id:7,name:"新用户注册奖励",flag:1},
                {id:8,name:"登录奖励",flag:1}
            ],
            getName:function (code) {
                return cicada.getEnumName(this.list,code);
            },
            getFlag:function (code) {
                var items = cicada.getArrayItem(this.list,"id",code);

                if (items.length === 1) {
                    return items[0].flag;
                } else {
                    return 1;
                }
            }
        }
    };
    /**
     * daterangepicker参数设置
     * @type {{autoApply: boolean, locale: {format: string, separator: string, applyLabel: string, cancelLabel: string, fromLabel: string, toLabel: string, customRangeLabel: string, weekLabel: string, daysOfWeek: *[], monthNames: *[], firstDay: number, isInvalidDate: isInvalidDate}}}
     */
    cicada.DATE_RANGE_PICKER_OPTIONS = {
        "autoApply": true,
        //"autoUpdateInput": false,
        "locale": {
            "format": "YYYY/MM/DD",
            "separator": " - ",
            "applyLabel": "确认",
            "cancelLabel": "取消",
            "fromLabel": "From",
            "toLabel": "To",
            "customRangeLabel": "Custom",
            "weekLabel": "W",
            "daysOfWeek": cicada.CONSTS.DAYS_OF_WEEK,
            "monthNames": cicada.CONSTS.MONTH_NAMES,
            "firstDay": 1,
            "isInvalidDate":function (start, end, label) {
                console.log('New date range selected: ' + start.format('YYYY/MM/DD') + ' to ' + end.format('YYYY/MM/DD') + ' (predefined range: ' + label + ')');
            }
        }
    };

    /**
     * 时间转换（timeStamp转字符串）
     * @param time
     * @returns {string}
     */
    cicada.timeStamp2String = function(time){
        var datetime = new Date();
        datetime.setTime(time);
        var year = datetime.getFullYear();
        var month = datetime.getMonth() + 1;
        var date = datetime.getDate();
        var hour = datetime.getHours();
        var minute = datetime.getMinutes();
        var second = datetime.getSeconds();
        var mseconds = datetime.getMilliseconds();
        return year + "/" + month + "/" + date+" "+hour+":"+minute+":"+second+"."+mseconds;
    };

    /**
     * 时间转换（timeStamp转日期）
     * @param time
     * @returns {number}
     */
    cicada.timeStamp2Date = function (time) {
        var strDate = cicada.timeStamp2String(time);
        return new Date(strDate);
    };

    /**
     * 判断是否为空值
     * @param value
     * @returns {boolean}
     */
    cicada.isNullOrEmpty = function (value) {
        return (value || "") === "";
    };

    /**
     * 从对象数组中删除属性为objPropery，值为objValue元素的对象
     * @param Array arr  数组对象
     * @param String objPropery  对象的属性
     * @param String objPropery  对象的值
     * @return Array 过滤后数组
     */
    cicada.removeArrayItem = function (arr, objPropery, objValue) {
        return $.grep(arr, function (cur, i) {
            return cur[objPropery] != objValue;
        });
    };

    /**
     * 从对象数组中获取属性为objPropery，值为objValue元素的对象
     * @param Array arr  数组对象
     * @param String objPropery  对象的属性
     * @param String objPropery  对象的值
     * @return Array 过滤后的数组
     */
    cicada.getArrayItem = function (arr, objPropery, objValue) {
        return $.grep(arr, function (cur, i) {
            return cur[objPropery] == objValue;
        });
    };

    /**
     * 获取枚举类型描述
     * @param enumList 枚举列表
     * @param code
     * @returns {*}
     */
    cicada.getEnumName = function (enumList,code) {
        var items = cicada.getArrayItem(enumList,"id",code);

        if (items.length === 1) {
            return items[0].name;
        } else {
            return "";
        }
    };

    /**
     * 初始化fileinput控件（第一次初始化）
     * 需要引用类库 bootstrap fileinput
     *
     * @param ctrlName 控件名
     * @param maxFileCount 可上传照片张数
     * @param uploadUrl 图片上传URL
     */
    cicada.initFileInput = function (ctrlName, maxFileCount, uploadUrl) {
        var control = $('#' + ctrlName);

        if(maxFileCount > 1){
            control.fileinput({
                language: 'zh', //设置语言
                uploadUrl: uploadUrl, //上传的地址
                allowedFileExtensions : ['jpg', 'jpeg','png','gif'],//接收的文件后缀,
                maxFileCount: maxFileCount,
                enctype: 'multipart/form-data',
                showUpload: false, //是否显示上传按钮
                showCaption: false,//是否显示标题
                browseClass: "btn btn-primary", //按钮样式
                previewFileIcon: "<i class='glyphicon glyphicon-king'></i>",
                msgFilesTooMany: "选择上传的文件数量({n}) 超过允许的最大数值{m}！",
                // resizeImage:true,
                // maxImageWidth:500,
                // maxImageHeight:500
            });
        }else {
            control.fileinput({
                language: 'zh', //设置语言
                uploadUrl: uploadUrl, //上传的地址
                allowedFileExtensions : ['jpg','jpeg','png','gif'],//接收的文件后缀
                showUpload: false, //是否显示上传按钮
                showCaption: false,//是否显示标题
                browseClass: "btn btn-primary", //按钮样式
                previewFileIcon: "<i class='glyphicon glyphicon-king'></i>",
                // resizeImage:true,
                // maxImageWidth:500,
                // maxImageHeight:500
            });
        }
    };

    /**
     * 将表单数据序列化成JSON格式返回
     * @param formId
     * @returns {{}}
     */
    cicada.serializeJson = function (formId) {
        var serializeObj = {};
        $($("#"+formId).serializeArray()).each(function () {
            serializeObj[this.name] = this.value;
        });
        return serializeObj;
    };

    /**
     * 封装POST请求
     * @param url 请求URL
     * @param formData 表单数据
     * @param fnSuccessCallback 成功时回调
     * @param fnErrorCallback 出错时回调
     * @param contentType 指定ContentType
     */
    cicada.post = function (url,formData,fnSuccessCallback,fnErrorCallback,contentType) {
        $.ajax({
            url: cicada.CONSTS.URL_BASE_API + url,
            type: 'post',
            data: formData,
            processData:false,
            contentType:contentType || false,
            // contentType:contentType || "application/json",
            success: function (response) {
                var resp = {};
                try{
                    resp = JSON.parse(response)
                }catch(error) {
                    resp = response;
                }
                console.log(url);
                console.log(formData);
                console.log(resp);

                if (resp.success) {
                    if(typeof(fnSuccessCallback) === "function")
                        fnSuccessCallback(resp.data);
                    else
                    {
                        layer.msg('保存成功！', {icon: 1});
                    }
                } else {
                    if(typeof(fnErrorCallback) === "function")
                        fnErrorCallback(new Error(resp.message,resp.code));
                    else
                        layer.msg('程序员跑火星去了！'+ err.statusText, {icon: 2});
                }
            },
            error: function (err) {
                console.log(url);
                console.log(formData);
                console.log(err);

                err.message = err.message || err.responseText;
                if(typeof(fnErrorCallback) === "function")
                    fnErrorCallback(err);
                else
                    layer.msg('程序员跑火星去了！'+ err.statusText, {icon: 2});
            }
        });
    };

    /**
     * 封装POST请求
     * @param url 请求URL
     * @param formData 表单数据
     * @param fnSuccessCallback 成功时回调
     * @param fnErrorCallback 出错时回调
     * @param contentType 指定ContentType
     */
    cicada.get = function (url,formData,fnSuccessCallback,fnErrorCallback,contentType) {
        $.ajax({
            url: cicada.CONSTS.URL_BASE_API + url,
            type: 'get',
            data: formData,
            processData:false,
            contentType:contentType || false,
            // contentType:"application/json",
            success: function (response) {
                var resp = {};
                try{
                    resp = JSON.parse(response)
                }catch(error) {
                    resp = response;
                }
                console.log(resp);

                if (resp.code == 0) {
                    if(typeof(fnSuccessCallback) === "function")
                        fnSuccessCallback(resp);
                    else
                    {
                        // TODO something
                        layer.msg('保存成功！', {icon: 1});
                    }
                } else {
                    if(typeof(fnErrorCallback) === "function")
                        fnErrorCallback(new Error(resp.message,resp.code));
                    else
                        layer.msg('程序员跑火星去了！'+ err.statusText, {icon: 2});
                }
            },
            error: function (err) {
                if(typeof(fnErrorCallback) === "function")
                    fnErrorCallback(err);
                else
                    layer.msg('程序员跑火星去了！'+ err.statusText, {icon: 2});
            }
        });
    };

    /**
     * 获取URL参数
     * @param paramName
     * @returns {null}
     */
    cicada.getQueryString = function (paramName) {
        var reg = new RegExp("(^|&)"+ paramName +"=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if(r!=null)return  unescape(r[2]); return null;
    };

    /**
     * 将消息列表转换成HTML
     * @param errmsg
     * @returns {string}
     */
    cicada.getMessageListHtml = function(errmsg){
        var html = "";
        if($.isArray(errmsg)) {
            html += "<ul>";
            for (var i = 0; i < errmsg.length; i++) {
                html += "<li>"+errmsg[i]+"</li>";
            }
            html += "</ul>";
        }else{
            html = errmsg;
        }

        return html;
    };

    /**
     * datatable初始化设置
     * @param url ajax获取数据URL
     * @param queryForm 查询条件表单ID
     * @param columnList 对应上面thead里面的序列
     * @param rowButtonDefs 行操作按钮定义
     * @param fnDrawCallback Table绘制后的回调函数
     */
    cicada.getDatatableSettings = function (url,queryForm,columnList,rowButtonDefs,fnDrawCallback) {
        var settings = {
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
                url: cicada.CONSTS.URL_BASE_API+url,
                dataSrc: "data",
                dataType:'json',
                contentType:"application/json",
                data: function (d) {
                    var param = {};
                    param.draw = d.draw;
                    param.start = d.start;
                    param.length = d.length;
                    $("#"+queryForm).serializeArray().forEach(function (e) {
                        param[e.name] = e.value;
                    });
                    return JSON.stringify(param);//自定义需要传递的参数。
                }
            },
            //数据列
            columns: columnList,
            //操作按钮
            columnDefs: rowButtonDefs,
            language: {
                lengthMenu: "",
                processing: "正在加载数据，请稍候...",
                paginate: {
                    previous: "<",
                    next: ">",
                    first: "<<",
                    last: ">>"
                },
                zeroRecords: "没有找到符合条件的数据！",
                info: "",
                infoEmpty: "",
                infoFiltered: "",
                sSearch: "",
            },
            //在每次table被draw完后回调函数
            fnDrawCallback: fnDrawCallback
        };

        return settings;
    };

    window.cicada = cicada;
}(window,document));

var cicada = window.cicada;
