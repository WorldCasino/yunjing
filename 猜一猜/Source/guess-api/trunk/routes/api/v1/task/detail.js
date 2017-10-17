/**
 * Created by Administrator on 2017/5/13.
 */
var path = require('path');
var mysql = require(path.join(rootDir, './core/db')).mysql;
var Q = require('q');
var moment = require('moment');
var pd = require(path.join(rootDir, './core/preconditions'));
var redis = require(path.join(rootDir, './core/db')).redis;
var config = require(path.join(rootDir, './config'));
var S = require('string');

module.exports = function (req, res, next) {
    return Q.fcall(function () {
        // 处理任务基本信息查询
        var id = pd.checkNotNull(req.query.id, '竞猜项目ID不能为空', 1001);
        return Q.ninvoke(mysql, 'query', {
            sql: 'SELECT ' +
            't.task_id, ' +
            't.task_type, ' +
            't.match_id, ' +
            't.match_type, ' +
            't.play_type, ' +
            't.concede_points_show, ' +
            'm.title, ' +
            'm.home_score, ' +
            'm.away_score, ' +
            'm.open_time, ' +
            't.user_id, ' +
            't.task_content, ' +
            't.sale_price, ' +
            't.quantity, ' +
            't.task_status, ' +
            't.create_date, ' +
            't.settle_time, ' +
            't.update_date, ' +
            't.hot, ' +
            't.personal, ' +
            't.like_peas, ' +
            't.lottery_type, ' +
            't.lock_time, ' +
            't.parent_id, ' +
            't.is_recommend, ' +
            'u.user_name, ' +
            'u.user_type, ' +
            'u.nickname, ' +
            'u.gender, ' +
            'u.head_url, ' +
            'p.user_id as parent_user_id, ' +
            'pu.user_type as parent_type, ' +
            'pu.nickname as parent_nickname ' +
            'FROM t_tasks AS t ' +
            'LEFT JOIN m_users AS u ON t.user_id = u.user_id ' +
            'LEFT JOIN t_tasks AS p ON t.parent_id = p.task_id ' +
            'LEFT JOIN m_users AS pu on pu.user_id = p.user_id ' +
            'LEFT JOIN t_matches AS m on t.match_id = m.match_id ' +
            'WHERE t.task_id = ? AND t.is_delete = 0',
            values: [id]
        }).then(function (result){
            pd.checkState(result[0].length === 1,'竞猜项目不存在');

            var v = result[0][0];
            var parentId = v.parent_id;
            var lockTime = v.lock_time;
            if (lockTime != null){
                lockTime = moment(new Date(lockTime)).format('YYYY-MM-DD HH:mm:ss');
            }
            res.pkg.data = {
                task_id: v.task_id,
                task_type: v.task_type,
                match_id: v.match_id,
                match_type: v.match_type,
                play_type: v.play_type,
                concede_points_show: v.concede_points_show,
                score: v.home_score+'-'+v.away_score,
                // home_score: v.home_score,
                // visit_score: v.away_score,
                title: v.title,
                user_id: v.user_id,
                task_content: v.task_content,
                sale_price: parseInt(v.sale_price),
                quantity: v.quantity,
                task_status: v.task_status,
                is_recommend: v.is_recommend,
                hot: !!parseInt(v.hot),
                personal: parseInt(v.personal),//...  0:普通发布  1:私人发布
                like_peas: parseInt(v.like_peas),//...  0:不接受金豆  1：接受金豆
                lottery_type: parseInt(v.lottery_type),//...  0:自动开奖  1:手动开奖
                lock_time: lockTime,//  下注截止时间
                create_date: moment(v.create_date).format('YYYY-MM-DD HH:mm:ss'),
                settle_time: moment(v.settle_time).format('YYYY-MM-DD HH:mm:ss'),
                update_date: moment(v.update_date).format('YYYY-MM-DD HH:mm:ss'),
                open_time: moment(v.open_time).format('YYYY-MM-DD HH:mm:ss'),
                user: {
                    name: v.user_name,
                    type: v.user_type,
                    nick: v.nickname,
                    gender: v.gender,
                    head_url: S(v.head_url || '').startsWith('https://')? v.head_url :
                        ( S(v.head_url || '').isEmpty() ? "" : config.prefix_img_url_header + (v.head_url || '') )
                },
                parent: {//1.null判断是否转发过  2.获取最原始转发的用户类型
                    parentUserId: v.parent_user_id,
                    parentType: v.parent_type,
                    parnetNickName: v.parent_nickname
                }
            };
            return id;
        });
    }).then(function (id) {
        // 处理普通任务或主球的图片与比赛队伍显示
        if(res.pkg.data.task_type === 0 || res.pkg.data.task_type === 3){
            // 查询图片-普通任务
            return Q.ninvoke(mysql, 'query', {
                // 查询图片
                sql: 'SELECT pic_id, task_id, pic_url, pic_type FROM t_task_pictures WHERE task_id = ? ORDER BY task_id,pic_type DESC',
                values: [id]
            }).then(function (result) {
                res.pkg.data.pics = result[0].map(function (p1, p2, p3) {
                    return {
                        pic_id: p1.pic_id,
                        pic_url: config.prefix_img_url_task + p1.pic_url
                    };
                });
                return id;
            });
        }else{
            // 查询足球
            return Q.ninvoke(mysql, 'query', {
                // 查询足球队伍
                sql: 'SELECT tfb_id, task_id, team_name, court_type,team_logo FROM t_task_football WHERE task_id = ?',
                values: [id]
            }).then(function (result) {
                res.pkg.data.teams = result[0].map(function (p1, p2, p3) {
                    return {
                        tfb_id: p1.tfb_id,
                        team_name: p1.team_name,
                        team_logo: p1.team_logo,
                        court_type: p1.court_type
                    };
                });
                return id;
            });
        }
        //return res.pkg.data.task_type === 0 ? picQuery : footballQuery;
    }).then(function (taskId) {
        // 处理结果答案
        // TODO: 竞猜已公布答案后可以显示正确答案
        //var isOver = (parseInt(res.pkg.data.task_status) === 30); // 30表示已开奖
        return Q.ninvoke(mysql, 'query', {
            // 查询答案相关内容
            sql: 'SELECT ' +
            'ans.answer_id, ' +
            'ans.task_id, ' +
            'ans.answer, ' +
            'ans.odds, ' +
            'ans.is_right, ' +
            'ord.sum ' +
            'FROM t_task_answers AS ans ' +
            'LEFT JOIN ( ' +
            'SELECT answer_id, SUM(quantity) AS sum FROM t_task_orders GROUP BY answer_id ) AS ord ' +
            'ON ans.answer_id = ord.answer_id ' +
            'WHERE ans.task_id = ? ORDER BY ans.answer_id ',
            values: [taskId]
        }).then(function (result) {
            var answerArr = [];
            result[0].forEach(function (p1, p2, p3) {
                //让球和大小球不显示平局答案
                if((res.pkg.data.play_type==2 || res.pkg.data.play_type==3) && p1.answer=="平"){
                    return ;
                }
                var item = {
                    answer_id: p1.answer_id,
                    answer: p1.answer,
                    odds: p1.odds,
                    sum: p1.sum || 0
                };
                if(parseInt(res.pkg.data.task_status) === 30 || res.pkg.data.user_id === req.headers.user_id){
                    item.is_right = !!p1.is_right;
                }
                answerArr.push(item);
            });
            res.pkg.data.answer = answerArr;
            return taskId;
        });
    }).then(function (taskId) {
        // ord.create_date, ord.update_date,
        return Q.ninvoke(mysql,'query',{
            sql:'SELECT ord.task_id, ord.user_id, ord.answer_id, ord.quantity, ord.coin_type, ' +
            'usr.nickname, usr.gender, usr.head_url ' +
            'FROM (select task_id, user_id,answer_id,coin_type,sum(quantity) as quantity from t_task_orders group by user_id,answer_id,coin_type) AS ord ' +
            'LEFT JOIN m_users AS usr ' +
            'ON ord.user_id = usr.user_id ' +
            'WHERE ord.task_id = ? ORDER BY ord.answer_id',
            values:[taskId]
        }).then(function (result) {
            res.pkg.data.gamblers = result[0].map(function (currentValue) {
                currentValue.head_url = S(currentValue.head_url || '').startsWith('https://')? currentValue.head_url  :
                    S(currentValue.head_url || '').isEmpty() ? "" : config.prefix_img_url_header + (currentValue.head_url || '');
                return currentValue;
            });
            return taskId;
        });
    }).then(function (taskId) {
        // 单独处理消息个数
        return Q.ninvoke(redis, "select", config.redis_index_of_message_count)
            .then(function () {
                // 根据task_id获取全部的消息个数
                return Q.ninvoke(redis, 'get', 'room_message_count_' + taskId);
            }).catch(function () {
                // redis出错，不影响返回结果，所有消息个数为0
                return 0;
            }).then(function (messages) {
                // 消息个数
                res.pkg.data.message_count = parseInt(messages || 0);

                return taskId;
            });
    }).then(function (taskId) {
        //返回开奖结果
        return Q.ninvoke(mysql, 'query', {
            sql:'SELECT lottery_result FROM t_task_lottery_logs WHERE is_success = 1 and task_id = ? ',
            values: [taskId]
        }).then(function (result) {
            if(result[0].length === 0){
                res.pkg.data.lotteryVo = null;
            }else {
                console.log(result[0]);
                var lotteryVo = JSON.parse(result[0][0].lottery_result);
                res.pkg.data.lotteryVo = {};
                var curUserId = req.headers.user_id || 0;

                //1:正常开奖 2：超时未开奖被平分
                res.pkg.data.lotteryVo.lotteryType =lotteryVo.lotteryType || 1;
                if(curUserId==res.pkg.data.user_id){
                    //展示庄家开奖结果
                    res.pkg.data.lotteryVo.userId =lotteryVo.userId;
                    res.pkg.data.lotteryVo.coinIncomeTotal = lotteryVo.coinIncomeTotal;
                    res.pkg.data.lotteryVo.beanIncomeTotal = lotteryVo.beanIncomeTotal;
                    res.pkg.data.lotteryVo.coinExpendTotal = lotteryVo.coinExpendTotal;
                    res.pkg.data.lotteryVo.beanExpendTotal = lotteryVo.beanExpendTotal;
                }else{
                    //展示参与玩家开奖结果
                    res.pkg.data.lotteryVo.bettingVoList = [];
                    for(var i=0;i<lotteryVo.playerVoList.length;i++){
                        var player = lotteryVo.playerVoList[i];
                        if(player.userId != curUserId) continue;

                        var playList = player.bettingVoList;
                        res.pkg.data.lotteryVo.bettingVoList = playList;
                        var userCoins = 0;
                        for (var j = 0; j < playList.length; j++ ){
                            userCoins += playList[j].coins;
                        }
                        res.pkg.data.lotteryVo.userCoins = userCoins;
                    }
                }
            }
        });
    }).catch(function (error) {
        console.log("task/detail/"+req.query.id);
        console.log(error);
        res.pkg.success = false;
        res.pkg.code = error.code || -1;
        res.pkg.message = error.message;
        res.pkg.data = null;
    }).done(function () {
        console.log("task/detail/"+req.query.id);
        console.log(res.pkg);
        res.jsonp(res.pkg);
    });
};