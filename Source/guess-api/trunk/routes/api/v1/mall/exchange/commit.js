/**
 * Created by Administrator on 2017/5/13.
 */

var path = require('path');
var mysql = require(path.join(rootDir, './core/db')).mysql;
var Q = require('q');
var moment = require('moment');
var pd = require(path.join(rootDir, './core/preconditions'));
var S = require('string');

/**
 * 兑换商品
 * @param req
 * req.headers.user_id : 个人的user id，即t_user_account  user id
 * @param res
 * @param next
 */
module.exports = function (req, res, next) {
    var itemInfo = {};
    var clientName = '';

    Q.fcall(function () {
        // 检查传入参数
        //pd.checkArgument(!!(req.body.order_type), '参数order_type不能为空');
        pd.checkArgument(!!(req.body.item_code), '参数item_code不能为空');
        pd.checkArgument(!!(req.body.qty), '参数qty不能为空');
        //pd.checkArgument(!!(req.body.price_coins), '参数price_coins不能为空');

        //pd.checkArgument(!!req.body.addr_contact, '参数addr_contact必须设置');
        pd.checkArgument(!!req.body.addr_tel, '参数addr_tel必须设置');
        //pd.checkArgument(!!req.body.addr1, '参数addr1必须设置');
        //pd.checkArgument(!!req.body.addr2, '参数addr2必须设置');
        //pd.checkArgument(!!req.body.addr_code, '参数addr_code必须设置');
       // pd.checkArgument(!!req.body.addr_lng, '参数addr_lng必须设置');
        //pd.checkArgument(!!req.body.addr_lat, '参数addr_lat必须设置');
    }).then(function () {
        // 查询商品的定价,避免从客户端传回的有误
        var item_code = req.body.item_code;
        return Q.ninvoke(mysql,'query',{
            sql:'SELECT price_coins,item_id,item_name FROM m_items WHERE item_code = ?',
            values:[item_code]
        }).then(function (result) {
            pd.checkState(result[0].length === 1 ,'没有查询到你想要兑换商品的信息,商品id = ' +item_code.toString());
            itemInfo = result[0][0];
            return parseInt(result[0][0].price_coins);
        });
    }).then(function (price_coins) {
        var user_id = req.headers.user_id;
        return Q.ninvoke(mysql,'query',{
            sql:'SELECT user_id,IFNULL(nickname,phonenumber) nickname FROM m_users WHERE user_id = ?',
            values:[user_id]
        }).then(function (result) {
            clientName = result[0][0].nickname;
            return price_coins;
        });

    }).then(function (price_coins) {
        // 插入到mysql
        var order_type = parseInt(req.body.order_type || 1),
            item_code = req.body.item_code,
            qty = parseInt(req.body.qty),
            //price_coins = parseInt(req.body.price_coins),
            addr_contact = req.body.addr_contact || clientName,
            addr_tel = req.body.addr_tel,
            addr1 = req.body.addr1 || '',
            addr2 = req.body.addr2 || '',
            addr_code = req.body.addr_code,
            addr_lng = req.body.addr_lng,
            addr_lat = req.body.addr_lat;

        var user_id = req.headers.user_id;
        // 订单号 D + 时间 + 用户ID + 兑换商品ID + 兑换商品数量
        var order_code = 'D' + moment().format('YYYYMMDDHHmmss') +
            S(user_id).padLeft(6, '0').s +
            S(item_code).padLeft(6, '0').s +
            S(qty).padLeft(4, '0').s;
        var order_status = 10,
            item_id = itemInfo.item_id,
            item_name = itemInfo.item_name,
            amount_coins = price_coins * qty;


        return Q.fcall(function () {
            // 插入主表t_orders
            return Q.ninvoke(mysql, 'query', {
                sql: 'INSERT INTO t_orders SET ?',
                values: {
                    order_code: order_code,
                    user_id: user_id,
                    order_type: order_type,
                    order_status: order_status,
                    item_id: item_id,
                    item_code: item_code,
                    item_name: item_name,
                    qty: qty,
                    price_coins: price_coins,
                    coins_amount: amount_coins,
                    addr_contact: addr_contact,
                    addr_tel: addr_tel,
                    addr1: addr1,
                    addr2: addr2,
                    addr_code: addr_code,
                    addr_lng: addr_lng,
                    addr_lat: addr_lat,
                    create_by: user_id,
                    update_by: user_id
                }
            }).then(function (results) {
                var order_id = results[0].insertId;
                res.pkg.data = {
                    order_id: order_id,
                    order_code: order_code,
                    cost: amount_coins
                };
                return res.pkg.data;
            });
        });
    }).catch(function (error) {
        res.pkg.success = false;
        res.pkg.message = error.message;
        res.pkg.code = error.code || -1;
        res.pkg.data = null;
    }).done(function () {
        res.jsonp(res.pkg);
    });

};