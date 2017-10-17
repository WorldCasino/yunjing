/**
 * Created by Administrator on 2017/9/19 0019.
 */
var path = require('path');
const cheer = require('cheerio');
const https = require('../wrap/httpspromise');
const Q =require('q');
var moment = require('moment');
var mysql = require('../core/db').mysql;
/**
 * 获取足球数据。
 */
module.exports.get = function () {
    // 数据页面
    const uri = 'https://www.bwin1828.com/zh-cn/sport/football/%E4%B8%AD%E5%9B%BD%E8%B6%85%E7%BA%A7%E8%81%94%E8%B5%9B/coupons/100/14871210/0/62607/0/PE/0/0/0/0/1';
    // 页面能获取几天数据
    return Q.fcall(function () {
        // https get 请求
        return https.get(uri);
    }).then(function (html) {
        const $ = cheer.load(html);
        const tables=$('#three_way_outright_coupon-markets').eq(0).find('table').not('.has_group_date')

        tables.each(function (i,n) {
            const rows =cheer(n).find('tbody').find('tr');

            rows.each(function (i,n) {
                // 必须使用cherr来包装n,是个BUG，后面也是一样
                var elem = cheer(n);
                const tds = elem.find('td');
                const time = cheer(tds.get(0)).attr('data-sort');
                const teams = cheer(tds.get(1)).attr('data-secondary-sort');
                const win = cheer(tds.get(2)).attr('data-sort');
                const draw = cheer(tds.get(3)).attr('data-sort');
                const lose = cheer(tds.get(4)).attr('data-sort');


                //console.log([time,teams,win,draw,lose].join(' - ') );
                const home_team_name_bwin = teams.split(' v ')[0];
                const away_team_name_bwin = teams.split(' v ')[1];

                //获取比赛match_id
                Q.fcall(function () {
                    return Q.ninvoke(mysql, 'query', {
                        sql :  "select match_id from t_matches a "+
                        "left join t_team b on a.home_team_id=b.team_id "+
                        "left join t_team c on a.away_team_id=c.team_id "+
                        "where b.team_name_bwin=? and c.team_name_bwin=?",
                        values: [home_team_name_bwin, away_team_name_bwin]
                    });
                }).then(function (result) {
                    //查询是否有次比赛的标准盘赔率
                    result[0].map(function (currentValue) {
                        const match_id=currentValue.match_id;
                        if(!match_id){
                            return true;
                        }

                        if(match_id==473){
                            console.log(match_id);
                        }

                        Q.ninvoke(mysql, 'query', {
                            sql :  "select * from t_play_odds where match_id=? and play_id=1 ",
                            values: [match_id]
                        }).then(function (data) {
                            if(data[0].length==0){
                                return Q.ninvoke(mysql, 'query', {
                                    sql :  "insert into t_play_odds (match_id,play_id,ball_number,concede_points_show,his_odds,win_odds,tie_odds,is_default) " +
                                    "values (?,1,0,0,?,?,?,1)  ",
                                    values: [match_id,win,lose,draw]
                                });
                            }else{
                                data[0].map(function (current) {
                                    const odds_id=current.odds_id;
                                    return Q.ninvoke(mysql, 'query', {
                                        sql :  "update t_play_odds set his_odds=?,win_odds=?,tie_odds=? where odds_id=? ",
                                        values: [win,lose,draw,odds_id]
                                    });
                                })
                            }
                        })
                    })
                })
            });
        })

        console.log("---------------football4-over--------------------");
    }).catch(function (error) {
        console.log("-------------------------报错啦~--------------------------")
    })

};