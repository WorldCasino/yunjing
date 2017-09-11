/**
 * Created by Administrator on 2017/5/4.
 */
module.exports.checkArgument = function (expression,errorMessage,code) {
    if(!expression){
        var error = new Error(errorMessage);
        error.code = code || -1;
        throw  error;
    }
};
module.exports.checkState = function (expression,errorMessage,code) {
    if(!expression){
        var error = new Error(errorMessage);
        error.code = code || -1;
        throw  error;
    }
};
module.exports.checkNotNull = function (reference,errorMessage,code) {
    if(reference === undefined){
        var error = new Error(errorMessage);
        error.code = code || -1;
        throw  error;
    }
    return reference;
};