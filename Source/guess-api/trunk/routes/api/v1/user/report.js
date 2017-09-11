/**
 * Created by wurq on 2017/8/8.
 */
var path = require('path');
var mysql = require(path.join(rootDir, './core/db')).mysql;
var Q = require('q');
var pd = require(path.join(rootDir, './core/preconditions'));
/**
 * 竞猜举报
 * @param req
 * req.headers.user_id : 个人的user id，即t_user_account  user id
 * req.headers.task_id : 任务id
 * @param res
 * @param next
 */
module.exports = function (req,res,next) {
    var repeat = false;  //重复举报标识
    Q.fcall(function () {
        var user_id = req.headers.user_id;
        var task_id = req.body.task_id;
        var reason = req.body.reason;


        pd.checkArgument(!!user_id,'用户id不能为空',1001);
        pd.checkArgument(!!task_id,'竞猜id不能为空',1001);

        return Q.ninvoke(mysql,'query',{
            sql: 'SELECT count(1) cnt FROM t_report WHERE user_id = ? and task_id= ?',
            values: [user_id,task_id]
        }).then(function (result) {
            if(result[0][0].cnt!=0){
                repeat = true;
                return true;
            }else{
                return Q.fcall(function () {
                    // 添加记录到t_task_orders
                    var kvp = {
                        task_id: task_id,
                        user_id: user_id,
                        reason: reason,
                        create_by: user_id,
                        update_by: user_id
                    };
                    return Q.ninvoke(mysql, 'query', {
                        sql: 'INSERT INTO t_report SET ?',
                        values: kvp
                    }).then(function (result) {
                        var rows = result[0];
                        // insertId，更新总数出错后可以回滚
                        //return rows.insertId;
                        return true;
                    });
                })
            }
        });
    }).then(function (success) {
        pd.checkState(success,'举报失败');
        res.pkg.message = '举报成功';
        res.pkg.data = '举报成功';
        if(repeat === true){
            res.pkg.data = '不要重复举报';
        }
    }).catch(function (error) {
        res.pkg.success = false;
        res.pkg.code = error.code || -1;
        res.pkg.message = error.message;
        res.pkg.data = null;
    }).done(function () {
        res.jsonp(res.pkg);
    });

}
