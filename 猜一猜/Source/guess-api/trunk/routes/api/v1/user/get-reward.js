/**
 * Created by wurq on 2017/8/8.
 */
var path = require('path');
var mysql = require(path.join(rootDir, './core/db')).mysql;
var Q = require('q');
var moment = require('moment');
var pd = require(path.join(rootDir, './core/preconditions'));
var S = require('string');
var config = require(path.join(rootDir, './config'));
/**
 * 领取奖励（每日任务与成长任务）
 * @param req
 * req.headers.user_id : 个人的user id，即t_user_account  user id
 * req.headers.task_id : 任务id
 * @param res
 * @param next
 */
module.exports = function (req,res,next) {
    Q.fcall(function () {

        var params = {};

        var user_id = req.headers.user_id;
        var active_id = req.body.active_id;

        var account_id=0,
            coin_type=0,
            reward_coins=0,
            reward_liveness=0;

        pd.checkArgument(!!user_id,'用户id不能为空',1001);
        pd.checkArgument(!!active_id,'任务id不能为空',1001);

        return Q.fcall(function () {
            return Q.ninvoke(mysql, 'query', {
                sql: 'select b.sch_id,a.active_id,a.active_type,a.title,a.content,a.limit,IFNULL(b.total,0) total,a.coin_type,a.reward_coins,a.reward_liveness,IFNULL(b.received,0) received '+
                    'from t_actives a '+
                    'left join t_active_daily b on a.active_id=b.active_id AND (b.user_id=? or b.user_id is null) '+
                    'where a.active_id=?',
                values: [user_id,active_id]
            }).then(function (result) {
                // params =result[0].length === 1 ? result[0][0]:null;
                params =result[0][0];

                reward_coins=params.reward_coins;
                coin_type=params.coin_type;
                reward_liveness=params.reward_liveness;
                //未达到领取要求
                //if(params.active_type!=2 && (params.total<params.limit || params.received===1)){
                if(params.total<params.limit || params.received===1){
                        return false;
                }

                return Q.ninvoke(mysql, 'query', {
                    sql: 'update t_active_daily set received=1,receive_time=sysdate() where active_id=? and user_id=?',
                    values: [active_id,user_id]
                }).then(function () {
                    //更新宝箱进度
                    return Q.ninvoke(mysql, 'query', {
                        sql: 'update t_active_daily set total=total+?,receive_time=sysdate() where active_type=2 and user_id=?',
                        values: [reward_liveness, user_id]
                    })
                }).then(function () {
                    //查询用户金币（金豆）账户信息
                    return Q.ninvoke(mysql, 'query', {
                        sql: 'select account_id,coin_balance,coin_income from t_user_account where user_id=? and coin_type=?',
                        values: [user_id,coin_type]
                    }).then(function (result) {
                        params =result[0][0];
                        account_id=params.account_id;
                        // 奖励加入用户账户表
                        return Q.ninvoke(mysql, 'query', {
                            sql: 'update t_user_account SET coin_balance=coin_balance+? ,coin_income=coin_income+? where user_id=? and coin_type=?',
                            values: [reward_coins, reward_coins, user_id,coin_type]
                        })
                    })
                }).then(function () {
                    // 奖励明细加入用户账户详情表t_user_account_detail
                    var kvp = {
                        account_id:account_id,
                        user_id: user_id,
                        coins:reward_coins,
                        from_type:9,
                        create_by:user_id,
                        update_by:user_id
                    };
                    return Q.ninvoke(mysql, 'query', {
                        sql: 'INSERT INTO t_user_account_detail SET ?',
                        values: kvp
                    })
                })
            })
        })
    }).then(function (success) {
        pd.checkState(success,'领取失败');
        res.pkg.message = '领取成功';
        res.pkg.data = true;
    }).catch(function (error) {
        res.pkg.success = false;
        res.pkg.code = error.code || -1;
        res.pkg.message = error.message;
        res.pkg.data = null;
    }).done(function () {
        res.jsonp(res.pkg);
    });

}
