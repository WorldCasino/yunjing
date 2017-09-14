/**
 * Created by Administrator on 2017/4/23.
 */

var path = require('path');
var token = require(path.join(rootDir, './core/token'));
var Q = require('q');
var pd = require(path.join(rootDir,'./core/preconditions'));
var S = require('string');

module.exports = function (app) {

    app.use('/api/*', function (req, res, next) {
        // 为了满足前端A用户查询B用户信息，在headers中输入user_id而现在程序中将token中user_id解析为req.headers.user_id
        req.headers.query_user_id = S(req.headers.user_id).isEmpty() ? undefined : S(req.headers.user_id).s;

        var url = S(req.baseUrl);
        Q.fcall(function () {
            // 如果包含token先解析出用户
            if(S(req.headers.token).isEmpty()){
                return;
            }else{
                return token.getUserId(req.headers.token).then(function (userId) {
                    //pd.checkNotNull(!!userId,'token illegal');
                    req.headers.user_id = userId === false ? undefined : userId;
                    return;
                });
            }
        }).then(function () {
            // 任务不验证token
            if(url.startsWith('/api/v1/task/')  || url.startsWith('/api/task/') || url.startsWith('/api/tasks') || url.startsWith('/api/v1/tasks')){
                next();
                return;
            }
            // 商城不验证token,但兑换页面需要验证
            if((url.startsWith('/api/v1/mall/') && !url.startsWith('/api/v1/mall/exchange')) ||
                (url.startsWith('/api/mall/') && !url.startsWith('/api/mall/exchange'))){
                next();
                return;
            }
            // 排行榜不验证token
            if(url.startsWith('/api/v1/rank/')  || url.startsWith('/api/rank/')){
                next();
                return;
            }
            // 排行榜不验证token
            if(url.startsWith('/api/v1/user/profile')  || url.startsWith('/api/user/profile')){
                next();
                return;
            }
            // 历史消息不验证token
            if(url.startsWith('/api/v1/message/')  || url.startsWith('/api/message/')){
                next();
                return;
            }
            // 每日任务与成长任务，有token需验证，无token不验证
            if((url.startsWith('/api/v1/user/taskdaily')  || url.startsWith('/api/user/taskdaily')) && !req.headers.token){
                req.headers.user_id='';
                next();
                return;
            }
            // 球赛不验证token
            if((url.startsWith('/api/ball'))){
                next();
                return;
            }
            token.validate(req.headers.token).then(function (validation) {

                if (validation) {
                    //return;
                    next();
                } else {
                    // 直接抛出异常，统一让异常处理函数处理，统一出口
                    //var error = new Error('token illegal');
                    //error.code = 1000;
                    //throw error;
                    var error = new Error('登录超时，请重新登录');
                    error.code = 1000;
                    throw error;
                }
            }).catch(function (error) {
                console.log('validate token error')
                res.pkg.success = false;
                res.pkg.message = error.message;
                res.pkg.code = error.code || 1000;
                res.pkg.data = null;
                console.log(res.pkg);
                res.jsonp(res.pkg);
            });
        })
    });
    // // 拦截token验证
    // app.use('/api/*', function (req, res, next) {
    //     var url = S(req.baseUrl);
    //     // 任务不验证token
    //     if(url.startsWith('/api/v1/task/')  || url.startsWith('/api/task/') || url.startsWith('/api/tasks') || url.startsWith('/api/v1/tasks')){
    //         next();
    //         return;
    //     }
    //
    //     // 商城不验证token,但兑换页面需要验证
    //     if((url.startsWith('/api/v1/mall/') && !url.startsWith('/api/v1/mall/exchange')) ||
    //         (url.startsWith('/api/mall/') && !url.startsWith('/api/mall/exchange'))){
    //         next();
    //         return;
    //     }
    //     // 排行榜不验证token
    //     if(url.startsWith('/api/v1/rank/')  || url.startsWith('/api/rank/')){
    //         next();
    //         return;
    //     }
    //     token.validate(req.headers.token).then(function (validation) {
    //         if (validation) {
    //             return;
    //             //next();
    //         } else {
    //             // 直接抛出异常，统一让异常处理函数处理，统一出口
    //             var error = new Error('token illegal');
    //             error.code = 1000;
    //             throw error;
    //         }
    //     }).then(function () {
    //         // 根据token获取user_id
    //         token.getUserId(req.headers.token).then(function (userId) {
    //             pd.checkNotNull(!!userId,'token illegal');
    //             req.headers.user_id = userId;
    //             next();
    //         });
    //     }).catch(function (error) {
    //         console.log('validate token error')
    //         res.pkg.success = false;
    //         res.pkg.message = error.message;
    //         res.pkg.code = error.code || -1;
    //         res.pkg.data = null;
    //         console.log(res.pkg);
    //         res.jsonp(res.pkg);
    //     });
    // });

    // // 拦截token验证
    // app.use(/(^\/api\/user\/.+)|(^\/api\/v1\/user\/.+)/, function (req, res, next) {
    //     console.log(req.headers.token);
    //
    //     Q.fcall(function () {
    //         if (!req.headers.user_id) {
    //             // 直接抛出异常，统一让异常处理函数处理，统一出口
    //             var error = new Error('token illegal');
    //             error.code = 1000;
    //             throw error;
    //         }
    //     }).then(function () {
    //         return token.validate(req.headers.token, req.headers.user_id);
    //     }).then(function (validation) {
    //         if (validation) {
    //             next();
    //         } else {
    //             // 直接抛出异常，统一让异常处理函数处理，统一出口
    //             var error = new Error('token illegal');
    //             error.code = 1000;
    //             throw error;
    //         }
    //     }).catch(function (error) {
    //         console.log('validate token error');
    //         res.pkg.success = false;
    //         res.pkg.message = error.message;
    //         res.pkg.code = error.code || -1;
    //         res.pkg.data = null;
    //         console.log(res.pkg);
    //         res.jsonp(res.pkg);
    //     });
    // });
    app.use('/api', require(path.join(rootDir, './routes/api/v1/index')));
    app.use('/api/v1', require(path.join(rootDir, './routes/api/v1/index')));
};