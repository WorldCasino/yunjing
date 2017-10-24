/**
 * Created by Administrator on 2017/5/13.
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
        return Q.ninvoke(mysql, 'query', {
            sql: 'SELECT item_code, item_name, price_coins, price, brand, specification, model, stock, pic_url  ' +
            'FROM m_items where is_delete = 0 ' +
            'ORDER BY update_date DESC ' +
            'LIMIT ? OFFSET ?',
            values: [limit,offset]
        }).then(function (result) {
            res.pkg.data = result[0].map(function (p1, p2, p3) {
                p1.pic_url = config.prefix_img_url_mall + (p1.pic_url || '');
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