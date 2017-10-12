/**
 * Created by Administrator on 2017/4/24 0024.
 */
var path = require('path');
var mysql = require(path.join(rootDir, './core/db')).mysql;
var Q = require('q');
var moment = require('moment');
var pd = require(path.join(rootDir,'./core/preconditions'));
var config = require(path.join(rootDir, './config'));

var token = require(path.join(rootDir, './core/token'));
var S =  require('string');
/**
 * 个人资料
 * @param req
 * req.headers.user_id : 个人的user id，即t_user_account  user id
 * @param res
 * @param next
 */
module.exports = function (req,res,next) {
    var id = req.headers.query_user_id || req.headers.user_id;
    Q.fcall(function () {
        // token集中处理，不需要在这里进行@阳光
        // if(!id){
        //     token.validate(req.headers.token).then(function (validation) {
        //         if(validation){
        //             id = token.getUserId(req.headers.token);
        //         }else{
        //             var error = new Error('登录超时，请重新登录');
        //             error.code = 1000;
        //             throw error;
        //         }
        //     }).catch(function (err) {
        //         console.log('validate token error')
        //
        //         var error = new Error('Token无效');
        //         error.code = 1000;
        //         throw error;
        //     });
        //
        // }
        if(!id){
            var error = new Error('查询用户id为空或token无效');
            error.code = 1001;
            throw error;
        }
        // return Q.ninvoke(mysql,'query',{
        //     sql:'SELECT ac.user_id, ac.task_count, ac.task_join, usr.nickname, usr.head_url, usr.gender ' +
        //     'FROM t_user_account AS ac ' +
        //     'LEFT JOIN m_users AS usr ON ac.user_id = usr.user_id ' +
        //     'WHERE ac.user_id = ?',
        //     values:[id]
        // }).then(function () {
        //     res.pkg.data = result[0];
        //     return res.pkg.data;
        // });

        return Q.ninvoke(mysql,'query',{
            sql:'SELECT usr.user_id, usr.user_type, usr.nickname, usr.head_url, usr.gender, usr.phonenumber, usr.isablebean, usr.default_pic, usr.ispersonal, usr.coin_first, usr.bet_first, usr.bet_tip ' +
            'FROM m_users AS usr ' +
            'WHERE usr.user_id = ?',
            values:[id]
        }).then(function (result) {
            pd.checkArgument(result[0].length === 1 ,'用户不存在',1000);
            res.pkg.data = result[0][0];
            //res.pkg.data.head_url = config.prefix_img_url_header + (res.pkg.data.head_url || '');
            res.pkg.data.head_url = S(res.pkg.data.head_url || '').startsWith('https://')? res.pkg.data.head_url  :
                S(res.pkg.data.head_url || '').isEmpty() ? "" : config.prefix_img_url_header + (res.pkg.data.head_url || '');

            return res.pkg.data;
        });

    }).then(function () {
        return Q.ninvoke(mysql,'query',{
            sql:'SELECT * ' +
            'FROM t_user_account ' +
            'WHERE user_id = ? ',
            values:[id]
        }).then(function (result) {
            if (result[0].length === 1){
                return Q.ninvoke(mysql, 'query', {
                    sql: 'INSERT INTO t_user_account SET ? ',
                    values: {
                        user_id: id,
                        task_count: result[0][0].task_count,
                        task_join: result[0][0].task_join,
                        coin_type: 1,
                        coin_balance: 0,
                        coin_income: 0,
                        coin_expend: 0,
                        coin_locked: 0,
                        recharge_amount: 0,
                        member_points: result[0][0].member_points,
                        create_by: result[0][0].create_by,
                        create_date: result[0][0].create_date,
                        update_by: result[0][0].update_by,
                        update_date: result[0][0].update_date,
                        is_delete: 0
                    }
                })
            }
        });
    }).then(function () {
        // 金币结余
        //res.pkg.data = result[0];
        return Q.ninvoke(mysql,'query',{
            sql:'SELECT coin_balance, coin_locked ' +
            'FROM t_user_account ' +
            'WHERE user_id = ? and coin_type = 0',
            values:[id]
        }).then(function (result) {
            res.pkg.data.coin_balance = result[0][0].coin_balance || 0;
            res.pkg.data.avalible_coin = result[0][0].coin_balance - result[0][0].coin_locked || 0;
            return res.pkg.data;
        });
    }).then(function () {
        // 金豆结余
        //res.pkg.data = result[0];
        return Q.ninvoke(mysql,'query',{
            sql:'SELECT coin_balance ' +
            'FROM t_user_account ' +
            'WHERE user_id = ? and coin_type = 1',
            values:[id]
        }).then(function (result) {
            res.pkg.data.bean_balance = result[0][0].coin_balance || 0;
            return res.pkg.data;
        });
    }).then(function () {
        // 参与竞猜数
        return Q.ninvoke(mysql,'query',{
            sql:'select user_id ,count(1) join_count '+
                'from ('+
                '      select distinct user_id,task_id from t_task_orders t where user_id = ? '+
                ' ) t',
            values:[id]
        }).then(function (result) {
            res.pkg.data.join_count = result[0][0].join_count || 0;
            return res.pkg.data;
        });
    }).then(function () {
        // 今日盈亏
        // 收支来源 （0：充值金币 1：充值送金币 2：竞猜收入 3：竞猜下注 4：商品兑换 5：发布竞猜盈利 6：发布竞猜赔付 7：新用户注册奖励 8：登录奖励）

        //查询金币
        return Q.ninvoke(mysql,'query',{
            sql:'SELECT sum(coins * (case from_type when 2 then 1 when 5 then 1 when 9 then 1 else -1 end)) as profit ' +
            ' FROM t_user_account_detail tad LEFT JOIN t_user_account ta ON tad.account_id = ta.account_id ' +
            ' WHERE tad.is_delete = 0 and tad.user_id = ? and TO_DAYS(tad.create_date) = TO_DAYS(now()) '+
            'and from_type != 0 and from_type != 1 and from_type != 4 and from_type != 7 and from_type != 8 and ta.coin_type = 0 ',
            values:[id]
        }).then(function (result) {
            res.pkg.data.profit = result[0][0].profit || 0;
            return res.pkg.data;
        });

    }).then(function () {
        // 发布总数统计
        return Q.ninvoke(mysql,'query',{
            sql:'SELECT COUNT(task_id) AS cnt ' +
            'FROM t_tasks ' +
            'WHERE user_id = ?',
            values:[id]
        }).then(function (result) {
            res.pkg.data.publish_count = result[0][0].cnt;
            return res.pkg.data;
        });
    }).then(function () {
        // 按钮设置
        return Q.ninvoke(mysql, 'query', {
            sql: 'SELECT lottery_attention, bet_attention, message_attention from m_users WHERE user_id = ? ',
            values: [id]
        }).then(function (result) {
            res.pkg.data.lottery_attention = result[0][0].lottery_attention;
            res.pkg.data.bet_attention = result[0][0].bet_attention;
            res.pkg.data.message_attention = result[0][0].message_attention;
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