/**
 * Created by Administrator on 2017/9/19 0019.
 */

const https = require('https');

/**
 * 包装https的get方法为Promise模式。
 * @param uri
 */
module.exports.get = function (uri) {

    return new Promise(function (resolve, reject) {
        https.get(uri, function(res) {
            // 状态不是200表示有问题
            // TODO: 当页面为重定向时候没有考虑，后面可以自己增加处理方法。
            if(parseInt(res.statusCode) !== 200){
                reject(Error.make('无法访问网站',101,null));
                return;
            }

            var html = '';
            // 获取数据
            res.on('data',function (d) {
                html+=d.toString();
            }).on('end',function () {
                resolve(html);
            });
        }).on('error', function(e) {
            reject(e);
        });
    }); // promise
};