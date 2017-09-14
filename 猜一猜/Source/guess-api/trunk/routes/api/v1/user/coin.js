/**
 * Created by Administrator on 2017/4/24 0024.
 */
var path = require('path');
var mysql = require(path.join(rootDir, './core/db')).mysql;
var Q = require('q');
var moment = require('moment');
var pd = require(path.join(rootDir,'./core/preconditions'));
/**
 * 个人资料
 * @param req
 * req.headers.user_id : 个人的user id，即t_user_account  user id
 * req.query.flag : 判别金币金豆的查询条件1：查询金币 2：查询金豆
 * @param res
 * @param next
 */
module.exports = function (req,res,next) {
    // var flag = parseInt(req.headers.flag);
    var flag = parseInt(req.query.flag);
    //只查询金币
    var typeStr = '';
    if(flag === 1){
        typeStr = " and ta.coin_type = 0 ";
    }else if(flag === 2){//只查询金豆
        typeStr = " and ta.coin_type = 1 ";
    }
    Q.fcall(function () {
        var id = req.headers.user_id;

        if(!id){
            var error = new Error('查询用户id不能为空');
            error.code = 1001;
            throw error;
        }

        return Q.ninvoke(mysql,'query',{
            sql:'SELECT user_id, coin_balance, coin_expend, coin_income, coin_locked ' +
            'FROM t_user_account ta ' +
            'WHERE user_id = ? ' + typeStr,
            values:[id]
        }).then(function (result) {
            //pd.checkArgument(result[0].length === 1 ,'用户不存在');
            res.pkg.data = result[0][0];
            return res.pkg.data;
        });
    }).then(function (result) {
        // 充值明细
        var id = req.headers.user_id;
        /**
         * 0：金币明细，1：今日盈亏
         * @type {Number}
         */
        var queryType = parseInt(req.query.type || 0),
            whereStr = '';

        // 收支来源 （0：充值金币 1：充值送金币 2：竞猜收入 3：竞猜下注 4：商品兑换 5：发布竞猜盈利 6：发布竞猜赔付 7：新用户注册奖励 8：登录奖励）
        whereStr = queryType === 0 ? '' : ' and TO_DAYS(tad.create_date) = TO_DAYS(now()) ' +
            ' and from_type != 0 and from_type != 1 and from_type != 4 and from_type != 7 and from_type != 8 ';

        return Q.ninvoke(mysql,'query',{
            /*sql:'SELECT uad_id, coins, from_type, create_date ' +
            ' FROM t_user_account_detail left' +
            ' WHERE is_delete = 0 and user_id = ? and (user_type = 0 or user_type = 1)' +
            whereStr +
            ' ORDER BY uad_id DESC ',*/
            sql:'SELECT tad.uad_id, tad.coins, tad.from_type, tad.create_date, ta.coin_type ' +
            ' FROM t_user_account_detail tad LEFT JOIN t_user_account ta ON tad.account_id = ta.account_id ' +
            ' WHERE tad.is_delete = 0 and tad.user_id = ? '+ typeStr +
            whereStr +
            ' ORDER BY tad.uad_id DESC ',
            values:[id]
        }).then(function (result) {
            //pd.checkArgument(result[0].length === 1 ,'用户不存在');
            //res.pkg.data = result[0][0];
            //return res.pkg.data;
            var water = result[0];
            var group = water.map(function (p1, p2, p3) {
                p1.create_date = moment(p1.create_date).format('YYYY-MM-DD HH:mm');
                return p1;
            }).reduce(function (p1, p2, p3, p4) {
                if (!(moment(p2.create_date).format('YYYY-MM') in p1)) {
                    p1[moment(p2.create_date).format('YYYY-MM')] = [];
                }
                p1[moment(p2.create_date).format('YYYY-MM')].push(p2);
                return p1;
            },{});
            var array = [];
            for(var key in group){
                array.push(group[key]);
            }

            res.pkg.data.water = array;
            return res.pkg.data;

            // var water = [];
            // for(var i = 0;i<10;i++){
            //     water.push({
            //         id:i,
            //         amount:parseInt(Math.random()*100),
            //         type:parseInt(Math.random()*10),
            //         time:moment().add(parseInt(i/3),'month').format('YYYY-MM-DD HH:mm')
            //     });
            // }
            // var group = water.reduce(function (p1, p2, p3, p4) {
            //     if (!(moment(p2.time).format('YYYY-MM') in p1)) {
            //         p1[moment(p2.time).format('YYYY-MM')] = [];
            //     }
            //     p1[moment(p2.time).format('YYYY-MM')].push(p2);
            //     return p1;
            // },{});
        });

    }).catch(function (error) {
        res.pkg.success = false;
        res.pkg.code = error.code || -1;
        res.pkg.message = error.message;
        res.pkg.data = null;
    }).done(function () {
        res.jsonp(res.pkg);
    });
};