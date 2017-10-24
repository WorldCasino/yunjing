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
        // database: 'app_guess',
        //database: 'test_guess',
        database: 'dev_guess',
        port: 3306
    },

};
module.exports = config;