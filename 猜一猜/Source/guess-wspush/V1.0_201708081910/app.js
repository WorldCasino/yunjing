/**
 * Created by Administrator on 2017/5/22.
 */
// 全局变量配置
var PORT = process.env.chat_port || 4001;

var config = require('./config');
var kernel = require('./kernel');
var io = require('socket.io').listen(PORT);
console.log(JSON.stringify([1,2,3]));
io.sockets.on('connection', function (socket) {
    console.log("Connection " + socket.id + " accepted.");
    //socket.send('aaa');
    /**
     * 观察那些发布竞猜ID
     */
    socket.on('watch', function (message) {
        console.log("watch message: " + message + " - from client " + socket.id);
        //var tasks = JSON.parse(message);
        kernel.onUpdateWatchList(socket,JSON.parse(message));
        //redis1.set(socket.id, roomid);
    });

    /**
     * 关闭连接
     */
    socket.on('disconnect', function () {
        console.log("Connection " + socket.id + " terminated.");
        //redis1.del(socket.id);
        kernel.onDisconnect(socket);
    });

    //给玩家发送跑马灯消息
    kernel.onInit(socket);

    /**
     * 观察玩家相关的竞猜（已猜） data: {userId:123, tasks:[1,2,3]}
     */
    socket.on('observe',function (data) {
        console.log('observe ' +socket.id + ' ' +data);
        kernel.onUpdateObserveList(socket,JSON.parse(data));
    });
});

var pubsub = require('./pubsub');
pubsub.subscribe();
module.exports.io = io;