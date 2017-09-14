/**
 * Created by Administrator on 2017/5/14.
 */

var path = require('path');
var mysql = require(path.join(rootDir, './core/db')).mysql;
var Q = require('q');
var moment = require('moment');
var pd = require(path.join(rootDir, './core/preconditions'));
var S = require('string');

/**
 * 兑换订单付款
 * @param req
 * req.order_id:订单id
 * req.order_code:订单号
 * req.qty:所付金币
 * @param res
 * @param next
 */
module.exports = function (req, res, next) {
    // TODO: 更新数据库没有添加锁，后面最好添加上 LOCK TABLE *************IMPORTANT*************
    var user_id = parseInt(req.headers.user_id);
    Q.fcall(function () {
        pd.checkArgument(!!req.body.order_id, '参数order_id必须设置');
        pd.checkArgument(!!req.body.order_code, '参数order_code必须设置');
        pd.checkArgument(!!req.body.cost, '参数cost必须设置');
        // // 检查订单号中用户是否正确 什么鬼，要校验也应该去表里校验啊！！！
        // pd.checkArgument(S(req.body.order_code).right(16).startsWith(S(req.headers.user_id).padLeft(6, '0')), '订单号和用户不匹配');
    }).then(function () {
        var coins_amount = parseInt(req.body.cost);
        var order_id = parseInt(req.body.order_id);
        var order_code = req.body.order_code;
        // 判断订单是否正确
        return Q.ninvoke(mysql, 'query', {
            sql: 'SELECT COUNT(*) AS cnt FROM t_orders WHERE user_id = ? AND order_id = ? AND order_code = ? AND coins_amount = ?',
            values: [user_id, order_id, order_code, coins_amount]
        }).then(function (result) {
            var rows = result[0];
            pd.checkState(rows[0].cnt === 1, '兑换内容与订单信息不匹配');
        });
    }).then(function () {
        var coins_amount = parseInt(req.body.cost);
        var order_id = parseInt(req.body.order_id);
        var order_code = req.body.order_code;
        // 检查订单状态-是否已经支付，避免重复支付
        return Q.ninvoke(mysql, 'query', {
            sql: 'SELECT order_status FROM t_orders WHERE user_id = ? AND order_id = ? AND order_code = ? AND coins_amount = ?',
            values: [user_id, order_id, order_code, coins_amount]
        }).then(function (result) {
            var rows = result[0];
            pd.checkState(parseInt(rows[0].order_status) === 10, '订单已支付');
        });
    }).then(function () {
        // 判读金币是否充足
        return Q.ninvoke(mysql, 'query', {
            sql: 'SELECT coin_balance FROM t_user_account WHERE user_id = ?',
            values: [user_id]
        }).then(function (result) {
            var rows = result[0];
            pd.checkState(rows.length === 1, '金币不足,不能兑换！',1001);
            pd.checkState(rows[0].coin_balance > parseFloat(req.body.cost), '金币不足,不能兑换！',1001);
        });
    }).then(function () {
        // 添加记录到t_user_account_detail(流水表)
        //var cost = -parseInt(req.body.cost);
        var coins_amount = parseInt(req.body.cost);
        var order_id = parseInt(req.body.order_id);
        var kvp = {
            account_id: user_id,
            user_id: user_id,
            coins: coins_amount,
            from_type: 4,
            order_id: order_id,
            create_by: user_id,
            update_by: user_id
        };

        return Q.ninvoke(mysql, 'query', {
            sql: 'INSERT INTO t_user_account_detail SET ?',
            values: kvp
        }).then(function (result) {
            var rows = result[0];
            // TODO: 如果t_user_account 通过trigger方式就可以不用管更新
            // insertId，更新总数出错后可以回滚
            return rows.insertId;
        });
    }).then(function (insertId) {
        // 更新统计、订单状态表
        var coins_amount = parseInt(req.body.cost);
        var order_id = parseInt(req.body.order_id);
        var order_code = req.body.order_code;

        return Q.fcall(function () {
            // 更新统计表
            return Q.ninvoke(mysql, 'query', {
                sql: 'UPDATE t_user_account SET coin_balance = coin_balance - ? WHERE user_id = ?',
                values: [coins_amount, user_id]
            }).catch(function (error) {
                // 回滚删除流水表
                return Q.ninvoke(mysql, 'query', {
                    sql: 'DELETE FROM t_user_account_detail WHERE uad_id = ?',
                    values: [insertId]
                }).then(function () {
                    throw error;
                });
            });
        }).then(function () {
            // 更新商品兑换表
            // 第二步已经验证了信息，此处直接执行就可以了
            return Q.ninvoke(mysql, 'query', { // 更新统计表
                sql: 'UPDATE t_orders SET order_status = 20 WHERE user_id = ? AND order_id = ? AND order_code = ? AND coins_amount = ?',
                values: [user_id, order_id, order_code, coins_amount]
            }).then(function () {
                res.pkg.data = {
                    order_id: req.body.order_id,
                    order_code: req.body.order_code,
                    cost: req.body.cost
                };
                return res.pkg.data;
            }).catch(function (error) {
                // 回滚流水表
                return Q.ninvoke(mysql, 'query', {
                    sql: 'DELETE FROM t_user_account_detail WHERE uad_id = ?',
                    values: [insertId]
                }).then(function () {
                    // 回滚统计表
                    return Q.ninvoke(mysql, 'query', { // 更新统计表
                        sql: 'UPDATE t_user_account SET coin_balance = coin_balance + ? WHERE user_id = ?',
                        values: [coins_amount, user_id]
                    });
                }).then(function () {
                    throw error;
                });
            });
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