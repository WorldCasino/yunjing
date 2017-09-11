/**
 * Created by Administrator on 2017/5/21.
 */
module.exports = {
    redis: {
        // host: '192.168.1.191',
        host: '121.43.183.99',
        // host: process.env.NODE_ENV === "development" ? '192.168.126.142' : '172.16.198.248',
        port: 6388
    },
    mysql: {
        host: 'rm-bp14q7o2rcj239l23o.mysql.rds.aliyuncs.com',
        user: 'root',
        password: 'Wgh0wgh0',
        database: 'test_guess',
        port: 3306
    },
    // 聊天信息在redis中存放在哪个数据库中。
    redis_index_of_socket_chat:2,
    // 每个room中有哪些socket的集合
    prefix_sets_name_of_room:'sets_name_of_room_',
    // 竞猜项目都有哪些观察者集合，为了已猜 不能用 聊天室的集合。。。坑爹
    redis_task_observe_key:'task_observe_users:task_'
};