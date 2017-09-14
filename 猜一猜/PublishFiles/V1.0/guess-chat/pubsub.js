/**
 * Created by Administrator on 2017/5/23.
 */
var Q = require('q');
var S = require('string');
var redis = require('./entity').redis;
var redisSub = require('./entity').redisSub;
var config = require('./config.js');
// 监控的频道
var watchChannel = 'CHAT_MESSAGE';


redisSub.on("message", function (channel, message) {
    console.log("sub channel " + channel + ": " + message);
    if (channel === watchChannel) {
        var json = JSON.parse(message);
        switch (json.type) {
            case 'broadcast':
                onBroadcast(json);
                break;
            default: break;
        }
    }
});

module.exports.subscribe = function () {
    redisSub.subscribe(watchChannel);
};
function onBroadcast(json) {
    return Q.fcall(function () {
        return Q.ninvoke(redis, 'select', config.redis_index_of_socket_chat);
    }).then(function () {
        // 广播消息
        return Q.ninvoke(redis, 'smembers', config.prefix_sets_name_of_room + json.room).then(function (sockets) {
            var io = require('./app').io;
            for (var i = 0; i < sockets.length; i++) {
                try {
                    if (!!io.sockets.sockets[sockets[i]]) {
                        io.sockets.sockets[sockets[i]].emit('message', JSON.stringify(json));
                    }
                } catch (e) {
                    console.log(e);
                }
            }
        });
    });
}

// function pushToClients(json){
//     redis.select(INDEX_OF_DB, function (se) {
//         if (se) {
//             console.log(se);
//         } else {
//             // 获取项目关联的socket id数组
//             redis.smembers(json.data.taskid, function (sme, sockets) {
//                 if (sme) {
//                     console.log(sme);
//                 } else {
//                     var io = require('../server.js').io;
//                     for (var i = 0; i < sockets.length; i++) {
//                         try {
//                             if (!!io.sockets.sockets[sockets[i]]) {
//                                 io.sockets.sockets[sockets[i]].emit('message', json);
//                             }
//
//                         } catch (e) {
//                             console.log(e);
//                         }
//                     }
//                 }
//             });
//         }
//     });
// }