/**
 * Created by Administrator on 2017/6/20.
 */

var mysql = require('mysql');
module.exports.mysql = mysql.createPool({
    connectionLimit: 20,
    host: 'rm-bp14q7o2rcj239l23o.mysql.rds.aliyuncs.com',
    user: 'root',
    password: 'Wgh0wgh0',
    database: 'app_guess'
});
