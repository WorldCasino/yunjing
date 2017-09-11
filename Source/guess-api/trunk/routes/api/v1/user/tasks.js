/**
 * Created by Administrator on 2017/4/24 0024.
 */
var path = require('path');
var mysql = require(path.join(rootDir, './core/db')).mysql;
var redis = require(path.join(rootDir, './core/db')).redis;
var Q = require('q');
var moment = require('moment');
var config = require(path.join(rootDir, './config'));

/**
 * 查询个人相关任务
 * @param req
 * req.query.limit  : 返回的个数
 * req.query.offset : 返回的起始
 * @param res
 * @param next
 */
module.exports = function (req, res, next) {
    Q.fcall(function () {
        // 构建查询语句
        var limit = parseInt(req.query.limit || 20),
            offset = parseInt(req.query.offset || 0);
        return Q.ninvoke(mysql, 'query', {
            sql: 'SELECT ' +
            't.task_id, ' +
            't.user_id, ' +
            't.task_content, ' +
            't.sale_price, ' +
            't.quantity, ' +
            't.task_status, ' +
            't.create_date, ' +
            't.settle_time, ' +
            'u.user_name, ' +
            'u.nickname, ' +
            'u.gender, ' +
            'u.head_url ' +
            'FROM t_tasks AS t ' +
            'LEFT JOIN m_users AS u ' +
            'ON t.user_id = u.user_id limit ? offset ?',
            values: [limit, offset]
        });
    }).then(function (result) {
        res.pkg.data = result[0].map(function (currentValue) {
            return {
                task_id: currentValue.task_id,
                user_id: currentValue.user_id,
                task_content: currentValue.task_content,
                sale_price: currentValue.sale_price,
                quantity: currentValue.quantity,
                task_status: currentValue.task_status,
                create_date: moment(currentValue.create_date).format('YYYY-MM-DD HH:mm:ss'),
                settle_time: moment(currentValue.settle_time).format('YYYY-MM-DD HH:mm:ss'),
                user: {
                    name: currentValue.user_name,
                    nick: currentValue.nickname,
                    gender: currentValue.gender,
                    head_url: S(currentValue.head_url || '').startsWith('https://') ? currentValue.head_url :
                        S(currentValue.head_url || '').isEmpty() ? "" : config.prefix_img_url_header + (currentValue.head_url || '')
                }
            };
        });
        return res.pkg.data;
    }).then(function (baseJson) {
        // query task pictures
        var taskIds = baseJson.map(function (p1) {
            return p1.task_id
        });
        return Q.all([
            Q.ninvoke(mysql, 'query', {
                // 查询图片
                sql: 'SELECT pic_id, task_id, pic_url, pic_type FROM t_task_pictures WHERE task_id IN ? ORDER BY task_id,pic_type DESC',
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
                'SELECT answer_id, SUM(quantity) AS sum FROM t_task_orders GROUP BY answer_id ) AS ord ' +
                'ON ans.answer_id = ord.answer_id ' +
                'WHERE ans.task_id IN ?',
                values: [[taskIds]]
            })]);
    }).then(function (results) {
        // 处理查询图片结果,task_id分组
        var group_pic = results[0][0].reduce(function (p1, p2) {
            if (!(p2.task_id in p1)) {
                p1[p2.task_id] = [];
            }

            p1[p2.task_id].push({
                pic_id: p2.pic_id,
                pic_url: p2.pic_url
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
        res.pkg.success = false;
        res.pkg.message = error.message;
        res.pkg.code = -1;
        res.pkg.data = null;
    }).done(function () {
        res.jsonp(res.pkg);
    });
};