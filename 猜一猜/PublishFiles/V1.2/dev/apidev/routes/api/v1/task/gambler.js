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


        return Q.all([
            Q.ninvoke(mysql,'query',{
                sql:'SELECT ord.user_id, ord.quantity, ord.create_date, ord.update_date, usr.nickname, usr.gender, usr.head_url ' +
                'FROM ' +
                '( SELECT user_id, task_id, SUM(quantity) AS quantity, MAX(create_date) AS create_date, MAX(update_date) AS update_date ' +
                'FROM t_task_orders WHERE task_id = ? GROUP BY user_id  ' +
                ') AS ord ' +
                'LEFT JOIN m_users AS usr ON ord.user_id = usr.user_id ',
                values:[id]
            }),
            Q.ninvoke(mysql,'query',{
                sql:'select lottery_type, task_status, sale_price, quantity, lock_time, settle_time FROM t_tasks WHERE task_id = ?',
                values:[id]
            }),
            Q.ninvoke(mysql,'query',{
                sql:'SELECT ord.user_id, ord.answer_id, ord.quantity, ord.create_date, ord.update_date, usr.nickname, usr.gender, usr.head_url ' +
                'FROM ( ' +
                '   SELECT user_id, answer_id, SUM(quantity) AS quantity, MAX(create_date) AS create_date, MAX(update_date) AS update_date ' +
                '   FROM t_task_orders WHERE task_id = ? GROUP BY user_id , answer_id ) ' +
                'AS ord ' +
                'LEFT JOIN m_users AS usr ON ord.user_id = usr.user_id ORDER BY answer_id ',
                values:[id]
            }),
            Q.ninvoke(mysql,'query',{
                sql:'select answer_id, is_right, odds FROM t_task_answers WHERE task_id = ? ORDER BY answer_id',
                values:[id]
            }),
            Q.ninvoke(mysql,'query',{
                sql:'select user_type FROM m_users usr LEFT JOIN t_tasks t ON usr.user_id = t.user_id WHERE task_id = ? ',
                values:[id]
            }),
            Q.ninvoke(mysql,'query',{
                sql:'select SUM(is_right = 1) AS sum FROM t_task_answers WHERE task_id = ?  ',
                values:[id]
            }),
            //直接拿开奖结果
            Q.ninvoke(mysql,'query',{
                sql:'select lottery_result FROM t_task_lottery_logs WHERE is_success = 1 and task_id = ?  ',
                values:[id]
            })
        ]).then(function (result) {
            var lottery_type = parseInt(result[1][0][0].lottery_type),
                status = parseInt(result[1][0][0].task_status),
                quantity_count = parseInt(result[1][0][0].quantity),
                salePrice = result[1][0][0].sale_price,
                user_type = parseInt(result[4][0][0].user_type),
                settle_time = result[1][0][0].settle_time,
                lock_time = result[1][0][0].lock_time;

            var answerA = {
                answer_id: result[3][0][0].answer_id,
                quantity: 0
            };
            var answerB = {
                answer_id: result[3][0][1].answer_id,
                quantity: 0
            };
            if (result[3][0].length > 2){
                var answerC = {
                    answer_id: result[3][0][2].answer_id,
                    quantity: 0
                };
            }

            //获取正确答案和正确答案赔率
            var rightId = 0;
            var odds = 0;
            var oddsmax = 0;
            for (var i = 0; i <　result[3][0].length; i++ ){
                if (result[3][0][i].is_right === 1){
                    rightId = result[3][0][i].answer_id;
                    odds = result[3][0][i].odds;
                }
                if (result[3][0][i].odds > oddsmax){
                    oddsmax = result[3][0][i].odds;
                }
            }
            var coin_lock = quantity_count*salePrice*(oddsmax - 1);
            //玩家总下注数
            var userQty = 0;
            result[0][0].map(function (user_quantity) {
                userQty += user_quantity.quantity;
            });
            //平均分的金币
            var coin_avg = coin_lock/userQty;//总下注数
            //已开奖
            if(status === 30){
                res.pkg.data = result[0][0].map(function (currentValue) {
                    answerA = {
                        answer_id: result[3][0][0].answer_id,
                        quantity: 0
                    };
                    answerB = {
                        answer_id: result[3][0][1].answer_id,
                        quantity: 0
                    };
                    if (result[3][0].length > 2){
                        answerC = {
                            answer_id: result[3][0][2].answer_id,
                            quantity: 0
                        };
                    }
                    var coin_in = 0;
                    var coin_out = 0;
                    var coins = 0;
                    //遍历答案
                    result[2][0].map(function (p1) {
                        if (p1.user_id === currentValue.user_id){
                            if (p1.answer_id === result[3][0][0].answer_id){
                                answerA = {
                                    answer_id: p1.answer_id,
                                    quantity: p1.quantity
                                };
                            }else if (p1.answer_id === result[3][0][1].answer_id){
                                answerB = {
                                    answer_id: p1.answer_id,
                                    quantity: p1.quantity
                                };
                            }else if (result[3][0].length > 2 && p1.answer_id === result[3][0][2].answer_id) {
                                answerC = {
                                    answer_id: p1.answer_id,
                                    quantity: p1.quantity
                                };
                            }
                            if (p1.answer_id === rightId){
                                coin_in = p1.quantity * salePrice * odds;
                            }
                        }
                    });

                    if (result[3][0].length > 2) {
                        coin_out = answerA.quantity * salePrice + answerB.quantity * salePrice + answerC.quantity * salePrice;
                    }else
                        coin_out = answerA.quantity * salePrice + answerB.quantity * salePrice;
                    //超时开奖，平份奖金
                    // var t = new Date(lock_time).getTime()+ 60*60*24*1000;
                    // var k = new Date(settle_time).getTime();
                    // if (lottery_type === 1 && (new Date(lock_time).getTime() + 60*60*24*1000) <= new Date(settle_time).getTime()){
                    var lotteryResult = result[6][0].length === 0?null:JSON.parse(result[6][0][0].lottery_result);
                    if(lottery_type === 1 && lotteryResult != null && (lotteryResult.lotteryType || 1) === 2){
                        coins = Math.floor(coin_avg*answerA.quantity*10)/10 + Math.floor(coin_avg*answerB.quantity*10)/10;//+ userQty * salePrice ;
                        coins = Math.floor(coins*10)/10;
                    } else {
                        coins = coin_in - coin_out;
                    }
                    var answers = {
                        A: answerA,
                        B: answerB
                    };
                    if (result[3][0].length > 2){
                        answers = {
                            A: answerA,
                            B: answerB,
                            C: answerC
                        };
                    }
                    return {
                        user_id: currentValue.user_id,
                        user_type: user_type,
                        coins: coins,
                        coin_lock: coin_lock,
                        lottery_type: lottery_type,
                        status: status,
                        create_date: moment(currentValue.create_date).format('YYYY-MM-DD HH:mm:ss'),
                        update_date: moment(currentValue.update_date).format('YYYY-MM-DD HH:mm:ss'),
                        nickname: currentValue.nickname,
                        gender: currentValue.gender,
                        head_url: S(currentValue.head_url || '').startsWith('https://')? currentValue.head_url  :
                            S(currentValue.head_url || '').isEmpty() ? "" : config.prefix_img_url_header + (currentValue.head_url || ''),
                        answer: answers
                    };
                });
            }else{//未开奖
                //手动开奖、普通玩家发布
                if(lottery_type === 1 && user_type > 0){
                    res.pkg.data = result[0][0].map(function (currentValue) {
                        return {
                            user_id: currentValue.user_id,
                            quantity: currentValue.quantity,
                            user_type: user_type,
                            lottery_type: lottery_type,
                            status: status,
                            create_date: moment(currentValue.create_date).format('YYYY-MM-DD HH:mm:ss'),
                            update_date: moment(currentValue.update_date).format('YYYY-MM-DD HH:mm:ss'),
                            nickname: currentValue.nickname,
                            gender: currentValue.gender,
                            head_url: S(currentValue.head_url || '').startsWith('https://')? currentValue.head_url  :
                                S(currentValue.head_url || '').isEmpty() ? "" : config.prefix_img_url_header + (currentValue.head_url || ''),
                        };
                    });
                    //手动开奖、平台发布
                }else if (lottery_type === 1 && user_type === 0) {
                    res.pkg.data = result[0][0].map(function (currentValue) {
                        answerA = {
                            answer_id: result[3][0][0].answer_id,
                            quantity: 0
                        };
                        answerB = {
                            answer_id: result[3][0][1].answer_id,
                            quantity: 0
                        };
                        if (result[3][0].length > 2){
                            answerC = {
                                answer_id: result[3][0][2].answer_id,
                                quantity: 0
                            };
                        }
                        result[2][0].map(function (p1) {
                            if (p1.user_id === currentValue.user_id){
                                if (p1.answer_id === result[3][0][0].answer_id){
                                    answerA = {
                                        answer_id: p1.answer_id,
                                        quantity: p1.quantity
                                    };
                                }else if (p1.answer_id === result[3][0][1].answer_id){
                                    answerB = {
                                        answer_id: p1.answer_id,
                                        quantity: p1.quantity
                                    };
                                }else if (result[3][0].length > 2 && p1.answer_id === result[3][0][2].answer_id){
                                    answerC = {
                                        answer_id: p1.answer_id,
                                        quantity: p1.quantity
                                    };
                                }
                            }
                        });
                        var answers = {
                            A: answerA,
                            B: answerB
                        };
                        if (result[3][0].length > 2){
                            answers = {
                                A: answerA,
                                B: answerB,
                                C: answerC
                            };
                        }
                        return {
                            user_id: currentValue.user_id,
                            user_type: user_type,
                            lottery_type: 1,
                            status: status,
                            create_date: moment(currentValue.create_date).format('YYYY-MM-DD HH:mm:ss'),
                            update_date: moment(currentValue.update_date).format('YYYY-MM-DD HH:mm:ss'),
                            nickname: currentValue.nickname,
                            gender: currentValue.gender,
                            head_url: S(currentValue.head_url || '').startsWith('https://')? currentValue.head_url  :
                                S(currentValue.head_url || '').isEmpty() ? "" : config.prefix_img_url_header + (currentValue.head_url || ''),
                            answer: answers
                        };
                    });
                }
                //自动开奖
                if(lottery_type === 0){
                    res.pkg.data = result[0][0].map(function (currentValue) {
                        answerA = {
                            answer_id: result[3][0][0].answer_id,
                            quantity: 0
                        };
                        answerB = {
                            answer_id: result[3][0][1].answer_id,
                            quantity: 0
                        };
                        if (result[3][0].length > 2){
                            answerC = {
                                answer_id: result[3][0][2].answer_id,
                                quantity: 0
                            };
                        }
                        result[2][0].map(function (p1) {
                            if (p1.user_id === currentValue.user_id){
                                if (p1.answer_id === result[3][0][0].answer_id){
                                    answerA = {
                                        answer_id: p1.answer_id,
                                        quantity: p1.quantity
                                    };
                                }else if (p1.answer_id === result[3][0][1].answer_id){
                                    answerB = {
                                        answer_id: p1.answer_id,
                                        quantity: p1.quantity
                                    };
                                }else if (result[3][0].length > 2 && p1.answer_id === result[3][0][2].answer_id){
                                    answerC = {
                                        answer_id: p1.answer_id,
                                        quantity: p1.quantity
                                    };
                                }
                            }
                        });
                        var answers = {
                            A: answerA,
                            B: answerB
                        };
                        if (result[3][0].length > 2){
                            answers = {
                                A: answerA,
                                B: answerB,
                                C: answerC
                            };
                        }
                        return {
                            user_id: currentValue.user_id,
                            user_type: user_type,
                            lottery_type: lottery_type,
                            status: status,
                            create_date: moment(currentValue.create_date).format('YYYY-MM-DD HH:mm:ss'),
                            update_date: moment(currentValue.update_date).format('YYYY-MM-DD HH:mm:ss'),
                            nickname: currentValue.nickname,
                            gender: currentValue.gender,
                            head_url: S(currentValue.head_url || '').startsWith('https://')? currentValue.head_url  :
                                S(currentValue.head_url || '').isEmpty() ? "" : config.prefix_img_url_header + (currentValue.head_url || ''),
                            answer: answers
                        };
                    });
                }
            }
        })
    }).catch(function (error) {
        res.pkg.success = false;
        res.pkg.code = error.code || -1;
        res.pkg.message = error.message;
        res.pkg.data = null;
    }).done(function () {
        res.jsonp(res.pkg);
    });
};