cordova.define('cordova/plugin_list', function(require, exports, module) {
module.exports = [
    {
        "id": "cordova-plugin-console.console",
        "file": "plugins/cordova-plugin-console/www/console-via-logger.js",
        "pluginId": "cordova-plugin-console",
        "clobbers": [
            "console"
        ]
    },
    {
        "id": "cordova-plugin-console.logger",
        "file": "plugins/cordova-plugin-console/www/logger.js",
        "pluginId": "cordova-plugin-console",
        "clobbers": [
            "cordova.logger"
        ]
    },
    {
        "id": "cordova-plugin-inapppurchase.PaymentsPlugin",
        "file": "plugins/cordova-plugin-inapppurchase/www/index-ios.js",
        "pluginId": "cordova-plugin-inapppurchase",
        "clobbers": [
            "inAppPurchase"
        ]
    },
    {
        "id": "cordova-plugin-statusbar.statusbar",
        "file": "plugins/cordova-plugin-statusbar/www/statusbar.js",
        "pluginId": "cordova-plugin-statusbar",
        "clobbers": [
            "window.StatusBar"
        ]
    },
    {
        "id": "cordova-plugin-xgpush.XGPush",
        "file": "plugins/cordova-plugin-xgpush/www/xgpush.js",
        "pluginId": "cordova-plugin-xgpush",
        "clobbers": [
            "window.xgpush"
        ]
    },
    {
        "id": "cordova-plugin-wechat.Wechat",
        "file": "plugins/cordova-plugin-wechat/www/wechat.js",
        "pluginId": "cordova-plugin-wechat",
        "clobbers": [
            "Wechat"
        ]
    },
    {
        "id": "cordova-hot-code-push-plugin.chcp",
        "file": "plugins/cordova-hot-code-push-plugin/www/chcp.js",
        "pluginId": "cordova-hot-code-push-plugin",
        "clobbers": [
            "chcp"
        ]
    }
];
module.exports.metadata = 
// TOP OF METADATA
{
    "cordova-plugin-whitelist": "1.3.2",
    "cordova-plugin-console": "1.0.7",
    "cordova-plugin-inapppurchase": "1.1.0",
    "cordova-plugin-statusbar": "2.2.3",
    "cordova-plugin-xgpush": "0.2.0",
    "cordova-plugin-wechat": "2.0.0",
    "cordova-hot-code-push-plugin": "1.5.3"
};
// BOTTOM OF METADATA
});