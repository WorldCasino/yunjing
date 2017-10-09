/**
 * Created by Administrator on 2017/5/14.
 */
/**
 * Created by Administrator on 2017/5/14.
 */
var path = require('path');
var Q = require('q');
var pd = require(path.join(rootDir, './core/preconditions'));
var config = require(path.join(rootDir, './config'));
var mysql = require(path.join(rootDir, './core/db')).mysql;

/**
 * 球赛展示信息详情
 * @param req
 * @param res
 * @param next
 */
module.exports = function (req, res, next) {
    oddslistsql="SELECT" +
        "    a.odds_id as oddsId," +
        "    a.play_id as playId," +
        "    a.ball_number as ballNumber," +
        "    a.concede_points_show as concedePointsShow," +
        "    a.his_odds as hisOdds," +
        "    a.win_odds as winOdds," +
        "    a.tie_odds as tieOdds," +
        "    a.big_ball_odds as bigBallOdds," +
        "    a.small_ball_odds as smallBallOdds," +
        "    a.match_id as matchId  ," +
        "    b.id as concedeId," +
        "    b.is_default as isDefault " +
        "   FROM" +
        "    t_play_odds  a" +
        "    LEFT JOIN t_concede_points b on a.play_id=b.play_type and a.ball_number=b.concede_points" +
        "    WHERE play_id=? and match_id=? " +
        "    order by ball_number ";

    countsq="SELECT count(*) as oddsnumber " +
        "      FROM t_play_odds  " +
        "        WHERE  play_id=? and match_id=?";

    countconcede="SELECT " +
        "            COUNT(1) as cedenumber" +
        "        FROM t_play_odds  a LEFT JOIN t_concede_points b on a.play_id=b.play_type and a.ball_number=b.concede_points"+
        "        WHERE  play_id=? and match_id=?  and b.is_default=1 ";

    Q.fcall(function () {
        pd.checkArgument(!!req.query.match_id, '参数match_id必须设置');
        match_id=req.query.match_id;
        return Q.ninvoke(mysql, 'query', {
            sql: "SELECT tm.match_id as matchId,tm.day_date as dayDate,tm.day_time as dayTime,tm.day_week as dayWeek,"+
                "date_format(tm.open_time , '%Y-%m-%d %H:%i:%s')as openTime,date_format(tm.settle_time , '%Y-%m-%d %H:%i:%s') as settleTime,"+
                "date_format(tm.lock_time , '%Y-%m-%d %H:%i:%s') as lockTime,tm.title,tm.match_type as matchType,tm.match_type as taskType, "+
                "tm.status,IF((to_days(tm.open_time) = to_days(now())),'今天',IF((to_days(tm.open_time)-to_days(now()) = 1),'明天','')) as dayName,"+
                " tm.home_team_id as homeTeamId,ht.team_logo as homeTeamLogo,ht.team_name as homeTeamName,tm.home_score as homeScore,"+
                " tm.away_team_id as awayTeamId,atm.team_logo AS awayTeamLogo,atm.team_name as awayTeamName,tm.away_score as awayScore "+
                " from t_matches tm  LEFT JOIN t_team ht on tm.home_team_id=ht.team_id LEFT JOIN t_team atm on atm.team_id=tm.away_team_id "+
                " WHERE tm.match_id=?",
            values: [match_id]
        }).then(function (result) {
            res.pkg.data = result[0].map(function (p1, p2, p3) {
                p1.homeTeamLogo=config.prefix_img_url_team+ p1.homeTeamLogo;
                p1.awayTeamLogo=config.prefix_img_url_team+ p1.awayTeamLogo;
                return p1;
            });
        }).catch(function (error) {
            console.log(error.message);
        });
        //标准盘
      }).then(function () {
        return Q.ninvoke(mysql, 'query', {
            sql:countsq,
            values: [1,match_id]
        }).then(function (result) {
            result[0].map(function (p1, p2, p3) {
                if(p1.oddsnumber == 0){
                    match_id=0;
                }
            });
        });
    }).then(function () {
        return Q.ninvoke(mysql, 'query', {
            sql: oddslistsql,
            values: [1,match_id]
        }).then(function (result) {
            res.pkg.data=res.pkg.data.map(function (p1, p2, p3) {
                    p1.standardPlate=result[0];
                return p1;
            });
        }).then(function () {
            return Q.ninvoke(mysql, 'query', {
                sql: countconcede,
                values: [1,match_id]
            }).then(function (result1) {
                result1[0].map(function (p11, p21, p31) {
                    if(p11.cedenumber == 0){
                        res.pkg.data=res.pkg.data.map(function (p1, p2, p3) {
                            p1.ballSize[0].isDefault=1;
                            return p1;
                        });
                    }
                });
            })
        });
        //大小球
     }).then(function () {
        return Q.ninvoke(mysql, 'query', {
            sql: countsq,
            values: [3,match_id]
        }).then(function (result) {
            result[0].map(function (p1, p2, p3) {
                if(p1.oddsnumber == 0){
                    match_id=0;
                }
            });
        });
    }).then(function () {
        return Q.ninvoke(mysql, 'query', {
            sql: oddslistsql,
            values: [3,match_id]
        }).then(function (result) {
            res.pkg.data=res.pkg.data.map(function (p1, p2, p3) {
                p1.ballSize=result[0];
                return p1;
            });
        }).then(function () {
            return Q.ninvoke(mysql, 'query', {
                sql: countconcede,
                values: [3,match_id]
            }).then(function (result1) {
                result1[0].map(function (p11, p21, p31) {
                    if(p11.cedenumber == 0){
                        res.pkg.data=res.pkg.data.map(function (p1, p2, p3) {
                            p1.ballSize[0].isDefault=1;
                            return p1;
                        });
                    }
                });
            })
        });
        //让球
    }).then(function () {
        return Q.ninvoke(mysql, 'query', {
            sql: oddslistsql,
            values: [2,match_id]
        }).then(function (result) {
            result[0].map(function (p1, p2, p3) {
                if(p1.oddsnumber == 0){
                    match_id=0;
                }
            });
        });
    }).then(function () {
        return Q.ninvoke(mysql, 'query', {
            sql: oddslistsql,
            values: [2,match_id]
        }).then(function (result) {
            res.pkg.data=res.pkg.data.map(function (p1, p2, p3) {
                p1.letTheBall=result[0]
                return p1;
            });
        }).then(function () {
            return Q.ninvoke(mysql, 'query', {
                sql: countconcede,
                values: [2,match_id]
            }).then(function (result1) {
                result1[0].map(function (p11, p21, p31) {
                    if(p11.cedenumber == 0){
                        res.pkg.data=res.pkg.data.map(function (p1, p2, p3) {
                            p1.ballSize[0].isDefault=1;
                            return p1;
                        });
                    }
                });
            })
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

