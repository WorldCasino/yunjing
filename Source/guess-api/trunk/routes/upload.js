/**
 * Created by Administrator on 2017/4/25.
 */
var express = require('express');
var router = express.Router();
var multer = require('multer');
var md5 = require('md5');
var config = require('../config');

var storage = multer.diskStorage({
    //设置上传文件路径
    //Note:如果你传递的是一个函数，你负责创建文件夹，如果你传递的是一个字符串，multer会自动创建
    destination: config.upload.images,
    //TODO:文件区分目录存放
    //获取文件MD5，重命名，添加后缀,文件重复会直接覆盖
    filename: function (req, file, cb) {
        var fileFormat = (file.originalname).split(".");
        cb(null, file.fieldname + '-' + md5(file) + "." + fileFormat[fileFormat.length - 1]);
    }
});
var fileFilter = function (req, file, cb) {

    // 这个函数应该调用 `cb` 用boolean值来
    // 指示是否应接受该文件

    // 拒绝这个文件，使用`false`, 像这样:
    //cb(null, false);

    // 接受这个文件，使用`true`, 像这样:
    cb(null, true)

    // 如果有问题，你可以总是这样发送一个错误:
    //cb(new Error('I don\'t have a clue!'))

};
var upload = multer({
    storage: storage,
    fileFilter: fileFilter
    //其他设置请参考multer的limits
    //limits:{}
});

//文件上传服务
router.post('/images', upload.any(), function (req, res, next) {
    // req.body contains the text fields
    if (req.files.length > 0) {
        var array = req.files.map(function (p1, p2, p3) {
            return {
                field: p1.fieldname,
                name: p1.filename
            }
        });
        res.jsonp({success: true, message: 'upload success', code: 0, data: array});
    } else {
        res.jsonp({success: false, message: 'upload failed', code: -1, data: null});
    }
});

module.exports = router;