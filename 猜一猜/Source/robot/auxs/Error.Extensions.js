/**
 * Created by Administrator on 2017/9/19 0019.
 */

/**
 * 扩展Error静态方法，用于快速抛出错误。
 * @param {String} message: 错误消息描述。
 * @param {String} hints: 提示错误可能解决方法。
 * @param {Number} code: 错误代码。
 */
Error.throw = function (message, code, hints) {
    var error = new Error(message);
    if (!!code) error.code = code;
    if (!!hints) error.hints = hints;

    throw error;
};
/**
 * 扩展Error静态方法，用于快速构建错误。
 * @param {String} message: 错误消息描述。
 * @param {String} hints: 提示错误可能解决方法。
 * @param {Number} code: 错误代码。
 */
Error.make=function (message,code,hints) {
    var error = new Error(message);
    if (!!code) error.code = code;
    if (!!hints) error.hints = hints;

    return error;
};