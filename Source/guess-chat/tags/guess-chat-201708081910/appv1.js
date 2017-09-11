// // 全局变量配置
// var PORT = process.env.chat_port || 4000;
//
// var redis = require('redis');
// var mysql = require('mysql');
// var Q = require('q');
// var S = require('string');
// var config = require('./config');
//
// // sub/pub是独占，查询会报错ERR only (P)SUBSCRIBE / (P)UNSUBSCRIBE / QUIT allowed in this context
// var redis_client = redis.createClient(config.redis.port, config.redis.host),
//     redis_client_sub = redis.createClient(config.redis.port, config.redis.host),
//     redis_client_pub = redis.createClient(config.redis.port, config.redis.host);
//
// var io = require('socket.io').listen(PORT);
// io.sockets.on('connection', function (socket) {
//     console.log("Connection " + socket.id + " accepted.");
//     // 用户发言
//     socket.on('message', function (message) {
//         console.log("Received message: " + message + " - from client " + socket.id);
//         // 发言进行广播
//         redis.select(INDEX_OF_ROOM, function (error) {
//             if (error) {
//                 console.log(error);
//             } else {
//                 redis.get(socket.id, function (error, roomid) {
//                     console.log(roomid);
//                     socket.in(roomid).emit('message', message);
//                     // 不给自己发送，手动给自己发送
//                     socket.emit('message', message);
//
//                     redis.incrby("room_message_count_" + roomid, 1, function (e, c) {
//                         //console.log("room_message_count_" + roomid + ' count is' + c);
//
//                         redis_pub.publish('UPDATE', JSON.stringify({
//                             type: 'UPDATE_MESSAGE_COUNT',
//                             data: {taskid: roomid, count: c}
//                         }));
//                     });
//                 });
//             }
//         });
//         // 放到redis广播中，用于更新没有进入房间的用户的消息个数
//     });
//     // 将用户分配到房间
//     socket.on('join-room', function (roomid) {
//         console.log("join room: " + roomid + " - from client " + socket.id);
//         socket.join(roomid);
//         //redis1.set(socket.id, roomid);
//         redis.select(INDEX_OF_ROOM, function (error) {
//             if (error) {
//                 console.log(error);
//             } else {
//                 redis.set(socket.id, roomid);
//             }
//         });
//     });
//     // 用户离开房间
//     socket.on('leave-room', function (roomid) {
//         socket.leave(roomid);
//         redis.select(INDEX_OF_ROOM, function (error) {
//             if (error) {
//                 console.log(error);
//             } else {
//                 redis.del(socket.id);
//             }
//         });
//     });
//     // 关闭连接，同时离开房间
//     socket.on('disconnect', function () {
//         console.log("Connection " + socket.id + " terminated.");
//         //redis1.del(socket.id);
//         redis.select(INDEX_OF_ROOM, function (error) {
//             if (error) {
//                 console.log(error);
//             } else {
//                 redis.del(socket.id);
//             }
//         });
//     });
// });