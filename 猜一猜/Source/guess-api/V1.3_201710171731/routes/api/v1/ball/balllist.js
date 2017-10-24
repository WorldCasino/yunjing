/**
 * Created by Administrator on 2017/5/14.
 */
/**
 * Created by Administrator on 2017/5/14.
 */
var path = require('path');
var redisBall = require(path.join(rootDir, './core/db')).redisBall;
var Q = require('q');
var pd = require(path.join(rootDir, './core/preconditions'));
var config = require(path.join(rootDir, './config'));

/**
 * 球赛展示信息
 * @param req
 * @param res
 * @param next
 */
module.exports = function (req, res, next) {
    Q.fcall(function () {
        pd.checkArgument(!!req.query.match_type, '参数match_type必须设置');
        pd.checkArgument(!!req.query.page, '参数page必须设置');
      }).then(function () {
                var match_type_ = req.query.match_type;
                var ballrediskey=config.football_rediskey;
                if(match_type_ == "2"){
                    ballrediskey=config.basketball_rediskey;
                }
                var page_=req.query.page;
                var start=(page_-1)*10+'';
                var end=(page_*10-1)+'';
                // console.log("ballrediskey="+ballrediskey+",start="+start+",end="+end);
                return Q.ninvoke(redisBall, 'lrange', ballrediskey,start,end).then(function (result) {
                        res.pkg.data = result.map(function(i){
                            console.log(i)
                            return JSON.parse(i);
                        });
                    }).catch(function (error) {
                            //redis出错先不处理
                        console.log("catch============================="+error.toString());
                        throw new Error(error);
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

