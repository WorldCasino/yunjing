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
    const uri = 'https://www.bwin1828.com/zh-cn/sport/football/coupons/100/0/0/46123/0/100/0/0/0/0/1';
    // 页面能获取几天数据
    return Q.fcall(function () {
        // https get 请求
        return https.get(uri);
    }).then(function (html) {
        // //先清空数据
        // Q.ninvoke(mysql, 'query', {
        //     sql :  "delete from t_play_odds where play_id=2 and match_id<>0 "
        // })

        const $ = cheer.load(html);
        const tables=$('table').not('.has_group_date');
        //const tables=$('table[role=grid]');
        // const tables=$("table[role='grid']") ;
        tables.each(function (i,n) {
            const rows =cheer(n).find('tbody').find('tr');

            rows.each(function (i,n) {
                // 必须使用cherr来包装n,是个BUG，后面也是一样
                var elem = cheer(n);
                const tds = elem.find('td');
                const time = cheer(tds.get(0)).attr('data-sort');
                const teams = cheer(tds.get(1)).attr('data-secondary-sort');
                const home_team = cheer(tds.get(2)).find('span').text();
                const win = cheer(tds.get(3)).attr('data-sort');
                const lose = cheer(tds.get(5)).attr('data-sort');

                //console.log([time,teams,home_team,win,lose].join(' - ') );
                const home_team_name_bwin = teams.split(' v ')[0];
                const away_team_name_bwin = teams.split(' v ')[1];

                const concede_points_show=home_team.match(/\(.+\)/)[0].replace(/\(/, '').replace(/\)/, '');
                const arr=concede_points_show.split(',');
                var ball_number=0;
                if(arr.length==1){
                    ball_number=parseFloat(arr[0]);
                }else if(arr.length==2){
                    //console.log(parseFloat(arr[0])+"+"+parseFloat(arr[1])+"="+(parseFloat(arr[0])+parseFloat(arr[1])))
                    ball_number=(parseFloat(arr[0])+parseFloat(arr[1]))/2;
                }

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
                    //查询是否有次比赛的让球赔率
                    result[0].map(function (currentValue) {
                        const match_id=currentValue.match_id;

                        if(!match_id){
                            return true;
                        }

                        //查询是否有当前赔率的数据
                        Q.ninvoke(mysql, 'query', {
                            sql :  "select * from t_play_odds where match_id=? and play_id=2 and ball_number=? ",
                            values: [match_id,ball_number]
                        }).then(function (data) {
                            if(data[0].length==0){
                                return Q.ninvoke(mysql, 'query', {
                                    sql :  "insert into t_play_odds (match_id,play_id,ball_number,concede_points_show,his_odds,win_odds,is_default) " +
                                    "values (?,2,?,?,?,?,0)  ",
                                    values: [match_id,ball_number,concede_points_show,win,lose]
                                });
                            }else{
                                data[0].map(function (current) {
                                    const odds_id=current.odds_id;
                                    return Q.ninvoke(mysql, 'query', {
                                        sql :  "update t_play_odds set his_odds=?,win_odds=?,ball_number=?,concede_points_show=? where odds_id=? ",
                                        values: [win,lose,ball_number,concede_points_show,odds_id]
                                    });
                                })
                            }

                        })
                    })

                })

            });
        })

        console.log("---------------football2-over--------------------");
    }).catch(function (error) {
        console.log("-------------------------报错啦~--------------------------")
    })

};