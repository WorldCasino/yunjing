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
var config = require(path.join(rootDir,'./config'));
var fs = require('fs');
/**
 * 复制发布竞猜
 * @param req
 * req.headers.user_id : 个人的user id，即t_user_account  user id
 * @param res
 * @param next
 */
module.exports = function (req, res, next) {
    var user_id = req.headers.user_id;
    var personal = parseInt(req.body.personal),
        like_peas = parseInt(req.body.like_peas),
        concede_points_show = req.body.concede_points_show,
        concede_points = 0,
        task_content = req.body.task_content;
        //task_type = parseInt(req.body.task_type);
    var params = {};
    var operate_time=new Date();
    Q.fcall(function () {
        // 检查传入参数
        pd.checkArgument(!!(req.body.taskId), '参数taskId不能为空');
        pd.checkArgument(!!req.body.price, '参数price必须设置');
        pd.checkArgument(!!req.body.quantity, '参数quantity必须设置');
        pd.checkArgument(!!(req.body.answerList), '参数answerList必须设置');
    }).then(function () {
        params.parentId = req.body.taskId;
        params.user_id = req.headers.user_id;

        var orgTask ={};
        return Q.fcall(function () {
            //检查复制的竞猜是否有效
            return Q.ninvoke(mysql,'query',{
                sql: 'SELECT task_id,task_type,task_status,lock_time,parent_id FROM t_tasks WHERE task_id = ? and is_delete = 0 ',
                values: [params.parentId]
            }).then(function (result) {
                orgTask =result[0].length === 1 ? result[0][0]:null;
                pd.checkState(orgTask!=null,"复制的竞猜不存在或已删除");
                pd.checkState(orgTask.task_status!==30,"已开奖项目不能复制");
                pd.checkState(orgTask.task_status===20,"只有竞猜中的项目可以复制");
                pd.checkState(!(orgTask.lock_time != null && moment().isAfter(moment(orgTask.lock_time))),"已锁定项目不能复制");

                //转发的始终以第一个竞猜为主
                if(orgTask.parent_id>0) params.parentId = orgTask.parent_id;

                params.orgTask = orgTask;
                params.task_type = orgTask.task_type;

                var lock_time=orgTask.lock_time;
                //体育类竞猜开赛前15分钟前不能下注(锁定)，30分钟不能发布
                if((params.task_type==1 || params.task_type==2) && new Date(new Date(lock_time).setMinutes(new Date(lock_time).getMinutes()-15)).getTime()<operate_time.getTime()){
                    pd.checkArgument(false, '体育类竞猜开赛前半小时不能下注');
                }

                return orgTask;
            });
        })
    }).then(function(){
        //根据concede_points_show得到concede_points
        return Q.ninvoke(mysql, 'query', {
            sql: 'select concede_points from t_concede_points WHERE concede_points_show = ?',
            values: [concede_points_show]
        }).then(function (result) {
            concede_points = parseFloat(result[0][0].concede_points);
        });
    }).then(function () {
        //检查用户金币是否够用，不够用返回错误，够用进行冻结。
        var price = parseFloat(req.body.price),
            quantity = parseInt(req.body.quantity);

        var maxOdds = 0;
        for(var i=0;i<req.body.answerList.length;i++){
            var cur_odds =parseFloat(req.body.answerList[i].odds);
            if(cur_odds > maxOdds) maxOdds = cur_odds;
        }
        return Q.fcall(function () {
            // 查询金币结余是否够用
            return Q.ninvoke(mysql,'query',{
                sql: 'SELECT coin_balance, coin_locked FROM t_user_account WHERE user_id = ? and coin_type = 0',
                values: [params.user_id]
            }).then(function (result) {
                // 我的结余金币
                var myLeft = result[0].length === 1 ? parseFloat(result[0][0].coin_balance || 0.0) : 0.0;
                // 锁定的金币
                var locked = result[0].length === 1 ? parseFloat(result[0][0].coin_locked || 0.0) : 0.0;

                params.lockedBalance = parseFloat(quantity * price * (maxOdds - 1));
                pd.checkState((myLeft-locked)>= params.lockedBalance,"金币不足",1001);
                return true;
            });
        }).then(function () {
            // 冻结金币
            return Q.ninvoke(mysql, 'query', {
                sql: 'UPDATE t_user_account SET coin_locked = coin_locked + ?,task_count = task_count + 1  WHERE user_id = ? and coin_type = 0',
                values: [params.lockedBalance, params.user_id]
            }).catch(function (e) {
                //冻结金币出错时，清空冻结金额，防止回滚的时候 计算错误
                params.lockedBalance = 0;
                throw e;
            });
        })
    }).then(function () {
        // 插入到mysql
        var price = parseFloat(req.body.price),
            quantity = parseInt(req.body.quantity);

        return Q.fcall(function () {
            /* TODO 为什么这种写法不可以！！！
            //插入竞猜项目表，图片表，球队信息表
            var sqlStr = 'start transaction; '+
                'set @user_id =?; '+
                'set @parent_id =?; '+
                'set @quantity =?; '+
                'set @sale_price =?; '+
                'set @lockedCoins =?; '+

                'insert into t_tasks(user_id,task_title,task_type,task_content,sale_price,quantity,sale_amount,task_status,hot,lock_time,settle_time,parent_id,locked_coins,create_by) '+
                'select @user_id,task_title,task_type,task_content,@sale_price,@quantity,@sale_price*@quantity,task_status,hot,lock_time,settle_time,@parent_id,@lockedCoins,@user_id '+
                'from t_tasks t '+
                'where t.task_id = @parent_id ; '+
                'set @new_taskid = last_insert_id(); '+

                'insert into t_task_pictures(task_id,pic_url,blur_pic_url,pic_type,create_by) '+
                'select @new_taskid,pic_url,blur_pic_url,pic_type,create_by '+
                'from t_task_pictures t '+
                'where t.task_id = @parent_id and t.is_delete = 0; '+

                'insert into t_task_football(task_id,team_name,court_type,create_by) '+
                'select task_id,team_name,court_type,create_by '+
                'from t_task_football t '+
                'where t.task_id = @parent_id and t.is_delete = 0; '+

                'select @new_taskid as new_taskid; '+

                'select answer_id,answer,is_right from t_task_answers where task_id = @parent_id;'+

                'commit; ';
            console.log(sqlStr);

            return Q.ninvoke(mysql, 'query', {
                sql:sqlStr,
                values: [81]
                // values: [user_id,parentId,quantity,price,lockedBalance]
            }).then(function (results) {
                var new_taskid = results[0].new_taskid;
                res.pkg.data.task_id = new_taskid;
                var newData = {
                    new_taskid:new_taskid,
                    answerList:results[1]
                };

                return newData;
            });
            */

            return Q.ninvoke(mysql, 'query', {
                sql:'insert into t_tasks(user_id,task_title,task_type,match_id,match_type,play_type,concede_points_show,concede_points,task_content,sale_price,quantity,sale_amount,task_status,hot,lock_time,settle_time,personal,like_peas,lottery_type,parent_id,locked_coins,create_by) '+
                'select ?,task_title,task_type,match_id,match_type,play_type,concede_points_show,concede_points,task_content,?,?,?,task_status,0,lock_time,settle_time,?,?,lottery_type,?,?,? '+
                'from t_tasks t '+
                'where t.task_id = ? ; ',
                values: [params.user_id,quantity,price,quantity * price,personal,like_peas,params.parentId,params.lockedBalance,params.user_id,params.parentId]
            }).then(function (results) {
                params.new_taskid = results[0].insertId;
                res.pkg.data ={task_id: params.new_taskid};

                return params.new_taskid;
            });
        }).then(function (new_taskid) {
            //体育类可以编辑竞猜、盘口或让球数描述
            if(params.task_type==1 || params.task_type==2){
                Q.ninvoke(mysql, 'query', {
                    sql:'UPDATE t_tasks SET task_content = ?,concede_points_show=?,concede_points=? WHERE task_id = ?; ',
                    values: [task_content,concede_points_show,concede_points,new_taskid]
                })
            }


            return Q.all([
                Q.ninvoke(mysql, 'query', {
                    sql:'insert into t_task_pictures(task_id,pic_url,blur_pic_url,pic_type,create_by) '+
                    'select ?,pic_url,blur_pic_url,pic_type,create_by '+
                    'from t_task_pictures t '+
                    'where t.task_id = ? and t.is_delete = 0; ',
                    values: [new_taskid,params.parentId]
                }),
                Q.ninvoke(mysql, 'query', {
                    sql:'insert into t_task_football(task_id,team_logo,team_name,court_type,create_by) '+
                    'select ?,team_logo,team_name,court_type,create_by '+
                    'from t_task_football t '+
                    'where t.task_id = ? and t.is_delete = 0; ',
                    values: [new_taskid,params.parentId]
                }),

                // 添加记录到t_operate_log和队列operate_queue_online
                Q.ninvoke(mysql, 'query', {
                    sql: 'INSERT INTO t_operate_log SET ?',
                    values: {
                        operate_type:11,
                        user_id: user_id,
                        task_id:new_taskid,
                        operate_time:operate_time
                    }
                }),
                Q.ninvoke(redis, 'publish', 'operate_queue_online', JSON.stringify({
                    operateType:11,
                    userId:user_id,
                    quantity:1,
                    taskId:res.new_taskid,
                    operateTime:operate_time
                })),

                Q.ninvoke(mysql, 'query', {
                    sql:'select answer_id,answer,is_right from t_task_answers where task_id = ?;',
                    //values: [params.parentId]
                    values: [req.body.taskId]
                })
            ]).then(function (results) {
                params.orgAnswerList = results[4][0];
            });
        }).then(function () {// 插入答案t_task_answers
            var user_id = req.headers.user_id,
                newAnswers = req.body.answerList;
            var answers = [];
            for(var i = 0 ; i < params.orgAnswerList.length ; i++){
                var newOdds =0,
                    parent_answ=0;
                for(var j =0;j<newAnswers.length;j++){
                    if(newAnswers[j].answerId == params.orgAnswerList[i].answer_id){
                        newOdds =newAnswers[j].odds;
                        parent_answ =params.orgAnswerList[i].answer_id;
                        break;
                    }
                }

                //pd.checkArgument(newOdds > 0, '请提供答案ID '+params.orgAnswerList[i].answer_id+'的赔率');

                answers.push({
                    task_id:params.new_taskid,
                    answer:params.orgAnswerList[i].answer,
                    is_right:params.orgAnswerList[i].is_right,
                    odds:newOdds,
                    parent_answ:parent_answ,
                    create_by:user_id
                });
            }

            if(params.task_type==0 || params.task_type==3){
                if(new Date().getSeconds()%2 ==0){
                    answers.reverse();
                }
                var fns = answers.map(function (p1, p2, p3) {
                    return Q.ninvoke(mysql, 'query', {
                        sql: 'INSERT INTO t_task_answers SET ?',
                        values: p1
                    });
                });
                return Q.all(fns);
            }else{
                // 体育类竞猜不要倒序
                return Q.fcall(function () {
                    // 插入第一个答案
                    return Q.ninvoke(mysql,'query',{
                        sql: 'INSERT INTO t_task_answers SET ?',
                        values: answers[0]
                    });
                }).then(function () {
                    // 插入第二个答案
                    return Q.ninvoke(mysql,'query',{
                        sql: 'INSERT INTO t_task_answers SET ?',
                        values: answers[1]
                    });
                }).then(function () {
                    // 插入第三个答案
                    if(answers[2]){
                        return Q.ninvoke(mysql,'query',{
                            sql: 'INSERT INTO t_task_answers SET ?',
                            values: answers[2]
                        });
                    }
                });
            }

            // if(new Date().getSeconds()%2 ==0){
            //     answers.reverse();
            // }
            // var fns = answers.map(function (p1, p2, p3) {
            //     //体育类竞猜，答案要按顺序存储
            //     if(params.task_type==1 || params.task_type==2){
            //         setTimeout(function () {
            //             console.log(p1.answer);
            //         },300);
            //     }
            //
            //
            //     return Q.ninvoke(mysql, 'query', {
            //         sql: 'INSERT INTO t_task_answers SET ?',
            //         values: p1
            //     });
            // });
            //
            // return Q.all(fns);
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
                    if(params.task_type==0 || params.task_type==3){
                        return;
                    }
                    //体育类竞猜,加入待处理比分队列
                    var key = config.redis_key_score_prefix+taskId;
                    redis.set(key, JSON.stringify({
                        taskId:taskId,
                        settleTime:settle_time
                    }));
                    var ttl = parseInt(new Date(settle_time).getTime()/1000 - new Date().getTime()/1000);
                    redis.expire(key,ttl);

            }).catch(function () {
                //redis出错先不处理
            });
        });
    }).catch(function (error) {
        //回滚mysql中已经加入的信息，本次冻结的金币，以及插入的竞猜项目信息
        return Q.fcall(function () {
            var taskId = res.pkg.data.task_id;
            if(!!taskId){
                return Q.all([
                    Q.ninvoke(mysql, 'query', {
                        sql:'UPDATE t_user_account SET coin_locked = coin_locked - ?,task_count = task_count - 1 WHERE user_id = ? and coin_type = 0; ',
                        values: [params.lockedBalance,params.user_id]
                    }),
                    Q.ninvoke(mysql, 'query', {
                        sql:'DELETE FROM t_tasks WHERE task_id = ? ; ',
                        values: [taskId]
                    }),
                    Q.ninvoke(mysql, 'query', {
                        sql:'DELETE FROM t_task_answers where task_id = ?; ',
                        values: [taskId]
                    }),
                    Q.ninvoke(mysql, 'query', {
                        sql:'DELETE FROM t_task_football where task_id = ?; ',
                        values: [taskId]
                    }),
                    Q.ninvoke(mysql, 'query', {
                        sql:'DELETE FROM t_task_football where task_id = ?; ',
                        values: [taskId]
                    })
                ]).catch(function () {
                    console.log(e);
                });
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
        res.jsonp(res.pkg);
    });

};