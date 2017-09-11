/**
 * 拦截地址，先定义response return package 内容。
 * Created by Administrator on 2017/4/18.
 */
var express = require('express');


// /* error hooker between 1000-2000. */
// module.exports = function (err, req, res, next) {
//     if (err.status >= 1000 && err.status <= 2000) {
//         //res.clear();
//         //res.send('in my error handle');
//
//     } else {
//         next(err);
//     }
// };

/*
 * 在restful api处理路径前，添加空JSON包定义，这样api返回的时候就可以自由填充了。
 */
module.exports = function (req, res, next) {
    // return values
    res.pkg = {};
    res.pkg.success = true;
    res.pkg.code = 0;
    res.pkg.message = 'success';
    res.pkg.data = null;

    next();
};