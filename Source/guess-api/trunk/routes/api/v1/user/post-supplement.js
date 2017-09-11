/**
 * Created by Administrator on 2017/5/4.
 */
var path = require('path');
var mysql = require(path.join(rootDir, './core/db')).mysql;
var Q = require('q');
var moment = require('moment');
var pd = require(path.join(rootDir, './core/preconditions'));

module.exports = function (req, res, next) {
    Q.fcall(function () {
        pd.checkArgument(!!req.body.task_id, '参数task_id必须设置');
        pd.checkArgument(!!req.body.price, '参数price必须设置');
        pd.checkArgument(!!req.body.quantity, '参数quantity必须设置');
        pd.checkArgument(!!req.body.odds_right, '参数odds_right必须设置');
        pd.checkArgument(!!req.body.odds_wrong, '参数odds_wrong必须设置');
    }).then(function () {
        // 更新价格和总注数
        // var values = {
        //     task_id: req.body.task_id,
        //     price: parseFloat(req.body.price),
        //     quantity: parseInt(req.body.quantity)
        // };
        var values = [parseFloat(req.body.price),parseInt(req.body.quantity),parseInt(req.body.task_id)];
        return Q.ninvoke(mysql, 'query', {
            sql: 'UPDATE t_tasks SET sale_price = ?, quantity = ? WHERE task_id = ?',
            values: values
        });
    }).then(function () {
        // 更新赔率
        // var array = [
        //     {
        //         task_id: req.body.task_id,
        //         odds: parseFloat(req.body.odds_right),
        //         is_right: 1
        //     },
        //     {
        //         task_id: req.body.task_id,
        //         odds: parseFloat(req.body.odds_wrong),
        //         is_right: 0
        //     }
        // ];
        var array = [
            [
               parseFloat(req.body.odds_right),
                req.body.task_id,
                1
            ],
            [
                parseFloat(req.body.odds_wrong),
                req.body.task_id,
                 0
            ]
        ];
        var fns = array.map(function (p1, p2, p3) {
            return Q.ninvoke(mysql,'query',{
                sql:'UPDATE t_task_answers SET odds = ? WHERE task_id = ? AND is_right = ?',
                values:p1
            });
        });

        return Q.all(fns);
    }).catch(function (error) {
        res.pkg.success = false;
        res.pkg.message = error.message;
        res.pkg.code = error.code || -1;
        res.pkg.data = null;
    }).done(function () {
        res.jsonp(res.pkg);
    });
};