/**
 * Created by Administrator on 2017/5/24.
 */
var Q = require('q');
var S = require('string');
var config = require('./config');
var mysql = require('./entity').mysql;
var redis = require('./entity').redis;
var redisPub = require('./entity').redisPub;


module.exports = {
    // 连接后初始化数据，服务端主动推送消息给客户端（如更新跑马灯）
    onInit:function (socket) {
        return Q.fcall(function () {
            return Q.ninvoke(redis,'select',config.redis_index_of_socket_push);
        }).then(function () {
            // 获取跑马灯消息
            return Q.ninvoke(redis,'get',config.redis_roll_key);
        }).then(function (roll) {
            if(roll===null||roll==='')
                roll =JSON.stringify({
                    id:1,
                    title:'欢迎使用猜一猜',
                    content:'猜一猜是一个娱乐竞猜平台，你可以在平台上发布个性的娱乐竞猜项目',
                    link_url:''
                });
            socket.emit('message',roll);
        }).catch(function (error) {
            console.log(error);
        });
    },
    // 更新监控的任务队列，便于推送消息刷新
    onUpdateWatchList: function (socket, tasks) {
        if(!tasks || tasks.length===0) return;
        return Q.fcall(function () {
            return Q.ninvoke(redis,'select',config.redis_index_of_socket_push);
        }).then(function () {
            // 获取原来观察了哪些项目
            return Q.ninvoke(redis,'smembers',socket.id);
        }).then(function (oldTasks) {
            // 移除项目中的socket id，以便有消息不再通知用户
            oldTasks.forEach(function (tid) {
                redis.srem(tid, socket.id);
            });

            // 冗余存储，方便根据socket.id查询他观察的项目
            // 移除这个socket中观察的项目
            redis.del(socket.id, function () {
                // 添加新的观察项目与socket id关联
                redis.sadd(socket.id, tasks);
            });

            // 新的观察项目中关联socket id
            tasks.forEach(function (tid) {
                redis.sadd(tid, socket.id);
            });
        }).catch(function (error) {
            console.log(error);
        });
    },
    onDisconnect:function (socket) {
        return Q.fcall(function () {
            return Q.ninvoke(redis,'select',config.redis_index_of_socket_push);
        }).then(function () {
            // 获取原来观察了哪些项目
            return Q.ninvoke(redis,'smembers',socket.id);
        }).then(function (taskIds) {
            //TODO 手机锁屏后再打开会收不到消息，这里先注释 -----------BGN
            // // 删除项目中关联的socket id
            // taskIds.forEach(function (taskId) {
            //     redis.srem(taskId,socket.id);
            // });
            // // 移除socket关联的项目
            // redis.del(socket.id);
            //TODO 手机锁屏后再打开会收不到消息，这里先注释 -----------END
        }).catch(function (error) {
            console.log(error);
        })
    },
    // 跑马灯消息推送
    onRollMessage:function (message) {
        return Q.fcall(function () {
            return Q.ninvoke(redis,'select',config.redis_index_of_socket_push);
        }).then(function () {
            // 存放数据到redis
            return Q.ninvoke(redis,'set',config.redis_roll_key,JSON.stringify(message));
        }).then(function () {
            var io = require('./app').io;
            io.sockets.emit('message', JSON.stringify(message));
        }).catch(function (error) {
            console.log(error);
        });
    },
    // 聊天消息推送
    onChatMessage:function (message) {
        return Q.fcall(function () {
            return Q.ninvoke(redis,'select',config.redis_index_of_socket_push);
        }).then(function () {
            // 当前房间的所有观察者
            return Q.ninvoke(redis,'smembers',message.chat.room);
        }).then(function (sockets) {
            var io = require('./app').io;
            for (var i = 0; i < sockets.length; i++) {
                try {
                    if (!!io.sockets.sockets[sockets[i]]) {
                        io.sockets.sockets[sockets[i]].emit('message', JSON.stringify(message));
                    }
                } catch (e) {
                    console.log(e);
                }
            }
        }).catch(function (error) {
            console.log(error);
        });
    },
    // 开奖信息
    onAwardMessage:function (message) {
        return Q.fcall(function () {
            return Q.ninvoke(redis,'select',config.redis_index_of_socket_push);
        }).then(function () {
            // 存放数据到redis
            return Q.ninvoke(redis,'smembers',message.award.task);
        }).then(function (sockets) {
            var io = require('./app').io;
            for (var i = 0; i < sockets.length; i++) {
                try {
                    if (!!io.sockets.sockets[sockets[i]]) {
                        io.sockets.sockets[sockets[i]].emit('message', JSON.stringify(message));
                        console.log('award message send success:'+ JSON.stringify(message))
                    }
                } catch (e) {
                    console.log(e);
                }
            }
        }).catch(function (error) {
            console.log(error);
        });
    },
    // 更新玩家观察的已猜队列，便于推送消息刷新
    onUpdateObserveList: function (socket, data) {
        //玩家未登陆 或者没有已猜项目 不处理
        if(!data || !data.userId || !data.tasks || data.tasks.length ===0) return;

        return Q.fcall(function () {
            return Q.ninvoke(redis,'select',config.redis_index_of_socket_push);
        }).then(function () {
            // 获取原来观察了哪些项目
            return Q.ninvoke(redis,'smembers',config.redis_user_observe_key+socket.id);
        }).then(function (oldTasks) {
            // 移除原先观察的task
            oldTasks.forEach(function (tid) {
                redis.srem(tid, config.redis_user_observe_key+socket.id);
            });

            data.tasks.forEach(function (tid) {
                // 新的观察项目中关联socket id
                redis.sadd(config.redis_user_observe_key+socket.id, tid);

                //每个竞猜项目的所有观察者集合 与聊天室的 chat message分开 不然前端没法区分 坑爹。。。
                // redis.sadd(config.prefix_sets_name_of_room+tid,socket.id)
                redis.sadd(config.redis_task_observe_key+tid,socket.id)
            });
        }).catch(function (error) {
            console.log(error);
        });
    },
    // 观察的与我相关消息推送 {type:'observe',observe:{task:123,message:'您参与的项目有更新，快去看看吧'}}
    onObserveMessage:function (message) {
        return Q.fcall(function () {
            return Q.ninvoke(redis,'select',config.redis_index_of_socket_push);
        }).then(function () {
            // 获取竞猜项目的所有的观察者
            return Q.ninvoke(redis,'smembers',config.redis_task_observe_key+message.observe.task);
        }).then(function (sockets) {
            console.log('observe sockets:' + sockets);
            var io = require('./app').io;
            for (var i = 0; i < sockets.length; i++) {
                try {
                    if (!!io.sockets.sockets[sockets[i]]) {
                        io.sockets.sockets[sockets[i]].emit('message', JSON.stringify(message));
                        console.log('observe message send success:'+ JSON.stringify(message))
                    }
                } catch (e) {
                    console.log(e);
                }
            }
        }).catch(function (error) {
            console.log(error);
        });
    },






    // 更新玩家观察的已猜队列，便于推送消息刷新
    onUpdateObserveActive: function (socket, data) {
        //玩家未登陆 或者没有已猜项目 不处理
        if(!data || !data.user_id ) return;

        return Q.fcall(function () {
            return Q.ninvoke(redis,'select',config.redis_index_of_socket_push);
        }).then(function () {
            // 获取原来观察了哪些用户
            //return Q.ninvoke(redis,'smembers',config.redis_user_active_schedule_key+socket.id);
            return Q.ninvoke(redis,'smembers',config.redis_user_active_schedule_key+data.user_id);
        }).then(function (socket_ids) {
            /*
                此方式只会给用户最近登录的终端推送消息
                若要给每个终端推送，可以把socket都保存，断开时删除
             */
            // 移除用户原先socket
            socket_ids.forEach(function (socket_id) {
                redis.srem(config.redis_user_active_schedule_key+data.user_id, socket_id);
            });
            // 保存用户新的socket id
            redis.sadd(config.redis_user_active_schedule_key+data.user_id, socket.id)

            //返回
            socket.emit('message',JSON.stringify({user_id:data.user_id,type:'user_id'}));
            console.log('test:'+data.user_id);
        }).catch(function (error) {
            console.log(error);
        });
    },
    // 观察的与我相关消息推送 {type:'observe',observe:{user_id:4,message:'您有4个可领取奖励的任务，快去看看吧'}}
    onObserveReward:function (message) {
        console.log(message);
        return Q.fcall(function () {
            return Q.ninvoke(redis,'select',config.redis_index_of_socket_push);
        }).then(function () {
            // 获取观察者
            return Q.ninvoke(redis,'smembers',config.redis_user_active_schedule_key+message.observeActive.user_id);
        }).then(function (sockets) {
            console.log('observeActive sockets:' + sockets);
            var io = require('./app').io;
            for (var i = 0; i < sockets.length; i++) {
                try {
                    if (!!io.sockets.sockets[sockets[i]]) {
                        io.sockets.sockets[sockets[i]].emit('message', JSON.stringify(message));
                        console.log('observeActive message send success:'+ JSON.stringify(message))
                    }
                } catch (e) {
                    console.log(e);
                }
            }
        }).catch(function (error) {
            console.log(error);
        });
    }
};