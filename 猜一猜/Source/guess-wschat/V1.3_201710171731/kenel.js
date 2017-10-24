/**
 * Created by Administrator on 2017/5/21.
 */

var Q = require('q');
var S = require('string');
var config = require('./config');
var mysql = require('./entity').mysql;
var redis = require('./entity').redis;
var redisPub = require('./entity').redisPub;

// 发送消息和接收的消息定义都是有5个字段，
//
// type: message | error | broadcast,error和broadcast消息一般由服务端生成，客户端一般只生产message类型，
// 其中error表示服务端错误消息，如任务已经关闭
// broadcast表示房间广播消息，如某用户进入房间、用户退出房间、开奖 、用户购买
//
// sender由id(user_id字段)和nick(nickname字段)组成
// (客户端传入nick，可以减少服务端查询一次数据库, 这样服务端直接将信息原样广播给其它客户端就可以了)
// sender当type=message为用户信息，当为其它error和broadcast类型时候为'system'
//
// payload:消息主体内容，一般为string
//
// id:消息id，发送消息时候不用设置（设置了服务器也会更改），接收消息种字段内容为服务器生成的id
//
// room:房间的id，这主要是为了和后台的消息定义统一，客户端join后也可以不设置。
//
// 注意：消息传输过程必须转化为字符串，即JSON.stringify
//
// 例子：
// var body = JSON.stringify({
//     type: 'message',
//     sender: {id: 123, nick: 'nick name'},
//     payload: 'message content',
//     room: 123
// })
module.exports = {
    onMessage: function (socket, message) {
        message = JSON.parse(message);
        // 客户端投递消息
        return Q.fcall(function () {
            return Q.ninvoke(redis, 'select', config.redis_index_of_socket_chat);
        }).then(function () {
            // 广播消息
            return Q.ninvoke(redis, 'get', socket.id).then(function (info) {
                if(S(info).isEmpty()){
                    throw new Error('没有查询到聊天室信息');
                }
                return JSON.parse(info).room;
            });
        }).then(function (room) {
            // 更新消息计数，同时消息计数也是mysql数据库中某个项目中消息的顺序ID
            // （这样好处是客户端只用记录上次阅读了的消息ID，就可以根据服务端任何时刻推送消息ID相减得出未读消息数目）
            return Q.ninvoke(redis, 'incrby', "room_message_count_" + room, 1).then(function (count) {
                // 广播消息
                // return Q.ninvoke(redisPub, 'publish', 'UPDATE', JSON.stringify({
                //     type: 'UPDATE_MESSAGE_NEW',
                //     data: {
                //         taskId: room,
                //         id: count
                //     }
                // }))
                return Q.ninvoke(redisPub, 'publish', 'PUSH_MESSAGE', JSON.stringify({
                    type: 'chat',
                    chat: {type:"message",id:count,sender:message.sender,payload:message.payload,"room":room}
                })).then(function () {
                    // 消息内容写入mysql数据库
                    return Q.ninvoke(mysql, 'query', {
                        sql: 'INSERT INTO t_messages SET ?',
                        values: {
                            task_id: room,
                            msg: message.payload,
                            send_user: message.sender.id,
                            msg_id: count,
                            create_by: message.sender.id
                        }
                    }).then(function(){
                        //下注更新竞猜的update_date
                        return Q.ninvoke(mysql, 'query', {
                            sql: 'UPDATE t_tasks SET update_date = ?,update_by = ? WHERE task_id = ?',
                            values: [new Date(), message.sender.id, room]
                        })
                    });
                }).then(function () {
                    // 返回给下一步广播消息使用
                    return {
                        room:room,
                        msg_id:count
                    };
                })
            });
        }).then(function (info) {
            // 广播消息
            console.log(info.room);
            console.log(info.msg_id);
            message.id = info.msg_id;
            socket.in(info.room).emit('message', JSON.stringify(message));
            // 不给自己发送，手动给自己发送
            socket.emit('message', JSON.stringify(message));
        }).catch(function (error) {
            console.log(error);
            socket.emit('message', JSON.stringify({
                type: 'error',
                sender: 'system',
                payload: error
            }));
        }).catch(function (error) {
            // socket.emit出错不会退出
            console.log(error);
        })
    },
    onJoinRoom: function (socket, message) {
        // 客户端加入房间
        var body = JSON.parse(message);
        return Q.fcall(function () {
            return socket.join(body.room);
        }).then(function () {
            return Q.ninvoke(redis, 'select', config.redis_index_of_socket_chat).then(function () {
                // 将socket信息存入集合，后面系统广播要用
                redis.sadd(config.prefix_sets_name_of_room+body.room,socket.id);
                // 将房间和用户信息存入rdis
                return redis.set(socket.id, JSON.stringify({
                    room:body.room,
                    sender:body.sender
                }));
            });
        }).then(function () {
            // 广播用户加入房间
            socket.in(body.room).emit('message', JSON.stringify({
                type: 'broadcast',
                sender: 'system',
                payload: body.sender.nick + '加入了房间'
            }));
        }).then(function () {
            // 向加入用户播送消息总个数
            return Q.fcall(function () {
                return Q.ninvoke(redis, 'select', config.redis_index_of_socket_chat);
            }).then(function () {
                return Q.ninvoke(redis, 'get', "room_message_count_" + body.room).then(function (count) {
                    socket.emit('message', JSON.stringify({
                        type: 'message_count',
                        sender: 'system',
                        payload: parseInt(count || 0)
                    }));
                });
            });
        }).catch(function (error) {
            // 向客户端发送错误消息
            console.log(error);
            socket.emit('message', JSON.stringify({
                type: 'error',
                sender: 'system',
                payload: error.message
            }));
        }).catch(function (error) {
            // socket.emit出错不会退出
            console.log(error);
        });

    },
    onLeaveRoom: function (socket, message) {
        var body = JSON.parse(message);
        return Q.fcall(function () {
            socket.leave(body.room);
        }).then(function () {
            return Q.ninvoke(redis, 'select', config.redis_index_of_socket_chat).then(function () {
                //TODO 暂时先注释
                // redis.srem(config.prefix_sets_name_of_room+body.room,socket.id);
                // return redis.del(socket.id);
            });
        }).then(function () {
            // 广播用户离开房间消息
            socket.in(body.room).emit('message', JSON.stringify({
                type: 'broadcast',
                sender: 'system',
                payload: body.sender.nick + '离开了房间'
            }));
        }).catch(function (error) {
            console.log(error);
            socket.emit('message', JSON.stringify({
                type: 'error',
                sender: 'system',
                payload: error.message
            }));
        }).catch(function (error) {
            // socket.emit出错不会退出
            console.log(error);
        });
    },
    onDisconnect: function (socket) {
        // 断开连接,断开连接可能是用户直接关闭了客户端，没有调用leave-room，所以先去redis数据库中查找记录删除并进行广播，如果不存在，说明已经删除，不必广播
        return Q.fcall(function () {
            return Q.ninvoke(redis, 'select', config.redis_index_of_socket_chat);
        }).then(function () {
            // 获取redis是否存在记录
            return Q.ninvoke(redis,'get',socket.id);
        }).then(function (info) {

            // 如果为空，不做任何事情，否则进行广播并删除数据
            if(!S(info).isEmpty()){
                // redis.del(socket.id);//TODO 暂时先注释
                var body = JSON.parse(info);
                //TODO 暂时先注释
                // redis.srem(config.prefix_sets_name_of_room+body.room,socket.id);
                // 广播消息
                socket.in(body.room).emit('message', JSON.stringify({
                    type: 'broadcast',
                    sender: 'system',
                    payload:  body.sender.nick+'离开了房间'
                }));
            }
        }).catch(function (error) {
            console.log(error);
            socket.emit('message', JSON.stringify({
                type: 'error',
                sender: 'system',
                payload: error.message
            }));
        }).catch(function (error) {
            // socket.emit出错不会退出
            console.log(error);
        });
    }
};