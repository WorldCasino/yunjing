/**
 * Created by Administrator on 2017/5/3.
 */

var multer = require('multer');
var md5 = require('md5');
var config = require('../config');
var moment = require('moment');

var storageTasks = multer.diskStorage({
    //设置上传文件路径
    //Note:如果你传递的是一个函数，你负责创建文件夹，如果你传递的是一个字符串，multer会自动创建
    //destination: config.upload.tasks,
    destination: config.upload.tasks,
    //TODO:文件区分目录存放
    //获取文件MD5，重命名，添加后缀,文件重复会直接覆盖
    filename: function (req, file, cb) {
        if(!!file){
            var fileFormat = (file.originalname).split(".");
            cb(null, file.fieldname + '-' + md5(file) + "." + fileFormat[fileFormat.length - 1]);
        }
    }
});

var storageHeaders = multer.diskStorage({
    //设置上传文件路径
    //Note:如果你传递的是一个函数，你负责创建文件夹，如果你传递的是一个字符串，multer会自动创建
    //destination: config.upload.tasks,
    destination: config.upload.headers,
    //TODO:文件区分目录存放
    //获取文件MD5，重命名，添加后缀,文件重复会直接覆盖
    filename: function (req, file, cb) {
        if(!!file){
            var fileFormat = (file.originalname).split(".");
            cb(null, md5(file.originalname + moment().format('YYYY-MM-DD HH:mm:ss')) + "." + fileFormat[fileFormat.length - 1]);
        }
    }
});
var fileFilterTask = function (req, file, cb) {

    // 这个函数应该调用 `cb` 用boolean值来
    // 指示是否应接受该文件

    // 拒绝这个文件，使用`false`, 像这样:
    //cb(null, false);

    // 接受这个文件，使用`true`, 像这样:

    if(!!file){
        cb(null, true);
    }else{
        cb(null, false);
    }


    // 如果有问题，你可以总是这样发送一个错误:
    //cb(new Error('I don\'t have a clue!'))

};
var fileFilterHeader = function (req, file, cb) {

    // 这个函数应该调用 `cb` 用boolean值来
    // 指示是否应接受该文件

    // 拒绝这个文件，使用`false`, 像这样:
    //cb(null, false);

    // 接受这个文件，使用`true`, 像这样:
    //cb(null, true)
    if(!!file){
        cb(null, true);
    }else{
        cb(null, false);
    }

    // 如果有问题，你可以总是这样发送一个错误:
    //cb(new Error('I don\'t have a clue!'))

};
var uploadTask = multer({
    storage: storageTasks,
    fileFilter: fileFilterTask
    //其他设置请参考multer的limits
    //limits:{}
});

var uploadHeader = multer({
    storage: storageHeaders,
    fileFilter: fileFilterHeader
    //其他设置请参考multer的limits
    //limits:{}
});

module.exports.tasks = uploadTask;
module.exports.headers = uploadHeader;