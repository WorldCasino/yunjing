/**
 * Created by Administrator on 2017/5/18.
 */

var path = require('path');
var mysql = require(path.join(rootDir, './core/db')).mysql;
var Q = require('q');
var moment = require('moment');
var S = require('string');
var config = require(path.join(rootDir, './config'));

module.exports = function (req, res, next) {
    Q.fcall(function () {
        var sets = [], values = [];
        if (!S(req.body.password).isEmpty()) {
            sets.push('password = ?');
            values.push(req.body.password);
        }
        if (!S(req.body.nickname).isEmpty()) {
            sets.push('nickname = ?');
            values.push(req.body.nickname);
        }
        if (!S(req.body.gender).isEmpty()) {
            sets.push('gender = ?');
            values.push(parseInt(req.body.gender));
        }
        if (!S(req.body.phonenumber).isEmpty()) {
            sets.push('phonenumber = ?');
            values.push(req.body.phonenumber);
        }
        if (!S(req.body.email).isEmpty()) {
            sets.push('email = ?');
            values.push(req.body.email);
        }
        if (!S(req.body.wxid).isEmpty()) {
            sets.push('wxid = ?');
            values.push(req.body.wxid);
        }
        if (!S(req.body.qq).isEmpty()) {
            sets.push('qq = ?');
            values.push(req.body.qq);
        }
        // 图片上传后存储数组
        if (req.files.length === 1) {
            sets.push('head_url = ?');
            values.push(req.files[0].filename);
        }

        // 添加user_id
        values.push(req.headers.user_id);

        return Q.ninvoke(mysql, 'query', {
            sql: 'UPDATE m_users SET ' + sets.join(', ') + ' WHERE user_id = ?',
            values: values
        });
    }).then(function () {
        return Q.ninvoke(mysql, 'query', {
            sql: 'SELECT * FROM m_users WHERE user_id = ?',
            values: [req.headers.user_id]
        }).then(function (result) {
            var row = result[0][0];
            res.pkg.data = {
                user_id:row.user_id,
                nickname:row.nickname,
                gender:row.gender,
                phonenumber:row.phonenumber,
                email:row.email,
                wxid:row.wxid,
                qq:row.qq,
                head_url:config.domain + 'headers/' + row.head_url,
            }
            return res.pkg.data;
        });

    }).catch(function (error) {
        res.pkg.success = false;
        res.pkg.message = error.message;
        res.pkg.code = error.code || -1;
        res.pkg.data = null;
    }).done(function () {
        res.jsonp(res.pkg);
    });
};