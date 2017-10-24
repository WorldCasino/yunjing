/**
 * Created by Administrator on 2017/5/13.
 */
var path = require('path');
var mysql = require(path.join(rootDir, './core/db')).mysql;
var Q = require('q');
var moment = require('moment');
var pd = require(path.join(rootDir, './core/preconditions'));
var redis = require(path.join(rootDir, './core/db')).redis;
var config = require(path.join(rootDir, './config'));
var S = require('string');

module.exports = function (req, res, next) {
    return Q.fcall(function () {
        // 处理任务基本信息查询
        var id = pd.checkNotNull(req.query.id, '竞猜项目ID不能为空', 1001);
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
            'WHERE t.task_id = ? AND t.is_delete = 0',
            values: [id]
        }).then(function (result) {
            pd.checkState(result[0].length === 1,'竞猜项目不存在');
            var v = result[0][0];
            res.pkg.data = {
                task_id: v.task_id,
                task_type: v.task_type,
                user_id: v.user_id,
                task_content: v.task_content,
                sale_price: parseInt(v.sale_price),
                quantity: v.quantity,
                task_status: v.task_status,
                hot: !!parseInt(v.hot),
                create_date: moment(v.create_date).format('YYYY-MM-DD HH:mm:ss'),
                settle_time: moment(v.settle_time).format('YYYY-MM-DD HH:mm:ss'),
                update_date: moment(v.update_date).format('YYYY-MM-DD HH:mm:ss'),
                user: {
                    name: v.user_name,
                    nick: v.nickname,
                    gender: v.gender,
                    //head_url: config.prefix_img_url_header + (v.head_url || '')
                    head_url: S(v.head_url || '').startsWith('https://')? v.head_url  :
                        S(v.head_url || '').isEmpty() ? "" : config.prefix_img_url_header + (v.head_url || '')
                }
            };
            return id;
        });
    }).then(function (id) {
        // 处理普通任务或主球的图片与比赛队伍显示
        if(res.pkg.data.task_type === 0 || res.pkg.data.task_type === 3){
            // 查询图片-普通任务
            return Q.ninvoke(mysql, 'query', {
                // 查询图片
                sql: 'SELECT pic_id, task_id, pic_url, pic_type FROM t_task_pictures WHERE task_id = ? ORDER BY task_id,pic_type DESC',
                values: [id]
            }).then(function (result) {
                res.pkg.data.pics = result[0].map(function (p1, p2, p3) {
                    return {
                        pic_id: p1.pic_id,
                        pic_url: config.prefix_img_url_task + p1.pic_url
                    };
                });
                return id;
            });
        }else{
            // 查询足球
            return Q.ninvoke(mysql, 'query', {
                // 查询足球队伍
                sql: 'SELECT tfb_id, task_id, team_name, court_type FROM t_task_football WHERE task_id = ?',
                values: [id]
            }).then(function (result) {
                res.pkg.data.teams = result[0].map(function (p1, p2, p3) {
                    return {
                        tfb_id: p1.tfb_id,
                        team_name: p1.team_name,
                        court_type: p1.court_type
                    };
                });
                return id;
            });
        }
        //return res.pkg.data.task_type === 0 ? picQuery : footballQuery;
    }).then(function (taskId) {
        // 处理结果答案
        // TODO: 竞猜已公布答案后可以显示正确答案
        //var isOver = (parseInt(res.pkg.data.task_status) === 30); // 30表示已开奖
        return Q.ninvoke(mysql, 'query', {
            // 查询答案相关内容
            sql: 'SELECT ' +
            'ans.answer_id, ' +
            'ans.task_id, ' +
            'ans.answer, ' +
            'ans.odds, ' +
            'ans.is_right, ' +
            'ord.sum ' +
            'FROM t_task_answers AS ans ' +
            'LEFT JOIN ( ' +
            'SELECT answer_id, SUM(quantity) AS sum FROM t_task_orders GROUP BY answer_id ) AS ord ' +
            'ON ans.answer_id = ord.answer_id ' +
            'WHERE ans.task_id = ?',
            values: [taskId]
        }).then(function (result) {
            res.pkg.data.answer = result[0].map(function (p1, p2, p3) {
                var item = {
                    answer_id: p1.answer_id,
                    answer: p1.answer,
                    odds: p1.odds,
                    sum: p1.sum || 0
                };
                if(parseInt(res.pkg.data.task_status) === 30 || res.pkg.data.user_id === req.headers.user_id){
                    item.is_right = !!p1.is_right;
                }
                return item;
            });
            return taskId
        });
    }).then(function (taskId) {
        // 参与者
        return Q.ninvoke(mysql,'query',{
            sql:'SELECT ord.user_id, ord.answer_id, ord.quantity, ord.create_date, ord.update_date, usr.nickname, usr.gender, usr.head_url ' +
            'FROM t_task_orders AS ord ' +
            'LEFT JOIN m_users AS usr ' +
            'ON ord.user_id = usr.user_id ' +
            'WHERE ord.task_id = ?',
            values:[taskId]
        }).then(function (result) {
            res.pkg.data.gamblers = result[0].map(function (currentValue) {
                currentValue.create_date = moment(currentValue.create_date).format('YYYY-MM-DD HH:mm:ss');
                currentValue.update_date = moment(currentValue.update_date).format('YYYY-MM-DD HH:mm:ss');
                //currentValue.head_url = config.prefix_img_url_header + (currentValue.head_url || '');
                currentValue.head_url = S(currentValue.head_url || '').startsWith('https://')? currentValue.head_url  :
                    S(currentValue.head_url || '').isEmpty() ? "" : config.prefix_img_url_header + (currentValue.head_url || '');
                return currentValue;
            });
            return taskId;
        });
    }).then(function (taskId) {
        // 单独处理消息个数
        return Q.ninvoke(redis, "select", config.redis_index_of_message_count)
            .then(function () {
                // 根据task_id获取全部的消息个数
                return Q.ninvoke(redis, 'get', 'room_message_count_' + taskId);
            }).catch(function () {
                // redis出错，不影响返回结果，所有消息个数为0
                return 0;
            }).then(function (messages) {
                // 消息个数
                res.pkg.data.message_count = parseInt(messages || 0);
            });
    }).catch(function (error) {
        console.log("task/detail/"+req.query.id);
        console.log(error);
        res.pkg.success = false;
        res.pkg.code = error.code || -1;
        res.pkg.message = error.message;
        res.pkg.data = null;
    }).done(function () {
        console.log("task/detail/"+req.query.id);
        console.log(res.pkg);
        res.jsonp(res.pkg);
    });
};