/**
 * Created by Administrator on 2017/5/14.
 */
/**
 * Created by Administrator on 2017/5/14.
 */
var iconv = require('iconv-lite');
var path = require('path');
var mysql = require(path.join(rootDir, './core/db')).mysql;
var redis = require(path.join(rootDir, './core/db')).redis;
var Q = require('q');
var pd = require(path.join(rootDir, './core/preconditions'));
var config = require(path.join(rootDir, './config'));
var qs = require('querystring');
var ballrediskey=config.basketball_rediskey;//缓存key

/**
 * 球赛展示信息
 * @param req
 * @param res
 * @param next
 */
module.exports = function (req, res, next) {
     Q.fcall(function () {
        pd.checkArgument(!!req.headers.match_type, '参数match_type必须设置');
         match_type = parseInt(req.headers.match_type);
        if(match_type == "2"){
            ballrediskey=config.football_rediskey;
        }
     }).then(function () {
        return Q.ninvoke(redis, 'get', ballrediskey).then(function (result) {
                    console.log("result="+result);
                    res.pkg.data =result;
                });
    }).catch(function (error) {
         res.pkg.success = false;
        res.pkg.message = error.message;
        res.pkg.code = error.code || -1;
        res.pkg.data = null;
    }).done(function () {
         res.jsonp(res.pkg);
    });
};

