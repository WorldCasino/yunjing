# Robot

## usage
* 初次使用
```
cd /the/robot/dir
npm install
npm install pm2 -g
pm2 start node app.js --name robot
```
* 重启
```
pm2 restart robot
```

## Error Code
* \#101: https get url statusCode<>200

---
## 完善
> 标有 "TODO:" 地方是需要根据后面运行情况，如果有问题，需要自行完善地方。

---
## npm error
> cheerio安装失败，可以试试先执行npm install express

## BUG
> cheerio库发现一个BUG，就是当获取多层数据的时候，
结果返回的不是一个cheerio对象（Node），
所以需要自己重新构造成一个新对象。（参见foootball.js文件中注释）