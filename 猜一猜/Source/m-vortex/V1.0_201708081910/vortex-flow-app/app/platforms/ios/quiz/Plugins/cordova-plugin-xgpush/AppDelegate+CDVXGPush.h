#import "AppDelegate.h"
#import <Foundation/Foundation.h>

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0

#import <UserNotifications/UserNotifications.h>
@interface AppDelegate(CDVXGPush) <UNUserNotificationCenterDelegate>
@end

#else
@interface AppDelegate (CDVXGPush)
@end

#endif

