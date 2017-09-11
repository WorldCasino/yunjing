/**
 * Created by Administrator on 2017/5/14.
 */
/**
 * Created by Administrator on 2017/5/14.
 */

var path = require('path');
var mysql = require(path.join(rootDir, './core/db')).mysql;
var redisPub = require(path.join(rootDir, './core/db')).redisPub;
var Q = require('q');
var moment = require('moment');
var pd = require(path.join(rootDir, './core/preconditions'));
var S = require('string');
var config = require(path.join(rootDir, './config'));
//// 直接用连接池会锁定表后一直不释放，造成死锁【连接池每次使用会使用不同的连接对象】
//var mysqlLock = require('mysql');

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
    var user_id = parseInt(req.headers.user_id);
    var task_id, quantity, answer_id;
    // 单价
    var price = false;
    //下注玩家账户ID
    var accountId = false;
    //币种
    var coin_type = 0;
    //玩家昵称 推送用
    var nickname = false;


    //操作类型
    var operateType ;
    //竞猜类型
    var task_type ;
    var operate_time=new Date();
    // var conn = mysqlLock.createConnection({
    //     host: config.mysql.host,
    //     user: config.mysql.user,
    //     password: config.mysql.password,
    //     database: config.mysql.database
    // });
    // conn.connect();
    var conn;


    Q.fcall(function () {
        pd.checkArgument(!!req.body.task_id, '参数task_id必须设置');
        pd.checkArgument(!!req.body.quantity, '参数quantity必须设置');
        pd.checkArgument(!!req.body.answer_id, '参数answer_id必须设置');
        //
        task_id = parseInt(req.body.task_id);
        quantity = parseInt(req.body.quantity);
        answer_id = parseInt(req.body.answer_id);
    }).then(function () {
        // 锁定表，避免多个用户都下注时候超过了总的下注数【只用锁定一个表就可以了，因为其它都在这个步骤之后才能执行】
        // pool 方式也不行，BUG?
        return Q.ninvoke(mysql,'getConnection').then(function (conn_direct) {
            conn = conn_direct;
            // return Q.all([
            //     Q.ninvoke(conn, 'query', 'LOCK TABLES t_task_orders WRITE,t_task WRITE'),
            //     Q.ninvoke(conn, 'query', 'LOCK TABLES t_tasks WRITE')
            // ]);
            // return Q.ninvoke(conn, 'query', 'LOCK TABLES t_task_orders WRITE,t_tasks WRITE,t_user_account WRITE,t_user_account_detail WRITE');
            //return Q.ninvoke(conn, 'query', 'LOCK TABLES t_tasks WRITE');
        });
        //return Q.ninvoke(conn, 'query', 'LOCK TABLES t_tasks WRITE, t_task_orders WRITE');
    }).then(function () {
        // 判是否可以买入
        //console.log('step2');
        return Q.all([
            Q.ninvoke(mysql, 'query', {
                sql: 'SELECT  a.account_id, a.coin_balance, a.coin_locked,u.nickname ' +
                'FROM t_user_account a join m_users u on u.user_id = a.user_id ' +
                'WHERE a.user_id = ? ' +
                'order by coin_type ',
                values: [user_id]
            }),
            Q.ninvoke(conn, 'query', {
                sql: 'SELECT t_tasks.task_id, t_tasks.sale_price AS price, t_tasks.task_status AS stat, t_tasks.quantity AS total,t_tasks.lock_time,t_tasks.task_type, ' +
                'SUM(t_task_orders.quantity) AS sold ' +
                'FROM t_tasks ' +
                'LEFT JOIN t_task_orders ' +
                'ON t_tasks.task_id AND t_task_orders.task_id ' +
                'WHERE t_tasks.task_id = ? AND t_task_orders.task_id = ? AND t_task_orders.is_delete = 0',
                values: [task_id, task_id]
            }),
            Q.ninvoke(mysql, 'query', {
                sql: 'SELECT COUNT(*) AS cnt FROM t_task_answers WHERE answer_id = ? AND task_id = ? AND is_delete = 0',
                values: [answer_id, task_id]
            }),
            Q.ninvoke(mysql, 'query', {
                sql: 'SELECT like_peas ' +
                'FROM t_tasks ' +
                'WHERE  task_id = ? AND is_delete = 0',
                values: [task_id]
            })
        ]).then(function (result) {
            //是否可以用金豆
            var judge = parseInt(result[3][0][0].like_peas);
            //我的账户ID，
            //accountId = result[0][0].length === 2 ? parseInt(result[0][0][0].account_id || 0) : 0;
            //console.log('step2');
            //默认金币id
            accountId = parseInt(result[0][0][0].account_id);

            // 我的结余金币
            if(judge === 0){//不能用金豆
                var myLeft = result[0][0].length === 2 ? parseFloat(result[0][0][0].coin_balance || 0.0) : 0.0;
            }
            if(judge === 1){//可以用金豆
                //金币做够下注
                if((result[0][0][0].coin_balance - result[0][0][0].coin_locked) >= (quantity * result[1][0][0].price)){
                    var myLeft = result[0][0].length === 2 ? parseFloat(result[0][0][0].coin_balance || 0.0) : 0.0;
                }else{//金币不足
                    //金豆足够下注
                    if((result[0][0][1].coin_balance - result[0][0][1].coin_locked) >= (quantity * result[1][0][0].price)){
                        //币种是金豆
                        coin_type = 1;
                        //金豆id
                        accountId = parseInt(result[0][0][1].account_id);
                        var myLeft = result[0][0].length === 2 ? parseFloat(result[0][0][1].coin_balance || 0.0) : 0.0;
                    }else{//金豆不足
                        pd.checkState(true, '金币不足，购买金币后再下注',1001);
                    }
                }
            }


            // 锁定的金币
            var locked = result[0][0].length === 2 ? parseFloat(result[0][0][0].coin_locked || 0.0) : 0.0;
            // 玩家昵称
            nickname = result[0][0].length === 2 ? result[0][0][0].nickname || '' : '';

            var rows = result[1][0];
            pd.checkState(rows.length === 1, '没有查询到相关项目:' + S(task_id).s);
            // 已经售出的数目
            var sold = parseFloat(rows[0].sold || 0.0);
            // 可以出售的数目
            var total = parseFloat(rows[0].total);
            // 任务状态
            var status = parseInt(rows[0].stat);
            // 任务单价
            price = parseFloat(rows[0].price);
            //可下注时间
            var lockTime = rows[0].lock_time;

            taskType = parseInt(rows[0].task_type);

            var answers = result[2][0];

            // 状态保存到变量中
            res.locals.status = status;

            pd.checkState(answers[0].cnt === 1, '系统开小差了');//答案编号不正确
            pd.checkState(status === 20, '竞猜已经开奖，不能下注了');
            pd.checkState((myLeft - locked) >= (quantity * price), '金币不足，购买金币后再下注',1001);
            pd.checkState(quantity <= (total - sold), '注数已经下满了');
            pd.checkState(lockTime == null || lockTime > new Date(), '下注已经截止，不能下注了');
        });

    }).then(function () {
        //console.log('step3');
        return Q.fcall(function () {
            // 添加记录到t_task_orders
            var kvp = {
                task_id: task_id,
                user_id: user_id,
                answer_id: answer_id,
                quantity: quantity,
                coin_type: coin_type,
                create_by: user_id,
                update_by: user_id
            };
            return Q.ninvoke(conn, 'query', {
                sql: 'INSERT INTO t_task_orders SET ?',
                values: kvp
            }).then(function (result) {
                var rows = result[0];
                // TODO: 如果t_task_orders可以通过trigger方式更新t_user_account
                // insertId，更新总数出错后可以回滚
                return rows.insertId;
            });
        }).then(function (insertId) {
            // 更新统计表
            // return Q.ninvoke(mysql, 'query', {
            //     sql: 'UPDATE t_user_account SET coin_balance = coin_balance - ?,coin_expend = coin_expend + ?,task_join = task_join + 1  WHERE user_id = ?',
            //     values: [quantity * price, quantity * price, user_id]
            // }).then(function () {
            //     return insertId;
            // }).catch(function (error) {
            //     // 回滚删除下注记录表
            //     return Q.ninvoke(conn, 'query', {
            //         sql: 'DELETE FROM t_task_orders WHERE tord_id = ?',
            //         values: [insertId]
            //     }).then(function () {
            //         throw error;
            //     });
            // });

            return Q.fcall(function (insertId) {
                // 添加记录到t_user_account_detail
                //accountId需要判别类型
                var kvp = {
                    account_id: accountId,
                    user_id: user_id,
                    coins: quantity * price ,
                    from_type: 3,//收支来源 （0：充值金币 1：充值送金币 2：竞猜收入 3：竞猜下注 4：商品兑换 5：发布竞猜盈利 6：发布竞猜赔付 7：新用户注册奖励 8：登录奖励）
                    task_id: task_id,
                    create_by: user_id,
                    update_by: user_id
                };
                return Q.ninvoke(conn,'query', {
                            sql: 'INSERT INTO t_user_account_detail SET ?',
                            values: kvp
                        }
                ).then().then(function (result) {
                    // var rows = result[0];
                    return insertId;
                }).catch(function (error) {
                    // 回滚删除下注记录表
                    return Q.ninvoke(conn, 'query', {
                        sql: 'DELETE FROM t_task_orders WHERE tord_id = ?',
                        values: [insertId]
                    }).then(function () {
                        throw error;
                    });
                });
            });

            return insertId;
        }).then(function (insertId) {
            // 更新统计表
            //更新条件用account_id
            return Q.ninvoke(mysql, 'query', {
                sql: 'UPDATE t_user_account SET coin_balance = coin_balance - ?,coin_expend = coin_expend + ?,task_join = task_join + 1  WHERE account_id = ?',
                values: [quantity * price, quantity * price, accountId]
            }).then(function () {
                return insertId;
            }).catch(function (error) {
                // 回滚删除下注记录表
                return Q.ninvoke(conn, 'query', {
                    sql: 'DELETE FROM t_task_orders WHERE tord_id = ?',
                    values: [insertId]
                }).then(function () {
                    throw error;
                });
            }).then(function () {
                // 根据下注数量将下注操作加入操作日志表
                return Q.fcall(function () {
                    // 添加记录到t_operate_log
                    var kvp = {
                        operate_type:10,
                        user_id: user_id,
                        quantity:quantity,
                        task_id:task_id,
                        operate_time:operate_time
                    };
                    return Q.ninvoke(conn, 'query', {
                        sql: 'INSERT INTO t_operate_log SET ?',
                        values: kvp
                    })
                })
            }).then(function () {
                // 根据参与竞猜数量将下注操作加入操作日志表
                return Q.fcall(function () {
                    // 添加记录到t_operate_log
                    var kvp = {
                        operate_type:9,
                        user_id: user_id,
                        quantity:1,
                        task_id:task_id,
                        operate_time:operate_time
                    };
                    return Q.ninvoke(conn, 'query', {
                        sql: 'INSERT INTO t_operate_log SET ?',
                        values: kvp
                    })
                })
            }).then(function () {
                // 根据竞猜类型task_type将下注操作加入操作日志表并添加到队列(图文--5，足球--7，篮球--8，未知--6)
                if(taskType==0){
                    operateType=5;
                }else if(taskType==1){
                    operateType=7
                }else if(taskType==2){
                    operateType=8
                }else if(taskType==3){
                    operateType=6
                }
                return Q.fcall(function () {
                    // 添加记录到t_task_orders
                    var kvp = {
                        operate_type:operateType,
                        user_id: user_id,
                        quantity:1,
                        task_id:task_id,
                        operate_time:operate_time
                    };
                    return Q.ninvoke(conn, 'query', {
                        sql: 'INSERT INTO t_operate_log SET ?',
                        values: kvp
                    })
                })
            }).then(function () {
                // 根据下注币种coin_type将下注操作加入操作日志表并添加到队列(金币--3，金豆--4)
                if(coin_type==0){
                    operateType=3;
                }else if(coin_type==1){
                    operateType=4
                }
                return Q.fcall(function () {
                    // 添加记录到t_task_orders
                    var kvp = {
                        operate_type:operateType,
                        user_id: user_id,
                        quantity:1,
                        task_id:task_id,
                        operate_time:operate_time
                    };
                    return Q.ninvoke(conn, 'query', {
                        sql: 'INSERT INTO t_operate_log SET ?',
                        values: kvp
                    })
                })
            });
        }).then(function (insertId) {
            // 解锁表
            // Q.ninvoke(conn, 'query', 'UNLOCK TABLES'); //TODO
            conn.release();
            //
            res.pkg.data = {
                tord_id: insertId,
                task_id: task_id,
                quantity: quantity,
                answer_id: answer_id,
                price: price,
                cost: quantity * price
            };
            return res.pkg;
        })
    }).then(function () {
        // 发送下注状态到后台处理 开奖
        return Q.ninvoke(redisPub, 'publish', 'lottery_queue_online', JSON.stringify({
            taskId:parseInt(req.body.task_id),
            userId: parseInt(req.headers.user_id),
            taskStatus:res.locals.status //加个状态
        })).catch(function (error) {
            //TODO 添加后台错误处理代码
            console.log(error);
        });
    }).then(function () {
        // 发送下注信息给前端展示 首页数据刷新
        return Q.ninvoke(redisPub, 'publish', 'PUSH_MESSAGE', JSON.stringify({
            type:'chat',
            chat:{type:"broadcast",sender:"system",payload:nickname+"购买了1注",room:parseInt(req.body.task_id)},
        })).catch(function (error) {
            console.log(error);
        });
    }).then(function () {
        // 发送下注信息给前端展示 聊天室
        return Q.ninvoke(redisPub, 'publish', 'CHAT_MESSAGE', JSON.stringify({
            type:"broadcast",
            sender:"system",
            payload:nickname+"购买了1注",
            room:parseInt(req.body.task_id)
        })).catch(function (error) {
            console.log(error);
        });
    })
        .then(function () {
        // 根据下注数量将下注操作加入操作日志表并添加到队列
        return Q.ninvoke(redisPub, 'publish', 'operate_queue_online', JSON.stringify({
            operateType:10,
            userId:user_id,
            quantity:quantity,
            taskId:task_id,
            operateTime:operate_time
        })).catch(function (error) {
            console.log(error);
        });
    }).then(function () {
        // 根据参与竞猜数量将下注操作加入操作日志表并添加到队列
        return Q.ninvoke(redisPub, 'publish', 'operate_queue_online', JSON.stringify({
            operateType:9,
            userId:user_id,
            quantity:1,
            taskId:task_id,
            operateTime:operate_time
        })).catch(function (error) {
            console.log(error);
        });
    }).then(function () {
        // 根据竞猜类型taskType将下注操作加入操作日志表并添加到队列(图文--5，足球--7，篮球--8，未知--6)
        if(taskType==0){
            operateType=5;
        }else if(taskType==1){
            operateType=7
        }else if(taskType==2){
            operateType=8
        }else if(taskType==3){
            operateType=6
        }
        return Q.ninvoke(redisPub, 'publish', 'operate_queue_online', JSON.stringify({
            operateType:operateType,
            userId:user_id,
            quantity:1,
            taskId:task_id,
            operateTime:operate_time
        })).catch(function (error) {
            console.log(error);
        });
    }).then(function () {
        // 根据下注币种coin_type将下注操作加入操作日志表并添加到队列(金币--3，金豆--4)
        if(coin_type==0){
            operateType=3;
        }else if(coin_type==1){
            operateType=4
        }
        return Q.ninvoke(redisPub, 'publish', 'operate_queue_online', JSON.stringify({
            operateType:operateType,
            userId:user_id,
            quantity:1,
            taskId:task_id,
            operateTime:operate_time
        })).catch(function (error) {
            console.log(error);
        });
    }).then(function () {
        setTimeout(function () {
             Q.ninvoke(mysql, 'query', {
                sql: 'UPDATE t_task_orders SET status = 1 WHERE user_id = ? and task_id = ?',
                values: [user_id ,task_id]
            })
        },1500)
    })
        .catch(function (error) {
        // 解锁表
        // Q.ninvoke(conn, 'query', 'UNLOCK TABLES');//TODO
        conn.release();
        res.pkg.success = false;
        res.pkg.message = error.message;
        res.pkg.code = error.code || -1;
        res.pkg.data = null;
    }).done(function () {
        res.jsonp(res.pkg);
    });
};