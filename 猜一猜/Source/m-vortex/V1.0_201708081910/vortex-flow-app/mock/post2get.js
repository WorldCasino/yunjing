/**
 * Created by FMISSER on 2017/4/11.
 * Description:
 */
module.exports = function (req, res, next) {
  req.method = "GET";
  next()
}
