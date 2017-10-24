/**
 * Created by Administrator on 2017/5/14.
 */
var path = require('path');
var mysql = require(path.join(rootDir, './core/db')).mysql;
var Q = require('q');
var moment = require('moment');
var config = require(path.join(rootDir, './config'));

/**
 * 商城商品列表
 * @param req
 * req.query.limit:返回个数 default = 10
 * req.query.offset:返回起始索引 default = 0
 * @param res
 * @param next
 */
module.exports = function (req, res, next) {
    Q.fcall(function () {
        var limit = parseInt(req.query.limit || 10),
            offset = parseInt(req.query.offset || 0);
        var user_id = parseInt(req.headers.user_id);
        return Q.ninvoke(mysql, 'query', {
            sql: 'SELECT * ' +
            'FROM t_orders ' +
                'WHERE user_id =? '+
            'ORDER BY create_date DESC ' +
            'LIMIT ? OFFSET ?',
            values: [user_id,limit,offset]
        }).then(function (result) {
            res.pkg.data = result[0].map(function (p1, p2, p3) {
                p1.create_date = moment(p1.create_date).format('YYYY-MM-DD HH:mm:ss');
                p1.update_date = moment(p1.update_date).format('YYYY-MM-DD HH:mm:ss');
                return p1;
            });
            return res.pkg.data;
        });
    }).catch(function (error) {
        res.pkg.success = false;
        res.pkg.code = error.code || -1;
        res.pkg.message = error.message;
        res.pkg.data = null;
    }).done(function () {
        res.jsonp(res.pkg);
    });
};