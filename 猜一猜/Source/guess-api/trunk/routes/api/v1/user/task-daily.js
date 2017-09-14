/**
 * Created by wurq on 2017/8/8.
 */
var path = require('path');
var mysql = require(path.join(rootDir, './core/db')).mysql;
var redisPub = require(path.join(rootDir, './core/db')).redisPub;
var Q = require('q');
var moment = require('moment');
var pd = require(path.join(rootDir, './core/preconditions'));
var S = require('string');
var config = require(path.join(rootDir, './config'));
/**
 * 每日任务与成长任务的查询接口
 * @param req
 * req.headers.user_id : 个人的user id，即t_user_account  user id
 * @param res
 * @param next
 */
module.exports = function (req,res,next) {
    var user_id = req.headers.user_id;
    var active_type = req.body.active_type;

    //pd.checkArgument(!!user_id,'用户id不能为空',1001);
    pd.checkArgument(!!active_type, '用户active_type不能为空',1001);

    Q.fcall(function () {

        res.pkg.data={
            'coin_balance':0,
            'today_liveness':0,
            'tasks':[]
        }

        //每日任务数据权提供，成长任务数据提供提供可领取奖励的任务，无则提供下一个任务
        if(active_type==0){
            return Q.ninvoke(mysql, 'query', {
                sql :  "select a.active_id,a.active_type,a.title,a.content,a.limit,IFNULL(b.total,0) total,a.coin_type,a.reward_coins,a.reward_liveness,IFNULL(b.received,0) received,a.operate_type "+
                "from t_actives a "+
                "left join t_active_daily b on a.active_id=b.active_id AND (b.user_id=? or b.user_id is null) "+
                "GROUP BY a.active_type,a.operate_type,received,a.active_id HAVING a.active_type in (0,2) ",
                values: [user_id, active_type]
            });
        }else if(active_type==1){
            return Q.ninvoke(mysql, 'query', {
                sql :  "select a.active_id,a.active_type,a.title,a.content,a.limit,IFNULL(b.total,0) total,a.coin_type,a.reward_coins,a.reward_liveness,IFNULL(b.received,0) received,a.operate_type "+
                "from t_actives a "+
                "left join t_active_daily b on a.active_id=b.active_id AND (b.user_id=? or b.user_id is null) "+
                "GROUP BY a.active_type,a.operate_type,received HAVING a.active_type=1 and (received=0 or received is null)",
                values: [user_id, active_type]
            });
        }

    }).then(function (result) {
        res.pkg.data.tasks=result[0];
        return Q.ninvoke(mysql, 'query', {
            sql: 'select IFNULL(SUM(IFNULL(receive_liveness,0)),0) today_liveness '+
            'from t_active_daily  '+
            'where user_id=? and received=1',
            values: user_id
        }).then(function (result) {
            result[0].map(function (currentValue) {
                res.pkg.data.today_liveness=currentValue.today_liveness
                return res.pkg.data;
            })
        })
    }).then(function () {
        return Q.ninvoke(mysql, 'query', {
            sql: 'select coin_balance from t_user_account where user_id=? and coin_type=1',
            values: user_id
        }).then(function (result) {
            result[0].map(function (currentValue) {
                res.pkg.data.coin_balance= currentValue.coin_balance;
                return res.pkg.data;
            })
        })
    }).catch(function (error) {
        res.pkg.success = false;
        res.pkg.code = error.code || -1;
        res.pkg.message = error.message;
        res.pkg.data = null;
    }).done(function () {
        res.jsonp(res.pkg);
    });

}
