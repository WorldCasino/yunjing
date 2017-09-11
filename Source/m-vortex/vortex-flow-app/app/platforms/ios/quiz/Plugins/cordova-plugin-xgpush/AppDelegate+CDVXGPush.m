#import "AppDelegate+CDVXGPush.h"

@implementation AppDelegate (CDVXGPush)

/**
 * 追加推送事件
 */
- (void) application:(UIApplication*)application didReceiveRemoteNotification:(NSDictionary*)userInfo {
  NSLog(@"[AppDelegate] receive remote notification");
  [[NSNotificationCenter defaultCenter] postNotificationName: @"receivenotification" object:userInfo];
}

- (void) application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"[XGPushPlugin] receive device token: %@", deviceToken);
    [[NSNotificationCenter defaultCenter] postNotificationName: CDVRemoteNotification object:deviceToken];
}


#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0

- (void) userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    NSLog(@"[AppDelegate] receive remote notification");
    [[NSNotificationCenter defaultCenter] postNotificationName: @"receivenotification" object:response.notification.request.content.userInfo];
}

- (void) userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    completionHandler(UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert);
}

#endif

@end
