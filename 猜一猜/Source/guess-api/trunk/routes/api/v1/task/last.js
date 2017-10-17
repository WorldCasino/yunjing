/**
 * Created by Administrator on 2017/4/23.
 */
var path = require('path');
var mysql = require(path.join(rootDir, './core/db')).mysql;
var redis = require(path.join(rootDir, './core/db')).redis;
var Q = require('q');
var moment = require('moment');
var config = require(path.join(rootDir, './config'));
var S = require('string');
/**
 * 查询最新的发布任务
 * @param req
 * req.query.limit  : 返回的个数
 * req.query.offset : 返回的起始
 * @param res
 * @param next
 */
var latest = function (req, res, next) {
    Q.fcall(function () {
        // 构建查询语句
        var task_type = parseInt(req.query.task_type),
            limit = parseInt(req.query.limit || 20),
            offset = parseInt(req.query.offset || 0);
        if(task_type==1 || task_type==2){
            return Q.ninvoke(mysql, 'query', {
                sql: 'SELECT ' +
                't.task_id, ' +
                't.task_type, ' +
                't.match_id, ' +
                't.match_type, ' +
                't.play_type, ' +
                't.concede_points_show, ' +
                'm.title, ' +
                'm.home_score, ' +
                'm.away_score, ' +
                'm.open_time, ' +
                't.user_id, ' +
                't.task_content, ' +
                't.sale_price, ' +
                't.quantity, ' +
                't.task_status, ' +
                't.create_date, ' +
                't.settle_time, ' +
                't.update_date, ' +
                't.hot, ' +
                't.personal, ' +
                't.like_peas, ' +
                't.lottery_type, ' +
                't.lock_time, ' +
                't.parent_id, ' +
                't.is_recommend, ' +
                'u.user_name, ' +
                'u.user_type, ' +
                'u.nickname, ' +
                'u.gender, ' +
                'u.head_url, ' +
                'p.user_id as parent_user_id, ' +
                'p.user_type as parent_type, ' +
                'p.nickname as parent_nickname ' +
                'FROM t_tasks AS t ' +
                'LEFT JOIN m_users AS u ON t.user_id = u.user_id ' +
                'LEFT JOIN m_users AS p on t.parent_id = p.user_id ' +
                'LEFT JOIN t_matches AS m on t.match_id = m.match_id ' +
                'WHERE t.is_delete = 0 and t.task_status = 20 ' +
                'AND t.task_type = ? ' +
                'AND (SYSDATE()<t.lock_time OR t.lock_time IS NULL) ' +
                'AND t.quantity>(SELECT count(1) FROM t_task_orders AS o WHERE o.task_id=t.task_id) ' +
                'ORDER BY m.open_time ASC,t.hot DESC,t.create_date DESC limit ? offset ? ',
                values: [task_type,limit, offset]
            });
        }else{
            return Q.ninvoke(mysql, 'query', {
                sql: 'SELECT ' +
                't.task_id, ' +
                't.task_type, ' +
                't.match_id, ' +
                't.match_type, ' +
                't.play_type, ' +
                't.concede_points_show, ' +
                't.user_id, ' +
                't.task_content, ' +
                't.sale_price, ' +
                't.quantity, ' +
                't.task_status, ' +
                't.create_date, ' +
                't.settle_time, ' +
                't.update_date, ' +
                't.hot, ' +
                't.personal, ' +
                't.like_peas, ' +
                't.lottery_type, ' +
                't.lock_time, ' +
                't.parent_id, ' +
                't.is_recommend, ' +
                'u.user_name, ' +
                'u.user_type, ' +
                'u.nickname, ' +
                'u.gender, ' +
                'u.head_url, ' +
                'p.user_id as parent_user_id, ' +
                'p.user_type as parent_type, ' +
                'p.nickname as parent_nickname, ' +
                'm.open_time ' +
                'FROM t_tasks AS t ' +
                'LEFT JOIN m_users AS u ON t.user_id = u.user_id ' +
                'LEFT JOIN m_users AS p on t.parent_id = p.user_id ' +
                'LEFT JOIN t_matches AS m on t.match_id = m.match_id ' +
                'WHERE t.is_delete = 0 and t.task_status = 20 ' +
                'AND (t.task_type in (0,3) or t.is_recommend=1) ' +
                'AND (SYSDATE()<t.lock_time OR t.lock_time IS NULL) ' +
                'AND t.quantity>(SELECT count(1) FROM t_task_orders AS o WHERE o.task_id=t.task_id) ' +
                'ORDER BY t.is_recommend DESC,t.hot DESC,t.create_date DESC limit ? offset ? ',
                values: [limit, offset]
            });
        }

    }).then(function (result) {
        //私人发布的不显示
        for(var i = 0; i < result[0].length; i++){
            if(result[0][i].personal === 1){
                result[0].splice(i,1);
                i--;
            }
        }
        res.pkg.data = result[0].map(function (currentValue) {
            var lockTime = currentValue.lock_time;
            if (lockTime != null){
                lockTime = moment(new Date(lockTime)).format('YYYY-MM-DD HH:mm:ss');
            }
            return {
                task_id: currentValue.task_id,
                task_type: currentValue.task_type,
                match_id: currentValue.match_id,
                match_type: currentValue.match_type,
                play_type: currentValue.play_type,
                concede_points_show: currentValue.concede_points_show,
                score: currentValue.home_score+'-'+currentValue.away_score,
                // home_score: currentValue.home_score,
                // visit_score: currentValue.away_score,
                title: currentValue.title,
                user_id: currentValue.user_id,
                task_content: currentValue.task_content,
                sale_price: parseInt(currentValue.sale_price),
                quantity: currentValue.quantity,
                task_status: currentValue.task_status,
                is_recommend: currentValue.is_recommend,
                hot: !!parseInt(currentValue.hot),
                personal: currentValue.personal, //...  0:平台发布  1:私人发布
                like_peas: currentValue.like_peas, //...  0:不接受金豆  1：接受金豆
                lottery_type: currentValue.lottery_type,
                lock_time: lockTime,
                create_date: moment(currentValue.create_date).format('YYYY-MM-DD HH:mm:ss'),
                settle_time: moment(currentValue.settle_time).format('YYYY-MM-DD HH:mm:ss'),
                update_date: moment(currentValue.update_date).format('YYYY-MM-DD HH:mm:ss'),
                open_time: moment(currentValue.open_time).format('YYYY-MM-DD HH:mm:ss'),
                user: {
                    name: currentValue.user_name,
                    type: currentValue.user_type,
                    nick: currentValue.nickname,
                    gender: currentValue.gender,
                    head_url: S(currentValue.head_url || '').startsWith('https://') ? currentValue.head_url :
                        S(currentValue.head_url || '').isEmpty() ? "" : config.prefix_img_url_header + (currentValue.head_url || '')
                },
                parent: {
                    parentUserId: currentValue.parent_user_id,
                    parentType: currentValue.parent_type,
                    parnetNickName: currentValue.parent_nickname
                }
            };
        });
        return res.pkg.data;
    }).then(function (baseJson) {
        // 如果数据为空，说明没有查询到数据，后面再进行处理就会报错，所以直接抛出错误到错误处理处，错误处理处对错误进行忽略即可。
        if(baseJson.length === 0){
            var err = new Error();
            err.code = 100;
            throw  err;
        }
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
                'ans.is_right, ' +
                'ord.sum, ' +
                't.play_type ' +
                'FROM t_task_answers AS ans ' +
                'LEFT JOIN ( ' +
                'SELECT answer_id, SUM(quantity) AS sum FROM t_task_orders GROUP BY answer_id ) AS ord ' +
                'ON ans.answer_id = ord.answer_id ' +
                'LEFT JOIN t_tasks t ON ans.task_id=t.task_id ' +
                'WHERE ans.task_id IN ? ORDER BY ans.answer_id',
                values: [[taskIds]]
            }), Q.ninvoke(mysql, 'query', {
                // 查询足球队伍
                sql: 'SELECT tfb_id, task_id, team_name,team_logo,court_type FROM t_task_football WHERE task_id IN ?',
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
                pic_url: config.prefix_img_url_task + p2.pic_url
            });
            return p1;
        }, {});

        // 处理查询答案相关内容结果,task_id分组
        var group_answer = results[1][0].reduce(function (p1, p2) {
            if (!(p2.task_id in p1)) {
                p1[p2.task_id] = [];
            }
            //让球和大小球不显示平局答案
            if((p2.play_type==2 || p2.play_type==3) && p2.answer=="平"){

            }else{
                p1[p2.task_id].push({
                    answer_id: p2.answer_id,
                    answer: p2.answer,
                    is_right:!!p2.is_right,
                    odds: p2.odds,
                    sum: p2.sum || 0
                });
            }
            return p1;
        }, {});

        // 处理足球
        var group_football = results[2][0].reduce(function (p1, p2) {
            if (!(p2.task_id in p1)) {
                p1[p2.task_id] = [];
            }
            p1[p2.task_id].push({
                tfb_id: p2.tfb_id,
                team_name: p2.team_name,
                team_logo: p2.team_logo,
                court_type: p2.court_type
            });
            return p1;
        }, {});
        // 将图片和答案相关内容写入到返回值中
        res.pkg.data = res.pkg.data.map(function (p1) {
            p1.pics = group_pic[p1.task_id];
            p1.teams = group_football[p1.task_id];
            p1.answer = group_answer[p1.task_id];
            if(parseInt(p1.task_status) === 30 || p1.user_id === req.headers.user_id){

            }else{
                if(!!p1.answer){
                    p1.answer.map(function (p, p2, p3) {
                        p.is_right = undefined;
                        return p;
                    });
                }
            }
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
        // code === 100 表示无数据
        if(error.code !== 100){
            res.pkg.success = false;
            res.pkg.message = error.message;
            res.pkg.code = -1;
            res.pkg.data = null;
        }
    }).done(function () {
        res.jsonp(res.pkg);
    });
};

module.exports.latest = latest;