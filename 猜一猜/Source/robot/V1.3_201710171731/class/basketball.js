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
    const uri = 'https://www.bwin1828.com/zh-cn/sport/basketball/coupons/601600/0/0/58908/0/209/0/0/0/0/1';
    // 页面能获取几天数据
    return Q.fcall(function () {
        // https get 请求
        return https.get(uri);
    }).then(function (html) {
        const $ = cheer.load(html);
        const tables=$('table');

        tables.each(function (i,n) {
            const rows_away =cheer(n).find('tbody').find('tr[class="body top"]');
            const rows_home =cheer(n).find('tbody').find('tr[class="body bottom"]');

            //客队赔率
            rows_away.each(function (i,n) {
                // 必须使用cherr来包装n,是个BUG，后面也是一样
                var elem = cheer(n);
                const tds = elem.find('td');
                if(!cheer(tds.get(6)).attr('data-sort')){
                    return true;
                }
                const win = cheer(tds.get(6)).attr('data-sort');
                const teams = cheer(tds.get(6)).find('span').attr('data-event_description');

                var home_team_name_bwin = '';
                var away_team_name_bwin = '';
                //篮球对阵有时用v分隔有时用@
                if(teams.split(' v ').length==2){
                    away_team_name_bwin = teams.split(' v ')[0];
                    home_team_name_bwin = teams.split(' v ')[1];
                }else if(teams.split(' @ ').length==2){
                    away_team_name_bwin = teams.split(' @ ')[0];
                    home_team_name_bwin = teams.split(' @ ')[1];
                }

                //console.log([teams,win,home_team_name_bwin,away_team_name_bwin].join(' - ') );
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


                        Q.ninvoke(mysql, 'query', {
                            sql :  "select * from t_play_odds where match_id=? and play_id=1 ",
                            values: [match_id]
                        }).then(function (data) {
                            if(data[0].length==0){
                                return Q.ninvoke(mysql, 'query', {
                                    sql :  "insert into t_play_odds (match_id,play_id,ball_number,concede_points_show,win_odds,is_default) " +
                                    "values (?,1,0,0,?,0)  ",
                                    values: [match_id,win]
                                });
                            }else{
                                data[0].map(function (current) {
                                    const odds_id=current.odds_id;
                                    return Q.ninvoke(mysql, 'query', {
                                        sql :  "update t_play_odds set win_odds=? where match_id=? and play_id=1",
                                        values: [win,match_id]
                                    });
                                })
                            }

                        })
                    })

                })

            });

            setTimeout(function () {
                //避免主客队赔率分开成2条数据，所以让客队先生成，延时5秒再update主队信息
                //主队赔率
                rows_home.each(function (i,n) {
                    // 必须使用cherr来包装n,是个BUG，后面也是一样
                    var elem = cheer(n);
                    const tds = elem.find('td');
                    if(!cheer(tds.get(5)).attr('data-sort')){
                        return true;
                    }
                    const win = cheer(tds.get(5)).attr('data-sort');
                    const teams = cheer(tds.get(5)).find('span').attr('data-event_description');

                    var home_team_name_bwin = '';
                    var away_team_name_bwin = '';
                    //篮球对阵有时用v分隔有时用@
                    if(teams.split(' v ').length==2){
                        away_team_name_bwin = teams.split(' v ')[0];
                        home_team_name_bwin = teams.split(' v ')[1];
                    }else if(teams.split(' @ ').length==2){
                        away_team_name_bwin = teams.split(' @ ')[0];
                        home_team_name_bwin = teams.split(' @ ')[1];
                    }

                    //console.log([teams,win,home_team_name_bwin,away_team_name_bwin].join(' - ') );
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

                            Q.ninvoke(mysql, 'query', {
                                sql :  "select * from t_play_odds where match_id=? and play_id=1 ",
                                values: [match_id]
                            }).then(function (data) {
                                if(data[0].length==0){
                                    return Q.ninvoke(mysql, 'query', {
                                        sql :  "insert into t_play_odds (match_id,play_id,ball_number,concede_points_show,his_odds,is_default) " +
                                        "values (?,1,0,0,?,0)  ",
                                        values: [match_id,win]
                                    });
                                }else{
                                    data[0].map(function (current) {
                                        const odds_id=current.odds_id;
                                        return Q.ninvoke(mysql, 'query', {
                                            sql :  "update t_play_odds set his_odds=? where match_id=? ",
                                            values: [win,match_id]
                                        });
                                    })
                                }
                            })
                        })
                    })
                });
            },5000);
            console.log("---------------basketball-over--------------------");
        })
    }).catch(function (error) {
        console.log("-------------------------报错啦~--------------------------basketball:"+error);
    })

};