/**
 * Created by Administrator on 2017/5/24.
 */
module.exports = {
    redis: {
        // host:'116.62.21.46',
        // port: 6379,
        // pwd: 'dev.caiecai'
        host: process.env.NODE_ENV === "development" ? '116.62.21.46' : '172.16.198.248',
        port: 6379,
        pwd: process.env.NODE_ENV === "development" ? 'dev.caiecai' : ""
    },
    mysql: {
        host: 'rm-bp14q7o2rcj239l23o.mysql.rds.aliyuncs.com',
        user: 'root',
        password: 'Wgh0wgh0',
        //database: 'test_guess',
        database: 'dev_guess',
        port: 3306
    },
    // 首页推送信息在redis中存放在哪个数据库中。
    redis_index_of_socket_push:3,
    // 跑马灯信息存放键值
    redis_roll_key:'app_roll',
    // 每个room中有哪些socket的集合
    prefix_sets_name_of_room:'sets_name_of_room_',

    // 玩家参与的竞猜项目集合
    redis_user_observe_key:'user_observe_tasks:user_',
    // 竞猜项目都有哪些观察者集合，为了已猜 不能用 聊天室的集合。。。坑爹
    redis_task_observe_key:'task_observe_users:task_',
    //todo 
    redis_user_active_schedule_key:'redis_user_active_schedule:user_'
};