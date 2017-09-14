/**
 * Created by Administrator on 2017/4/24 0024.
 */


var path = require('path');
var mysql = require(path.join(rootDir, './core/db')).mysql;
var Q = require('q');
var moment = require('moment');
var config = require(path.join(rootDir, './config'));
var S  = require('string');
var redis = require(path.join(rootDir, './core/db')).redis;
/**
 * 查询我发布内容与和我相关的发布
 * @param req
 * req.query.limit  : 返回的个数
 * req.query.offset : 返回的起始
 * req.headers.user_id : 用户id
 * @param res
 * @param next
 */
module.exports = function (req, res, next) {
    Q.fcall(function () {
        // 第一步查询订单中我参与的竞猜
        var user_id = req.headers.user_id;
        return Q.ninvoke(mysql, 'query', {
            sql: 'SELECT task_id,answer_id,quantity FROM t_task_orders WHERE user_id = ?',
            values: [user_id]
        }).then(function (results) {
            // 将数据存储到临时变量中，后面还需要加入到返回结果，避免再查询一次数据库
            res.locals.orders = results[0];
            // 作为下一步查询输入参数
            return results[0].map(function (currentValue) {
                return currentValue.task_id;
            });
        });
    }).then(function (arrayOfOrders) {
        // 如果数据为空，说明没有查询到数据，后面再进行处理就会报错，所以直接抛出错误到错误处理处，错误处理处对错误进行忽略即可。
        if(arrayOfOrders.length === 0){
            var err = new Error();
            err.code = 100;
            throw  err;
        }
        // 第二步，查询包含竞猜和发布的内容
        // 构建查询语句
        var limit = parseInt(req.query.limit || 20),
            offset = parseInt(req.query.offset || 0),
            user_id = req.headers.user_id;

        return Q.ninvoke(mysql, 'query', {
            sql: 'SELECT ' +
            't.task_id, ' +
            't.task_type, ' +
            't.user_id, ' +
            't.task_content, ' +
            't.sale_price, ' +
            't.quantity, ' +
            't.task_status, ' +
            't.create_date, ' +
            't.settle_time, ' +
            't.update_date, ' +
            't.hot, ' +
            'u.user_name, ' +
            'u.nickname, ' +
            'u.gender, ' +
            'u.head_url ' +
            'FROM t_tasks AS t ' +
            'LEFT JOIN m_users AS u ' +
            'ON t.user_id = u.user_id ' +
            'WHERE t.user_id = ? OR t.task_id IN ? ' +
            'ORDER BY t.is_delete = 0 and t.create_date DESC '+
            'limit ? offset ? ',
            values: [user_id, [arrayOfOrders], limit, offset]
        }).then(function (result) {
            res.pkg.data = result[0].map(function (currentValue) {
                return {
                    task_id: currentValue.task_id,
                    task_type: currentValue.task_type,
                    user_id: currentValue.user_id,
                    task_content: currentValue.task_content,
                    sale_price: currentValue.sale_price,
                    quantity: currentValue.quantity,
                    task_status: currentValue.task_status,
                    hot: !!parseInt(currentValue.hot),
                    create_date: moment(currentValue.create_date).format('YYYY-MM-DD HH:mm:ss'),
                    settle_time: moment(currentValue.settle_time).format('YYYY-MM-DD HH:mm:ss'),
                    update_date: moment(currentValue.update_date).format('YYYY-MM-DD HH:mm:ss'),
                    user: {
                        name: currentValue.user_name,
                        nick: currentValue.nickname,
                        gender: currentValue.gender,
                        //head_url: config.prefix_img_url_header + (currentValue.head_url || '')
                        head_url: S(currentValue.head_url || '').startsWith('https://')? currentValue.head_url  :
                            S(currentValue.head_url || '').isEmpty() ? "" : config.prefix_img_url_header + (currentValue.head_url || '')
                    }
                };
            });
            return res.pkg.data;
        });
    }).then(function (baseJson) {

        // 如果数据为空，说明没有查询到数据，后面再进行处理就会报错，所以直接抛出错误到错误处理处，错误处理处对错误进行忽略即可。
        if(baseJson.length === 0){
            var err = new Error();
            err.code = 100;
            throw  err;
        }
        // 查询图片

        // 获取任务id数组
        var taskIds = baseJson.map(function (p1) {
            return p1.task_id
        });
        return Q.all([Q.ninvoke(mysql, 'query', {
            // 查询图片
            sql: 'SELECT pic_id, task_id, pic_url, pic_type FROM t_task_pictures WHERE task_id IN ?',
            values: [[taskIds]]
        }), Q.ninvoke(mysql, 'query', {
            // 查询答案相关内容
            sql: 'SELECT ' +
            'ans.answer_id, ' +
            'ans.task_id, ' +
            'ans.answer, ' +
            'ans.odds, ' +
            'ord.sum ' +
            'FROM t_task_answers AS ans ' +
            'LEFT JOIN ( ' +
            'SELECT user_id,answer_id, SUM(quantity) AS sum FROM t_task_orders GROUP BY user_id,answer_id ) AS ord ' +
            'ON ans.answer_id = ord.answer_id and ord.user_id = ? ' +
            'WHERE ans.task_id IN ?',
            values: [req.headers.user_id,[taskIds]]
        })]).then(function (results) {
            // 处理查询图片结果,task_id分组
            var group_pic = results[0][0].reduce(function (p1, p2) {
                if (!(p2.task_id in p1)) {
                    p1[p2.task_id] = [];
                }
                p1[p2.task_id].push({
                    pic_id: p2.pic_id,
                    pic_url: config.prefix_img_url_task + p2.pic_url
                });
                return p1;
            }, {});
            // 处理查询答案相关内容结果,task_id分组
            var group_answer = results[1][0].reduce(function (p1, p2) {
                if (!(p2.task_id in p1)) {
                    p1[p2.task_id] = [];
                }
                p1[p2.task_id].push({
                    answer_id: p2.answer_id,
                    answer: p2.answer,
                    odds: p2.odds,
                    sum: p2.sum || 0
                });
                return p1;
            }, {});
            // 将图片和答案相关内容写入到返回值中
            res.pkg.data = res.pkg.data.map(function (p1) {
                p1.pics = group_pic[p1.task_id];
                p1.answer = group_answer[p1.task_id];
                return p1;
            });
            return res.pkg.data;
        });
    }).then(function () {
        // 处理第一步查询处理的订单数据,不放到上一步骤，这样不需要代码时候可以直接删除
        // 合并同一任务分多次购买
        var group = res.locals.orders.reduce(function (acc, curVal) {
            if(!acc[curVal.answer_id]){
                acc[curVal.answer_id] = curVal.quantity;
            }else {
                acc[curVal.answer_id] = acc[curVal.answer_id] + curVal.quantity;
            }
            return acc;
        },{});
        // 合并到answer中
        res.pkg.data = res.pkg.data.map(function (curVal) {
            curVal.answer = curVal.answer.map(function (p1) {
                p1.my_quantity = group[p1.answer_id] || 0;
                return p1;
            });
            return curVal;
        });
    }).then(function () {
        // 单独处理消息个数
        return Q.ninvoke(redis, "select", config.redis_index_of_message_count)
            .then(function () {
                // 根据task_id获取全部的消息个数
                var fns = res.pkg.data.map(function (cv) {
                    return Q.ninvoke(redis, 'get', 'room_message_count_' + cv.task_id);
                });
                return Q.all(fns);
            }).catch(function () {
                // redis出错，不影响返回结果，所有消息个数为0
                return res.pkg.data.map(function () {
                    return 0;
                });
            });
    }).then(function (messages) {
        // 消息个数
        res.pkg.data = res.pkg.data.map(function (currentValue, currentIndex) {
            currentValue.message_count = parseInt(messages[currentIndex] || 0);
            return currentValue;
        });
    }).catch(function (error) {
        // res.pkg.success = false;
        // res.pkg.message = error.message;
        // res.pkg.code = -1;
        // res.pkg.data = null;
        // code === 100 表示无数据
        if(error.code !== 100){
            res.pkg.success = false;
            res.pkg.message = error.message;
            res.pkg.code = -1;
            res.pkg.data = null;
        }else{
            res.pkg.data = res.pkg.data || [];
        }
    }).done(function () {
        res.jsonp(res.pkg);
    });
};