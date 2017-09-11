/**
 * Created by Administrator on 2017/5/22.
 */
// 全局变量配置
var PORT = process.env.chat_port || 4000;

var config = require('./config');
var kernel = require('./kenel');
var io = require('socket.io').listen(PORT);

io.sockets.on('connection', function (socket) {
    console.log("Connection " + socket.id + " accepted.");
    // 用户发言
    socket.on('message', function (payload) {
        // payload 定义
        // {
        //     userId:client user id (int),
        //     msg:message body(string)
        // }
        console.log("Received message: " + JSON.stringify(payload) + " - from client " + socket.id);
        kernel.onMessage(socket,payload);
    });
    // 将用户分配到房间
    socket.on('join-room', function (payload) {
        console.log("join room: " + payload + " - from client " + socket.id);
       kernel.onJoinRoom(socket,payload);
    });
    // 用户离开房间
    socket.on('leave-room', function (roomid) {
        console.log('leave room');
        kernel.onLeaveRoom(socket,roomid);
    });
    // 关闭连接，同时离开房间
    socket.on('disconnect', function () {
        console.log("Connection " + socket.id + " terminated.");
        //redis1.del(socket.id);
        kernel.onDisconnect(socket);
    });
});

var pubsub = require('./pubsub');
pubsub.subscribe();
module.exports.io = io;