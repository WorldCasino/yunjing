/**
 * Created by Administrator on 2017/4/23.
 */
var path = require('path');
var mysql = require('mysql');
var redis = require('redis');
var config = require(path.join(rootDir, './config'));
module.exports.mysql = mysql.createPool({
    connectionLimit: 20,
    host: config.mysql.host,
    user: config.mysql.user,
    password: config.mysql.password,
    database: config.mysql.database
});
var auth = {auth_pass:config.redis.pwd};
module.exports.redis = redis.createClient(config.redis.port, config.redis.host , auth);
module.exports.redisPub = redis.createClient(config.redis.port, config.redis.host , auth);
module.exports.redisSub = redis.createClient(config.redis.port, config.redis.host , auth);
module.exports.redisBall = redis.createClient(config.redis.port, config.redis.host , auth);
