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
                sql:'select user_type FROM m_users usr LEFT JOIN t_tasks t ON usr.user_id = t.user_id WHERE task_id = ? ',
                values:[id]
            }),
            Q.ninvoke(mysql,'query',{
                sql:'SELECT lottery_result FROM t_task_lottery_logs WHERE is_success = 1 and task_id = ? ',
                values:[id]
            }),
            Q.ninvoke(mysql,'query',{
                sql:'SELECT ord.user_id, ord.answer_id, ord.coin_type, ord.quantity, ord.create_date, ord.update_date, usr.nickname, usr.gender, usr.head_url ' +
                'FROM ( ' +
                '   SELECT user_id, answer_id, coin_type, SUM(quantity) AS quantity, MAX(create_date) AS create_date, MAX(update_date) AS update_date ' +
                '   FROM t_task_orders WHERE task_id = ? GROUP BY user_id , answer_id, coin_type ) ' +
                'AS ord ' +
                'LEFT JOIN m_users AS usr ON ord.user_id = usr.user_id ORDER BY answer_id ',
                values:[id]
            }),
            Q.ninvoke(mysql,'query',{
                sql:'select answer_id, is_right, odds FROM t_task_answers WHERE task_id = ? ORDER BY answer_id',
                values:[id]
            })
        ]).then(function (result) {
            var lottery_type = parseInt(result[1][0][0].lottery_type),
                status = parseInt(result[1][0][0].task_status),
                user_type = parseInt(result[2][0][0].user_type);
            //已开奖
            if(status === 30){
                var lotteryVo = JSON.parse(result[3][0][0].lottery_result);
                res.pkg.data = result[0][0].map(function (currentValue) {
                    var abc = 65;
                    var bettingList = [];
                    result[5][0].map(function (p1) {
                        var coinQty = 0;
                        var benaQty = 0;
                        result[4][0].map(function (p2) {
                            if (currentValue.user_id == p2.user_id) {
                                if (p1.answer_id == p2.answer_id) {
                                    if (p2.coin_type == 0)
                                        coinQty += p2.quantity;
                                    else
                                        benaQty += p2.quantity;
                                }
                            }
                        });
                        bettingList.push({
                            abc: String.fromCharCode(abc),
                            coinsQty: coinQty,
                            beansQty: benaQty
                        });
                        abc++;
                    });
                    //var bettingList = [];
                    var coins = 0;
                    lotteryVo.playerVoList.map(function (p1) {
                        if (currentValue.user_id === p1.userId ){
                            bettingVo = p1.bettingVoList;
                            var coinsRight = 0;
                            var coinsWrong = 0;
                            if (lotteryVo.lotteryType == 2){
                                for (var i = 0; i < bettingVo.length; i++ ){
                                    coins += (bettingVo[i].coins + bettingVo[i].beans) ;
                                }
                            }else {
                                for (var j = 0; j < bettingVo.length; j++ ){
                                    if (bettingVo[j].right)
                                        coinsRight = bettingVo[j].coins + bettingVo[j].beans - (bettingVo[j].coinsQty + bettingVo[j].beansQty)*lotteryVo.salePrice;
                                    if (!bettingVo[j].right)
                                        coinsWrong = bettingVo[j].coins + bettingVo[j].beans;
                                }
                                coins = coinsRight - coinsWrong;
                                coins = Math.floor(coins*10)/10;
                            }
                        }
                    });

                    return {
                        user_id: currentValue.user_id,
                        user_type: user_type,
                        lottery_type: lottery_type,
                        status: status,
                        coins: coins,
                        create_date: moment(currentValue.create_date).format('YYYY-MM-DD HH:mm:ss'),
                        update_date: moment(currentValue.update_date).format('YYYY-MM-DD HH:mm:ss'),
                        nickname: currentValue.nickname,
                        gender: currentValue.gender,
                        head_url: S(currentValue.head_url || '').startsWith('https://')? currentValue.head_url  :
                            S(currentValue.head_url || '').isEmpty() ? "" : config.prefix_img_url_header + (currentValue.head_url || ''),
                        bettingVoList: bettingList
                    };

                });
            }else{
                //未开奖
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
                                S(currentValue.head_url || '').isEmpty() ? "" : config.prefix_img_url_header + (currentValue.head_url || '')
                        };
                    });
                    //手动开奖、平台发布                                //自动开奖
                }else if (lottery_type === 1 && user_type === 0 || lottery_type === 0) {
                    res.pkg.data = result[0][0].map(function (currentValue) {
                        var abc = 65;
                        var bettingList = [];
                        result[5][0].map(function (p1) {
                            var coinQty = 0;
                            var benaQty = 0;
                            result[4][0].map(function (p2) {
                                if (currentValue.user_id == p2.user_id) {
                                    if (p1.answer_id == p2.answer_id) {
                                        if (p2.coin_type == 0)
                                            coinQty += p2.quantity;
                                        else
                                            benaQty += p2.quantity;
                                    }
                                }
                            });
                            bettingList.push({
                                abc: String.fromCharCode(abc),
                                coinsQty: coinQty,
                                beansQty: benaQty
                            });
                            abc++;
                        });

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
                            bettingVoList: bettingList
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