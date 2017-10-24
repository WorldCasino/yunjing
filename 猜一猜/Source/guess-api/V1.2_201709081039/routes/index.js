/**
 * Created by Administrator on 2017/4/23.
 */

var express = require('express');
var router = express.Router();
var crypto = require('crypto');

/* GET home page. */
router.get('/', function(req, res, next) {
    res.render('index', { title: 'Express' });

});

module.exports = router;