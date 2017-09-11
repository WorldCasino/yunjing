/**
 * Created by Administrator on 2017/4/23.
 */

var express = require('express');
var router = express.Router();
var token = require('../core/token');

/**
 * 获取token
 */
router.get('/', function (req, res, next) {
    token.generate(req.query.user, req.query.pwd).then(function (token) {
        //delete res.pkg.data;
        res.pkg.data = {token: token};
        res.jsonp(res.pkg);
    }).catch(function (err) {
        console.log('get token error');
        //delete res.pkg.data;
        res.pkg.success = false;
        res.pkg.message = err.message;
        res.pkg.code = -1;
        res.pkg.data = {token: null};
        console.log(res.pkg);
        res.jsonp(res.pkg);
    });
});

/**
 * 验证token是否合法
 */
router.get('/validate', function (req, res, next) {
    console.log(req.query);
    token.validate(req.query.token).then(function (validation) {
        res.pkg.data = validation;
        res.pkg.message = validation ? 'success' : 'failed';
        res.jsonp(res.pkg);
    }).catch(function (err) {
        console.log('validate token error')
        res.pkg.success = false;
        res.pkg.message = err.message;
        res.pkg.code = 1000;
        res.pkg.data = null;
        console.log(res.pkg);
        res.jsonp(res.pkg);
    });
});

module.exports = router;