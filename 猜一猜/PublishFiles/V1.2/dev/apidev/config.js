/**
 * Created by Administrator on 2017/4/23.
 */

var config = {
    redis: {
        host:'116.62.21.46',
        port: 6379,
        pwd: 'dev.caiecai'
        // //host:'192.168.1.191',
        // host: '121.43.183.99',
        // // host: process.env.NODE_ENV === 'development' ? '192.168.1.191' : '172.16.198.248',
        // port: 6388

    },
        mysql: {
        host: 'rm-bp14q7o2rcj239l23o.mysql.rds.aliyuncs.com',
        user: 'root',
        password: 'Wgh0wgh0',
        //database: 'test_guess',
        database: 'dev_guess',
        port: 3306
    },
    secret: process.env.JWT_SECRET_STRING || 'cicada@caiecai', // token secret string
    redis_key_lottery_prefix: 'lottery:task_', //redis prefix key of lottery
    redis_index_of_lottery_keys: 0, //redis db index of lottery queue
    redis_index_of_message_count: 2, //redis db index of message count
    upload: {
        path:process.env.NODE_ENV === 'development' ? 'C:\\node_uploads' : '/home/www/nodejs/uploads',
        tasks: process.env.NODE_ENV === 'development' ? 'C:\\node_uploads\\tasks' : '/home/sources/image.caiecai.net/tasks',
        headers: process.env.NODE_ENV === 'development' ? 'C:\\node_uploads\\headers' : '/home/sources/image.caiecai.net/headers',
        blurs:process.env.NODE_ENV === 'development' ? 'C:\\node_uploads\\blurs' : '/home/sources/image.caiecai.net/blurs'
    },
    domain:'https://image.caiecai.net/',
    prefix_img_url_task:'http://imagedev.caiecai.net/task/',
    prefix_img_url_header:'https://image.caiecai.net/headers/',
    prefix_img_url_mall:'https://image.caiecai.net/mall/'
};
module.exports = config;