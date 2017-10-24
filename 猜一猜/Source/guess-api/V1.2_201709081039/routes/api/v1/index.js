/**
 * Created by Administrator on 2017/4/23.
 */
var express = require('express');
var router = express.Router();
var path = require('path');
var tasks = require('./task/last');
var task_gambler = require('./task/gambler');
var task_gambler2 = require('./task/gambler2');
var profile = require('./user/profile');
var judge = require('./user/judge');
var app_switch = require('./user/app-switch');

/* GET home page. */
router.get('/', function(req, res, next) {
    res.render('index', { title: 'Express' });
});
/**##################宏观页面###############**/
router.get('/tasks', tasks.latest);
// 投注玩家页面
router.get('/task/gamblers',task_gambler);
router.get('/task/gamblers2',task_gambler2);
// 页面详情
router.get('/task/profile',require('./task/detail'));
/**##################排行榜###############**/
router.get('/rank/all', require('./rank/all'));
router.get('/rank/month', require('./rank/month'));
router.get('/rank/today', require('./rank/today'));
/**##################用户相关###############**/
// 用户资料
router.get('/user/profile',profile);
// 用户弹框判断
router.get('/user/judge',judge);
//  app按钮功能
router.get('/user/switch',app_switch);
// 更新用户信息
var uploadHeader = require(path.join(rootDir,'./core/upload')).headers;
router.post('/user/profile/update', uploadHeader.any(), require('./user/update-userinfo'));
// 用户下注
router.post('/user/bet',require('./user/bet'));
// 用户金币
router.get('/user/coin',require('./user/coin'));
// 查询我发布内容与和我相关的发布
router.get('/user/posts',require('./user/posts'));
// 查询我发布内容与
router.get('/user/mypubs',require('./user/mypubs'));
// 删除我的发布
router.delete('/user/post/:id?',require('./user/post-delete'));
// 发布任务
var uploadTask = require(path.join(rootDir,'./core/upload')).tasks;
router.post('/user/post/publish', uploadTask.any(), require('./user/post-publish'));
// 复制发布任务
router.post('/user/post/copy', uploadTask.any(), require('./user/post-copy'));
// 补充发布任务，即完成设置赔率等第二页信息
router.post('/user/post/supplement',require('./user/post-supplement'));
// 举报
router.post('/user/report',require('./user/report'));
// 每日任务与成长任务
router.post('/user/taskdaily',require('./user/task-daily'));
// 领取任务奖励
router.post('/user/getReward',require('./user/get-reward'));
// 检测每日使用，做为每日登陆任务 计数的接口
router.post('/user/logindaily',require('./user/login-daily'));
// 分享到好友、朋友圈，邀请好友
router.post('/user/shareandinvite',require('./user/shareandinvite'));


/**##################商城###############**/
// 商城列表
router.get('/mall/kinds',require('./mall/kinds'));
// 商品详情
router.get('/mall/kind',require('./mall/kind'));
// 提交兑换
router.post('/mall/exchange/commit',require('./mall/exchange/commit'));
// 兑换商品付款
router.post('/mall/exchange/pay',require('./mall/exchange/pay'));
// 我的兑换商品列表
router.get('/mall/exchange/mine',require('./mall/exchange/mine'));

/**##################历史消息###############**/
// 历史消息
router.get('/message/get',require('./message/get'));

module.exports = router;