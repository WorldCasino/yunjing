/**
 * Created by Administrator on 2017/5/3.
 */
var path = require('path');
var mysql = require(path.join(rootDir, './core/db')).mysql;
var redis = require(path.join(rootDir, './core/db')).redis;
var Q = require('q');
var moment = require('moment');
var pd = require(path.join(rootDir, './core/preconditions'));
var gm = require('gm');
var config = require(path.join(rootDir,'./config'));
var fs = require('fs');
var settle_time = '';
/**
 * 发布竞猜
 * @param req
 * req.headers.user_id : 个人的user id，即t_user_account  user id
 * @param res
 * @param next
 */
module.exports = function (req, res, next) {
    Q.fcall(function () {
        // 检查传入参数
        pd.checkArgument(!!(req.body.content), '参数content不能为空');
        pd.checkArgument(!!(req.body.right), '参数right不能为空');
        pd.checkArgument(!!(req.body.wrong), '参数wrong不能为空');
        pd.checkArgument(req.files.length >= 2, '答案图片和参考图片最少2张');

        pd.checkArgument(!!req.body.price, '参数price必须设置');
        pd.checkArgument(!!req.body.quantity, '参数quantity必须设置');
        pd.checkArgument(!!req.body.odds_right, '参数odds_right必须设置');
        pd.checkArgument(!!req.body.odds_wrong, '参数odds_wrong必须设置');
    }).then(function () {
        // 图片上传后存储数组
        var arrayOfImages = req.files.map(function (p1, p2, p3) {
            var fileFormat = p1.filename.split(".");
            return {
                field: p1.fieldname,
                oldname: p1.filename,
                name:moment().format('YYYYMMDDHHmmssSSS'+(parseInt(Math.random()*10000)).toString()+"."+fileFormat[fileFormat.length - 1])
            }
        });
        res.pkg.data = {
            images: arrayOfImages
        };
    }).then(function () {
        //检查用户金币是否够用，不够用返回错误，够用进行冻结。
        var user_id = req.headers.user_id,
            price = parseFloat(req.body.price),
            quantity = parseInt(req.body.quantity),
            odds_right = parseFloat(req.body.odds_right);
        return Q.fcall(function () {
            // 查询金币结余是否够用
            return Q.ninvoke(mysql,'query',{
                sql: 'SELECT coin_balance, coin_locked FROM t_user_account WHERE user_id = ? ',
                values: [user_id]
            }).then(function (result) {
                // 我的结余金币
                var myLeft = result[0].length === 1 ? parseFloat(result[0][0].coin_balance || 0.0) : 0.0;
                // 锁定的金币
                var locked = result[0].length === 1 ? parseFloat(result[0][0].coin_locked || 0.0) : 0.0;
                //pd.checkState((myLeft-locked)>=(price*quantity),"金币不足",1001)
                pd.checkState((myLeft-locked)>=(quantity * price * (odds_right - 1)),"金币不足",1001);
                return true;
            });
        }).then(function () {
            // 冻结金币
            return Q.ninvoke(mysql, 'query', {
                sql: 'UPDATE t_user_account SET coin_locked = coin_locked + ?,task_count = task_count + 1  WHERE user_id = ?',
                values: [quantity * price * (odds_right - 1), user_id]
                // values: [quantity * price, user_id] 这个冻结金币计算公式不对
            });
        })
    }).then(function () {
        // 插入到mysql
        var content = req.body.content,
            right = req.body.right,
            wrong = req.body.wrong,
            price = req.body.price,
            quantity = req.body.quantity;
        var user_id = req.headers.user_id;

        return Q.fcall(function () {
            settle_time = moment().add(24,'hours').format('YYYY/MM/DD HH:mm:ss');
            // 插入主表t_tasks
            return Q.ninvoke(mysql, 'query', {
                sql: 'INSERT INTO t_tasks SET ? ',
                values: {
                    user_id: user_id,
                    task_type: 0,
                    task_content: content,
                    task_status: 20,
                    sale_price: price,
                    quantity: quantity,
                    create_by: user_id,
                    update_by: user_id,
                    settle_time:settle_time
                }
            }).then(function (results) {
                var taskId = results[0].insertId;
                res.pkg.data.task_id = taskId;
                return taskId;
            });
        }).then(function (taskId) {// 插入答案t_task_answers
            var answers = [{
                task_id: taskId,
                answer: right,
                is_right: 1,
                odds: req.body.odds_right,
                create_by: user_id
            }, {
                task_id: taskId,
                answer: wrong,
                is_right: 0,
                odds: req.body.odds_wrong,
                create_by: user_id
            }];
            if(new Date().getSeconds()%2 ==0){
                answers.reverse();
            }
            var fns = answers.map(function (p1, p2, p3) {
                return Q.ninvoke(mysql, 'query', {
                    sql: 'INSERT INTO t_task_answers SET ?',
                    values: p1
                });
            });

            // TODO  可以加入答案id等
            return Q.all(fns);
            // // all 不是按顺序执行
            // return Q.all(fns).then(function (results) {
            //     var answerIds = answers.map(function (p1, p2, p3) {
            //         return {
            //             answer_id: results[p2][0].insertId,
            //             is_right: p1.is_right
            //         }
            //     });
            //     res.pkg.data.answers = answerIds;
            //     return answerIds;
            // });
        }).then(function () {
            // 图片名称加入任务id
            res.pkg.data.images = res.pkg.data.images.map(function (p1, p2, p3) {
                p1.name = res.pkg.data.task_id+'_'+p1.name;
                return p1;
            });
            return  res.pkg.data.images;
        }).then(function () { // 图片路径写入表t_task_pictures
            var fns = res.pkg.data.images.map(function (p1, p2, p3) {
                var values = {
                    task_id: res.pkg.data.task_id,
                    pic_url: p1.name,
                    pic_type: (p1.field.indexOf('right') === 0 ? 1 : 0),
                    create_by: user_id
                };
                return Q.ninvoke(mysql, 'query', {
                    sql: 'INSERT INTO t_task_pictures SET ?',
                    values: values
                });
            });
            return Q.all(fns);
        }).then(function () {
            // 图片模糊处理及重命名
            return res.pkg.data.images.map(function (p1, p2, p3) {
                // 正确答案要进行模糊处理
                if(p1.field.indexOf('right') === 0){
                    gm(path.join(config.upload.tasks,p1.oldname))
                        .blur(70,50)
                        .write(path.join(config.upload.blurs,p1.name), function (err) {
                            if(err){
                                throw  new Error(err.message)
                            }
                        });

                    gm(path.join(config.upload.tasks,p1.oldname))
                        .font(path.join(rootDir,'./fonts/msyh.ttf'), 10)
                        .fill('#ffffff')
                        // .drawText(10, 100, '正确答案：'+right)
                        // .drawText(10, 150, '上传用户：'+nickname)
                        // .drawText(10, 200, '上传时间：' + moment().format('YYYY-MM-DD HH:mm:ss'))
                        .drawText(40, 40, '正确答案:'+right,'SouthEast')
                        .drawText(20, 20, moment().format('YYYY-MM-DD HH:mm:ss'),'SouthEast')
                        .write(path.join(config.upload.tasks,p1.name), function (err) {
                            if(err){
                                throw  new Error(err.message)
                            }else{
                                fs.unlink(path.join(config.upload.tasks,p1.oldname));
                            }
                        });
                }else{// 非正确答案进行重命名
                    fs.rename(path.join(config.upload.tasks,p1.oldname),path.join(config.upload.tasks,p1.name));
                }
                return p1;
            });
        });
    }).then(function () {
        // 删除oldname
        return res.pkg.data.images = res.pkg.data.images.map(function (p1, p2, p3) {
            delete p1.oldname;
            return p1;
        });
    }).then(function () {
        Q.ninvoke(redis,'select',config.redis_index_of_lottery_keys)
            .then(function () {
                //插入redis，倒计时开奖用
                var key = config.redis_key_lottery_prefix+res.pkg.data.task_id;
                redis.set(key, JSON.stringify({
                    taskId:res.pkg.data.task_id,
                    settleTime:settle_time
                }));
                var ttl = parseInt(new Date(settle_time).getTime()/1000 - new Date().getTime()/1000);
                redis.expire(key,ttl);

            }).catch(function () {
                //redis出错先不处理
            });
    }).catch(function (error) {
        console.log("publish error : "+error);
        // TODO 回滚mysql中已经加入的信息
        return Q.fcall(function () {
            if(!!res.pkg.data.task_id){
                return Q.ninvoke(mysql, 'query', {
                    sql: 'DELETE FROM t_tasks WHERE task_id = ? ',
                    values: [res.pkg.data.task_id]
                })
            }else {
                return true;
            }
        }).then(function () {
            res.pkg.success = false;
            res.pkg.message = error.message;
            res.pkg.code = error.code || -1;
            res.pkg.data = null;
            return res.pkg;
        }).catch(function () {
            res.pkg.success = false;
            res.pkg.message = error.message;
            res.pkg.code = error.code || -1;
            res.pkg.data = null;
            return res.pkg;
        });

    }).done(function () {
        res.jsonp(res.pkg);
    });

};