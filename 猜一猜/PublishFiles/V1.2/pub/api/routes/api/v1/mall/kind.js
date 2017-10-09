/**
 * Created by Administrator on 2017/5/13.
 */
var path = require('path');
var mysql = require(path.join(rootDir, './core/db')).mysql;
var redis = require(path.join(rootDir, './core/db')).redis;
var Q = require('q');
var moment = require('moment');
var config = require(path.join(rootDir, './config'));
var pd = require(path.join(rootDir, './core/preconditions'));

/**
 * 查询某个商品的详情。
 * @param req
 * req.query.limit:返回个数 default = 10
 * req.query.offset:返回起始索引 default = 0
 * @param res
 * @param next
 */
module.exports = function (req, res, next) {
    Q.fcall(function () {
        var id = pd.checkNotNull(req.query.id, '商品ID不能为空');
        return Q.ninvoke(mysql, 'query', {
            sql: 'SELECT item_code, item_name, price_coins, price, brand, specification, model, stock, pic_url  ' +
            'FROM m_items ' +
            'WHERE item_code = ? ',
            values: [id]
        }).then(function (result) {
            pd.checkState(result[0].length === 1 ,'查询商品部存在');
            res.pkg.data = result[0][0];
            res.pkg.data.pic_url = config.prefix_img_url_mall + (res.pkg.data.pic_url || '');
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