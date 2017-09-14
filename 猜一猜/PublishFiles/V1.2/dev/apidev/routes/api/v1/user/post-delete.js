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
 * req.headers.task_id : 任务id
 * @param res
 * @param next
 */
module.exports = function (req,res,next) {
    Q.fcall(function () {
        var user_id = req.headers.user_id;
        var task_id = req.headers.task_id;

        pd.checkArgument(!!user_id,'用户id不能为空',1001);
        pd.checkArgument(!!task_id,'竞猜id不能为空',1001);

        return Q.ninvoke(mysql,'query',{
            sql:'UPDATE t_tasks SET is_delete = ? WHERE task_id = ?  AND user_id = ?',
            values:[1,task_id,user_id]
        }).then(function () {
            return Q.ninvoke(mysql,'query',{
                sql:'UPDATE t_task_answers SET is_delete = ? WHERE task_id = ?',
                values:[1,task_id]
            });
        }).then(function () {
            return Q.ninvoke(mysql,'query',{
                sql:'UPDATE t_task_pictures SET is_delete = ? WHERE task_id = ?',
                values:[1,task_id]
            });
        }).then(function () {
            return Q.ninvoke(mysql,'query',{
                sql:'UPDATE t_task_football SET is_delete = ? WHERE task_id = ?',
                values:[1,task_id]
            });
        }).then(function () {
            return Q.ninvoke(mysql,'query',{
                sql:'UPDATE t_task_orders SET is_delete = ? WHERE task_id = ?',
                values:[1,task_id]
            });
        }).then(function () {
            return true;
        });
    }).then(function (success) {
        pd.checkState(success,'删除失败');

        res.pkg.message = '操作成功';
        res.pkg.data = true;
    }).catch(function (error) {
        res.pkg.success = false;
        res.pkg.code = error.code || -1;
        res.pkg.message = error.message;
        res.pkg.data = null;
    }).done(function () {
        res.jsonp(res.pkg);
    });
};