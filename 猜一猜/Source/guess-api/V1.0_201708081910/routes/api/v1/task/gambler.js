/**
 * Created by Administrator on 2017/4/24 0024.
 */
var path = require('path');
var mysql = require(path.join(rootDir, './core/db')).mysql;
var Q = require('q');
var moment = require('moment');
var config = require(path.join(rootDir, './config'));
var S = require('string');
/**
 * 每个人物投注人信息查询
 * @param req
 * req.query.task :下注的项目编号即t_tasks表的task_id
 * @param res
 * @param next
 */
module.exports = function (req,res,next) {

    Q.fcall(function () {
        var id = req.query.id;
        if(!id){
            var error = new Error('查询项目id不能为空');
            error.code = 1001;
            throw error;
        }

        // return Q.ninvoke(mysql,'query',{
        //     sql:'SELECT ord.user_id, ord.answer_id, ord.quantity, ord.create_date, ord.update_date, usr.nickname, usr.gender, usr.head_url ' +
        //     'FROM t_task_orders AS ord ' +
        //     'LEFT JOIN m_users AS usr ' +
        //     'ON ord.user_id = usr.user_id ' +
        //     'WHERE ord.task_id = ?',
        //     values:[id]
        // });
        // return Q.ninvoke(mysql,'query',{
        //     sql:'SELECT ord.user_id, ord.quantity, ord.answer_id, ord.create_date, ord.update_date, usr.nickname, usr.gender, usr.head_url ' +
        //     'FROM ' +
        //     '( SELECT user_id, answer_id, task_id, SUM(quantity) AS quantity, MAX(create_date) AS create_date, MAX(update_date) AS update_date ' +
        //     'FROM t_task_orders WHERE task_id = ? GROUP BY user_id,answer_id  ' +
        //     ') AS ord ' +
        //     'LEFT JOIN m_users AS usr ON ord.user_id = usr.user_id',
        //     values:[id]
        // });
        return Q.ninvoke(mysql,'query',{
            sql:'SELECT ord.user_id, ord.quantity, ord.create_date, ord.update_date, usr.nickname, usr.gender, usr.head_url ' +
            'FROM ' +
            '( SELECT user_id, task_id, SUM(quantity) AS quantity, MAX(create_date) AS create_date, MAX(update_date) AS update_date ' +
            'FROM t_task_orders WHERE task_id = ? GROUP BY user_id  ' +
            ') AS ord ' +
            'LEFT JOIN m_users AS usr ON ord.user_id = usr.user_id',
            values:[id]
        });
    }).then(function (result) {
        res.pkg.data = result[0].map(function (currentValue) {
            currentValue.create_date = moment(currentValue.create_date).format('YYYY-MM-DD HH:mm:ss');
            currentValue.update_date = moment(currentValue.update_date).format('YYYY-MM-DD HH:mm:ss');
            //currentValue.head_url = config.prefix_img_url_header + (currentValue.head_url || '');
            currentValue.head_url = S(currentValue.head_url || '').startsWith('https://')? currentValue.head_url  :
                S(currentValue.head_url || '').isEmpty() ? "" : config.prefix_img_url_header + (currentValue.head_url || '');
            return currentValue;
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