#import "CDVXGPushPlugin.h"
#import "CDVXGPushUtil.h"
#import "XGSetting.h"

@implementation CDVXGPushPlugin

/**
 * 插件初始化
 */
- (void) pluginInitialize {
  // 注册获取 token 回调
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didRegisterForRemoteNotificationsWithDeviceToken:) name:CDVRemoteNotification object:nil];

  // 注册错误回调
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFailToRegisterForRemoteNotificationsWithError:) name:CDVRemoteNotificationError object:nil];

  // 注册接收回调
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveRemoteNotification:) name:@"receivenotification" object:nil];

  // 初始化
  self.util = [[CDVXGPushUtil alloc] init];
  self.callbackIds = [[NSMutableArray alloc] init];

//    [[XGSetting getInstance] enableDebug:YES];
    
  // 启动 XGPush
  [self.util startApp];
  [self.util initForReregister];
}

/**
 * [description]
 *
 * @param  {[type]} void [description]
 * @return {[type]}      [description]
 */
- (void) didRegisterForRemoteNotificationsWithDeviceToken:(NSNotification*)notification {
  NSLog(@"[XGPushPlugin] receive device token: %@", notification.object);
  [self.util registerDevice:notification.object];
}

/**
 * [description]
 *
 * @param  {[type]} void [description]
 * @return {[type]}      [description]
 */
- (void) didFailToRegisterForRemoteNotificationsWithError:(NSNotification*)notification {
  NSLog(@"[XGPushPlugin] register fail");
}

/**
 * [description]
 *
 * @param  {[type]} void [description]
 * @return {[type]}      [description]
 */
- (void) didReceiveRemoteNotification:(NSNotification*)notification {
  NSLog(@"[XGPushPlugin] receive notification: %@", notification);
  NSLog(@"[XGPushPlugin] callback ids: %@", self.callbackIds);
  [self.callbackIds enumerateObjectsUsingBlock:^(id callbackId, NSUInteger idx, BOOL *stop) {
    NSLog(@"[XGPushPlugin] callbackId: %@", callbackId);
    CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:notification.object];
    [result setKeepCallback:[NSNumber numberWithBool:YES]];
    [self.commandDelegate sendPluginResult:result callbackId:callbackId];
  }];
}

/**
 * [description]
 *
 * @param  {[type]} void [description]registerPush
 * @return {[type]}      [description]
 */
- (void) registerpush:(CDVInvokedUrlCommand*)command {
  NSString* alias = [command.arguments objectAtIndex:0];
  NSLog(@"[XGPushPlugin] registerpush: %@", alias);
    
    if ([alias isEqual: @"get-device-token"]) {
        CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:self.util.getDeviceTokenString];
        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
        return;
    }

  // FIXME: 放到 background thread 里运行时无法执行回调
  [self.util registerPush:alias successCallback:^{
    // 成功
    NSLog(@"[XGPushPlugin] registerpush success");
    CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];

  } errorCallback:^{
    // 失败
    NSLog(@"[XGPushPlugin] registerpush error");
    CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
  }];
}

/**
 * [description]
 *
 * @param  {[type]} void [description]
 * @return {[type]}      [description]
 */
- (void) unregisterpush:(CDVInvokedUrlCommand*)command {
  NSLog(@"[XGPushPlugin] registerpush");

  // FIXME: 放到 background thread 里运行时无法执行回调
  [self.util unregisterPush:^{
    // 成功
    NSLog(@"[XGPushPlugin] deregisterpush success");
    CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];

  } errorCallback:^{
    // 失败
    NSLog(@"[XGPushPlugin] deregisterpush error");
    CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];

  }];
}

/**
 * [description]
 *
 * @param  {[type]} void [description]
 * @return {[type]}      [description]
 */
- (void) addlistener:(CDVInvokedUrlCommand*)command {
  NSLog(@"[XGPushPlugin] add listener: %@", command.callbackId);
  [self.callbackIds addObject:command.callbackId];
}

- (void) getdevicetoken:(CDVInvokedUrlCommand *)command {
    
    NSString* deviceToken = [self.util getDeviceTokenString];
    if (deviceToken != NULL) {
        NSLog(@"[XGPushPlugin] get device token succeed");
        CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:deviceToken];
        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    } else {
        NSLog(@"[XGPushPlugin] get device token failed");
        CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    }
}

@end
