var express = require('express');
var router = express.Router();
var mysql =  require('./db').mysql;
var Q = require('q');
var S = require('string');
var fs = require('fs');
var path = require('path');
var gm = require('gm');

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { title: 'Express' });
});
router.get('/task/:id', function(req, res, next) {

    var IMAGE_PATH_ORIG = '/home/sources/image.caiecai.net/tasks';
    var IMAGE_PATH_BLUR = '/home/sources/image.caiecai.net/blurs';

    var id = req.params.id;
    Q.fcall(function () {
        if(S(id).isEmpty()){
            throw new Error("图片不存在");
        }
        return Q.ninvoke(mysql,'query',{
            sql: '(SELECT pic_type from t_task_pictures WHERE pic_url = ?)',
            values:[id]
        }).then(function (result) {
            if(result[0].length === 0){
                // 任务不存在，返回？
                var content =  fs.readFileSync(path.join(IMAGE_PATH_ORIG,'1_201706191100492761650.jpg'),"binary");
                res.end(content,"binary");
                console.log('a');
                return true;
            }else{
                if(result[0][0].pic_type === 0){
                    var content =  fs.readFileSync(path.join(IMAGE_PATH_ORIG,id),"binary");
                    res.end(content,"binary");
                    console.log('b');
                    return true;
                }else{
                    console.log('c');
                    return false;
                }
            }
        });

    }).then(function (skip) {
        // 答案图片
        if(skip !== false){
            return;
        }

        return Q.ninvoke(mysql,'query',{
            sql:'SELECT task_status from t_tasks WHERE task_id = ' +
            '(SELECT task_id from t_task_pictures WHERE pic_url = ?)',
            values:[id]
        }).then(function (result) {

            if(result[0].length === 0){
                // 任务不存在，返回？
                var content =  fs.readFileSync(path.join(IMAGE_PATH_ORIG,'1_201706191100492761650.jpg'),"binary");
                res.end(content,"binary");
                console.log('e');
            }else{
                if(result[0][0].task_status === 20){
                    var content =  fs.readFileSync(path.join(IMAGE_PATH_BLUR,id),"binary");
                    res.end(content,"binary");
                    console.log('f');
                }else{
                    var content =  fs.readFileSync(path.join(IMAGE_PATH_ORIG,id),"binary");
                    res.end(content,"binary");
                    console.log('g');
                }
            }
        });
    }).catch(function (e) {
    });

});

/**
 * 缩略图
 */
router.get('/task/:id/small', function(req, res, next) {

    var IMAGE_PATH_ORIG = '/home/sources/image.caiecai.net/tasks';
    var IMAGE_PATH_BLUR = '/home/sources/image.caiecai.net/blurs';
    var IMAGE_PATH_ORIG_SMALL = '/home/sources/image.caiecai.net/tasks/small';
    var IMAGE_PATH_BLUR_SMALL = '/home/sources/image.caiecai.net/blurs/small';
    var IMAGE_SIZE_SMALL = 160;

    var id = req.params.id;
    Q.fcall(function () {
        if(S(id).isEmpty()){
            throw new Error("图片不存在");
        }
        return Q.ninvoke(mysql,'query',{
            sql: '(SELECT pic_type from t_task_pictures WHERE pic_url = ?)',
            values:[id]
        }).then(function (result) {
            if(result[0].length === 0){
                // 任务不存在，返回？
                var content =  fs.readFileSync(path.join(IMAGE_PATH_ORIG,'1_201706191100492761650.jpg'),"binary");
                res.end(content,"binary");
                //console.log('a');
                return true;
            }else{

                if(result[0][0].pic_type === 0){
                    // 非答案图片

                    if(!fs.existsSync(path.join(IMAGE_PATH_ORIG_SMALL,id))){
                        // 图片不存在，动态生成缩略图
                        gm(path.join(IMAGE_PATH_ORIG,id))
                        .resize(IMAGE_SIZE_SMALL)
                        .quality(60)
                        .write(path.join(IMAGE_PATH_ORIG_SMALL,id), function (err) {
                            if(err){
                                throw  new Error(err.message)
                            }else{
                                var content =  fs.readFileSync(path.join(IMAGE_PATH_ORIG_SMALL,id),"binary");
                                res.end(content,"binary");
                            }
                        });

                    }else{
                        // 图片存在，直接返回图片
                        var content =  fs.readFileSync(path.join(IMAGE_PATH_ORIG_SMALL,id),"binary");
                        res.end(content,"binary");
                    }
                    return true;
                }else{
                    // 答案图片，下个函数处理
                    //console.log('c');
                    return false;
                }
            }
        });

    }).then(function (skip) {
        // 答案图片
        if(skip !== false){
            return;
        }

        return Q.ninvoke(mysql,'query',{
            sql:'SELECT task_status from t_tasks WHERE task_id = ' +
            '(SELECT task_id from t_task_pictures WHERE pic_url = ?)',
            values:[id]
        }).then(function (result) {

            if(result[0].length === 0){
                // 任务不存在，返回？
                var content =  fs.readFileSync(path.join(IMAGE_PATH_ORIG,'1_201706191100492761650.jpg'),"binary");
                res.end(content,"binary");
                console.log('e');
            }else{
                if(result[0][0].task_status === 20){
                    // 未开奖，使用模糊图
                    //var content =  fs.readFileSync(path.join(IMAGE_PATH_BLUR,id),"binary");
                    //res.end(content,"binary");
                    if(!fs.existsSync(path.join(IMAGE_PATH_BLUR_SMALL,id))){
                        // 图片不存在，动态生成缩略图
                        gm(path.join(IMAGE_PATH_BLUR,id))
                            .resize(IMAGE_SIZE_SMALL)
                            .quality(60)
                            .write(path.join(IMAGE_PATH_BLUR_SMALL,id), function (err) {
                                if(err){
                                    throw  new Error(err.message)
                                }else{
                                    var content =  fs.readFileSync(path.join(IMAGE_PATH_BLUR_SMALL,id),"binary");
                                    res.end(content,"binary");
                                }
                            });

                    }else{
                        // 图片存在，直接返回图片
                        var content =  fs.readFileSync(path.join(IMAGE_PATH_BLUR_SMALL,id),"binary");
                        res.end(content,"binary");
                    }

                }else{
                    //var content =  fs.readFileSync(path.join(IMAGE_PATH_ORIG,id),"binary");
                    //res.end(content,"binary");

                    if(!fs.existsSync(path.join(IMAGE_PATH_ORIG_SMALL,id))){
                        // 图片不存在，动态生成缩略图
                        gm(path.join(IMAGE_PATH_ORIG,id))
                            .resize(IMAGE_SIZE_SMALL)
                            .quality(60)
                            .write(path.join(IMAGE_PATH_ORIG_SMALL,id), function (err) {
                                if(err){
                                    throw  new Error(err.message)
                                }else{
                                    var content =  fs.readFileSync(path.join(IMAGE_PATH_ORIG_SMALL,id),"binary");
                                    res.end(content,"binary");
                                }
                            });
                    }else{
                        // 图片存在，直接返回图片
                        var content =  fs.readFileSync(path.join(IMAGE_PATH_ORIG_SMALL,id),"binary");
                        res.end(content,"binary");
                    }

                }
            }
        });
    }).catch(function (error) {

    });

});

module.exports = router;
