/**
 * Created by Administrator on 2017/5/22.
 */
var mysql = require('mysql');
var redis = require('redis');
var config = require('./config');
module.exports.mysql = mysql.createPool({
    connectionLimit: 20,
    host: config.mysql.host,
    user: config.mysql.user,
    password: config.mysql.password,
    database: config.mysql.database
});
// sub/pub是独占，查询会报错ERR only (P)SUBSCRIBE / (P)UNSUBSCRIBE / QUIT allowed in this context
module.exports.redis = redis.createClient(config.redis.port, config.redis.host);
module.exports.redisPub = redis.createClient(config.redis.port, config.redis.host);
module.exports.redisSub = redis.createClient(config.redis.port, config.redis.host);