/**
 * Created by Administrator on 2017/5/3.
 */
var path = require('path');
var mysql = require(path.join(rootDir, './core/db')).mysql;
var redis = require(path.join(rootDir, './core/db')).redis;
var Q = require('q');
var moment = require('moment');
var pd = require(path.join(rootDir, './core/preconditions'));
var gm = require('gm');
// var gm = require('gm').subClass({ imageMagick : true });
var config = require(path.join(rootDir,'./config'));
var fs = require('fs');
var settle_time = '';
/**
 * 发布竞猜（体育类）
 * @param req
 * req.headers.user_id : 个人的user id，即t_user_account  user id
 * @param res
 * @param next
 */
module.exports = function (req, res, next) {
    var user_id = req.headers.user_id;
    //开奖方式、发布方式、币种
    var lottery_type = 0,
        personal = parseInt(req.body.personal),
        like_peas = parseInt(req.body.like_peas),

        task_type = parseInt(req.body.task_type),
        match_id = parseInt(req.body.match_id),//比赛id
        match_type = parseInt(req.body.match_type),//体育类：1-足球，2-篮球
        play_type = parseInt(req.body.play_type),//足球类玩法：1-标准盘，2-让球，3-大小球
        concede_points = parseInt(req.body.concede_points),//让球数或盘口

        home = req.body.home,
        visit = req.body.visit,
        odds_home = parseFloat(req.body.odds_home),
        odds_tie = parseFloat(req.body.odds_tie),
        odds_visit = parseFloat(req.body.odds_visit),

        settle_time=req.body.settle_time,
        lock_time = req.body.lock_time;

    if(!odds_tie){
        odds_tie=0
    }

    var operate_time=new Date();
    var taskId;
    Q.fcall(function () {
        // 检查传入参数
        pd.checkArgument(!!(req.body.content), '参数content不能为空');
        pd.checkArgument(!!req.body.price, '参数price必须设置');
        pd.checkArgument(!!req.body.quantity, '参数quantity必须设置');

        pd.checkArgument(!!match_id, '参数match_type不能为空')
        pd.checkArgument(!!match_type, '参数match_type不能为空');
        pd.checkArgument(!!play_type, '参数play_type不能为空');

        pd.checkArgument(!!home, '参数home不能为空');
        pd.checkArgument(!!visit, '参数visit不能为空');
        pd.checkArgument(!!odds_home, '参数odds_home不能为空');
        pd.checkArgument(!!odds_visit, '参数odds_visit不能为空');
        //足球(平局)
        if(match_type==1 && (play_type==1 || play_type==2)){
            pd.checkArgument(!!odds_tie, '参数odds_tie不能为空');
        }


    }).then(function () {
        //检查用户金币是否够用，不够用返回错误，够用进行冻结。
        //var user_id = req.headers.user_id,
        var price = parseFloat(req.body.price),
            quantity = parseInt(req.body.quantity),

            //获取最大赔率（用于冻结金币计算）
            odds=odds_home>odds_visit?(odds_home>odds_tie?odds_home:odds_tie):(odds_visit>odds_tie?odds_visit:odds_tie);
        return Q.fcall(function () {
            // 查询金币结余是否够用
            return Q.ninvoke(mysql,'query',{
                sql: 'SELECT coin_balance, coin_locked FROM t_user_account WHERE user_id = ? and coin_type = 0',
                values: [user_id]
            }).then(function (result) {
                // 我的结余金币
                var myLeft = result[0].length === 1 ? parseFloat(result[0][0].coin_balance || 0.0) : 0.0;
                // 锁定的金币
                var locked = result[0].length === 1 ? parseFloat(result[0][0].coin_locked || 0.0) : 0.0;
                //pd.checkState((myLeft-locked)>=(price*quantity),"金币不足",1001)
                pd.checkState((myLeft-locked)>=(quantity * price * (odds - 1)),"金币不足",1001);
                return true;
            });
        }).then(function () {
            // 冻结金币
            return Q.ninvoke(mysql, 'query', {
                sql: 'UPDATE t_user_account SET coin_locked = coin_locked + ?,task_count = task_count + 1  WHERE user_id = ? and coin_type = 0',
                values: [quantity * price * (odds - 1), user_id]
                // values: [quantity * price, user_id] 这个冻结金币计算公式不对
            });
        })
    }).then(function(){
        //查询用户类型,判断personal的值
        return Q.ninvoke(mysql, 'query', {
            sql: 'select user_type from m_users WHERE user_id = ?',
            values: [user_id]
        }).then(function (result) {
            var user_type = parseInt(result[0][0].user_type);
            if(lottery_type === 1 && user_type !== 2){
                personal = 1;
            }
        });
    }).then(function () {
        // 插入到mysql
        var content = req.body.content,
            price = req.body.price,
            quantity = req.body.quantity;
        //var user_id = req.headers.user_id;

        return Q.fcall(function () {
            // 插入主表t_tasks
            return Q.ninvoke(mysql, 'query', {
                sql: 'INSERT INTO t_tasks SET ? ',
                values: {
                    user_id: user_id,
                    task_type: task_type,
                    match_id: match_id,
                    match_type: match_type,
                    play_type: play_type,
                    concede_points: concede_points,
                    task_content: content,
                    task_status: 20,
                    sale_price: price,
                    quantity: quantity,
                    lottery_type: lottery_type,//... 0:自动开奖  1:手动开奖
                    personal: personal,//...  0:平台发布  1:私人发布
                    like_peas: like_peas,//... 0:不接受金豆  1:接受金豆
                    create_by: user_id,
                    update_by: user_id,
                    settle_time: settle_time,
                    lock_time: lock_time//...  下注截止时间
                }
            }).then(function (results) {
                taskId = results[0].insertId;
                return taskId;
            });
        }).then(function (taskId) {// 插入答案t_task_answers
            if (match_type == 1 && (play_type==1 || play_type==2)){
                var answers = [{
                    task_id: taskId,
                    answer: '主胜',
                    is_right: 0,
                    odds: odds_home,
                    create_by: user_id
                }, {
                    task_id: taskId,
                    answer: '平',
                    is_right: 0,
                    odds: odds_tie,
                    create_by: user_id
                }, {
                    task_id: taskId,
                    answer: '客胜',
                    is_right: 0,
                    odds: odds_visit,
                    create_by: user_id
                }];
            }else if(match_type == 1 && play_type==3){
                var answers = [{
                    task_id: taskId,
                    answer: '大球',
                    is_right: 0,
                    odds: odds_home,
                    create_by: user_id
                }, {
                    task_id: taskId,
                    answer: '小球',
                    is_right: 0,
                    odds: odds_visit,
                    create_by: user_id
                }];
            }else if(match_type == 2){
                var answers = [{
                    task_id: taskId,
                    answer: '主胜',
                    is_right: 0,
                    odds: odds_home,
                    create_by: user_id
                }, {
                    task_id: taskId,
                    answer: '客胜',
                    is_right: 0,
                    odds: odds_visit,
                    create_by: user_id
                }];
            }


            if(new Date().getSeconds()%2 ==0){
                answers.reverse();
            }
            var fns = answers.map(function (p1, p2, p3) {
                return Q.ninvoke(mysql, 'query', {
                    sql: 'INSERT INTO t_task_answers SET ?',
                    values: p1
                });
            });

            // TODO  可以加入答案id等
            return Q.all(fns);
            // // all 不是按顺序执行
            // return Q.all(fns).then(function (results) {
            //     var answerIds = answers.map(function (p1, p2, p3) {
            //         return {
            //             answer_id: results[p2][0].insertId,
            //             is_right: p1.is_right
            //         }
            //     });
            //     res.pkg.data.answers = answerIds;
            //     return answerIds;
            // });
        }).then(function () {//插入足球表t_task_football
            var values = [{
                task_id: taskId,
                team_name: home,
                court_type: 0,
                create_by: user_id
            }, {
                task_id: taskId,
                team_name: visit,
                court_type: 1,
                create_by: user_id
            }];
            var fns = values.map(function (p1, p2, p3) {
                return Q.ninvoke(mysql, 'query', {
                    sql: 'INSERT INTO t_task_football SET ?',
                    values: p1
                });
            });
            return Q.all(fns);
        }).then(function () {
            // 发布操作加入操作日志表并添加到队列
            return Q.fcall(function () {
                // 添加记录到t_operate_log
                var kvp = {
                    operate_type:2,
                    user_id: user_id,
                    task_id:taskId,
                    operate_time:operate_time
                };
                return Q.ninvoke(mysql, 'query', {
                    sql: 'INSERT INTO t_operate_log SET ?',
                    values: kvp
                })
            })
        }).then(function () {
            // 发布操作加入操作日志表并添加到队列
            return Q.ninvoke(redis, 'publish', 'operate_queue_online', JSON.stringify({
                operateType:2,
                userId:user_id,
                quantity:1,
                taskId:taskId,
                operateTime:operate_time
            })).catch(function (error) {
                console.log(error);
            });
        }).then(function () {
            Q.ninvoke(redis,'select',config.redis_index_of_lottery_keys)
                .then(function () {
                    //插入redis，倒计时开奖用
                    var key = config.redis_key_lottery_prefix+taskId;
                    redis.set(key, JSON.stringify({
                        taskId:taskId,
                        settleTime:settle_time
                    }));
                    var ttl = parseInt(new Date(settle_time).getTime()/1000 - new Date().getTime()/1000)+60;//开奖时间延迟60秒再开奖
                    redis.expire(key,ttl);

                }).then(function () {
                    //插入redis，比较结束插入答案
                    var key = config.redis_key_score_prefix+taskId;
                    redis.set(key, JSON.stringify({
                        taskId:taskId,
                        matchType:match_type,
                        playType:play_type,
                        settleTime:settle_time
                    }));
                    var ttl = parseInt(new Date(settle_time).getTime()/1000 - new Date().getTime()/1000);
                        redis.expire(key,ttl);

            }).catch(function () {
                //redis出错先不处理
            });
        });
    }).catch(function (error) {
        console.log("publish error : "+error);
        // TODO 回滚mysql中已经加入的信息
        return Q.fcall(function () {
            if(!!taskId){
                return Q.ninvoke(mysql, 'query', {
                    sql: 'DELETE FROM t_tasks WHERE task_id = ? ',
                    values: [taskId]
                })
            }else {
                return true;
            }
        }).then(function () {
            res.pkg.success = false;
            res.pkg.message = error.message;
            res.pkg.code = error.code || -1;
            res.pkg.data = null;
            return res.pkg;
        }).catch(function () {
            res.pkg.success = false;
            res.pkg.message = error.message;
            res.pkg.code = error.code || -1;
            res.pkg.data = null;
            return res.pkg;
        });

    }).done(function () {
        console.log(res.pkg);
        res.jsonp(res.pkg);
    });
};