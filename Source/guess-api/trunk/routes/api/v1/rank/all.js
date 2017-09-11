/**
 * Created by Administrator on 2017/5/15.
 */


var path = require('path');
var mysql = require(path.join(rootDir, './core/db')).mysql;
var Q = require('q');
var moment = require('moment');
var config = require(path.join(rootDir, './config'));
var S = require('string');
/**
 * 总排行榜
 * @param req
 * req.query.limit:返回个数 default = 5
 * req.query.offset:返回起始索引 default = 0
 * @param res
 * @param next
 */
module.exports = function (req, res, next) {
    Q.fcall(function () {
        var limit = parseInt(req.query.limit || 5),
            offset = parseInt(req.query.offset || 0);
        return Q.ninvoke(mysql, 'query', {
            sql: 'SELECT t.user_id,t.profit,m.nickname,m.gender,m.head_url ' +
            'FROM (SELECT user_id,SUM(coins * (case from_type when 2 then 1 when 5 then 1 else -1 end)) AS profit FROM t_user_account_detail '+
            'WHERE from_type IN (2,3,5,6) GROUP BY user_id ) AS t ' +
            'LEFT JOIN m_users AS m ON t.user_id = m.user_id '+
            'ORDER BY t.profit DESC,t.user_id LIMIT ? OFFSET ? ',
            values: [limit,offset]
        }).then(function (result) {
            res.pkg.data = result[0].map(function (p1, p2, p3) {
                p1.head_url = S(p1.head_url || '').startsWith('https://')? p1.head_url  :
                    S(p1.head_url || '').isEmpty() ? "" : config.prefix_img_url_header + (p1.head_url || '');
                //config.prefix_img_url_header + (p1.head_url || '');
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