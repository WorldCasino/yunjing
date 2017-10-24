/**
 * Created by Administrator on 2017/6/17 0017.
 */

var path = require('path');
var mysql = require(path.join(rootDir, './core/db')).mysql;
var Q = require('q');
var moment = require('moment');
var config = require(path.join(rootDir, './config'));
var pd = require(path.join(rootDir,'./core/preconditions'));
var S =require('string');

/**
 *
 * @param req
 * req.query.room:消息的任务id
 * req.query.start:消息开始的id
 * @param res
 * @param next
 */
module.exports = function (req, res, next) {
    Q.fcall(function () {
        var room = parseInt(req.query.room),
            offset = parseInt(req.query.offset || 0),
            limit = parseInt(req.query.limit || 100000);
        pd.checkNotNull(room);
        return Q.ninvoke(mysql, 'query', {
            sql: 'SELECT tm.id, tm.msg,tm.msg_id,u.user_id,u.nickname,u.head_url ' +
            'FROM t_messages as tm LEFT JOIN m_users as u ' +
            'ON tm.send_user = u.user_id ' +
            'WHERE tm.task_id = ? ' +
            'ORDER BY tm.id DESC ' +
            'LIMIT ? OFFSET ?' ,
            values: [room,limit,offset]
        }).then(function (result) {
            res.pkg.data = result[0].map(function (p1, p2, p3) {
                return {
                    type:'message',
                    id:p1.msg_id,
                    payload:p1.msg,
                    room:parseInt(req.query.room),
                    sender:{
                        id:p1.user_id,
                        nick:p1.nickname,
                        head_url:S(p1.head_url || '').startsWith('https://')? p1.head_url  :
                            S(p1.head_url || '').isEmpty() ? "" : config.prefix_img_url_header + (p1.head_url || '')
                    }
                }
            });
            return res.pkg.data;
        });
    }).catch(function (error) {
        res.pkg.success = false;
        res.pkg.code = error.code || -1;
        res.pkg.message = error.message;
        res.pkg.data = null;
    }).done(function () {
        res.jsonp(res.pkg);
    });
};