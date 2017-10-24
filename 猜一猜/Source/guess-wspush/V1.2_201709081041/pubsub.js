/**
 * Created by Administrator on 2017/5/24.
 */

var Q = require('q');
var S = require('string');
var redis = require('./entity').redis;
var redisSub = require('./entity').redisSub;
var config = require('./config.js');
var kernel = require('./kernel');
// 监控的频道
var watchChannel = 'PUSH_MESSAGE';


var pushMessageDefine = {
    type:'roll|chat|award', // roll:跑马灯消息，chat:聊天消息，award:开奖消息，reward:可领取奖励的任务消息
    roll:'跑马灯消息',
    chat:{"type":"broadcast","sender":"system","payload":"rtf购买了10注","room":15},
    award:{"task":15},
    reward:{"user_id":4,"cnt":4}
};
redisSub.on("message", function (channel, message) {
    console.log("sub channel " + channel + ": " + message);
    if (channel === watchChannel) {
        var json = JSON.parse(message);
        switch (json.type) {
            case 'roll':
                kernel.onRollMessage(json);
                break;
            case 'chat':
                kernel.onChatMessage(json);
                kernel.onObserveMessage({
                    type:'observe',
                    observe:{task:json.chat.room,message:json.chat.payload}
                });
                break;
            case 'award':
                kernel.onAwardMessage(json);
                kernel.onObserveMessage({
                    type:'observe',
                    observe:json.award
                });
                break;
            //default: break;

            case 'reward':
                kernel.onObserveReward({
                    type:'observeActive',
                    observeActive:{user_id:json.reward.user_id,cnt:json.reward.cnt}
                });
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