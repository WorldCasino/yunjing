#import "CDVRegisterNotification.h"

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
#import <UserNotifications/UserNotifications.h>
#endif

@implementation CDVRegisterNotification

+ (void) registerNotification
{
  NSLog(@"[CDVRegisterNotification] register notification");
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= _IPHONE80_
  // iOS8注册push方法
  float sysVer = [[[UIDevice currentDevice] systemVersion] floatValue];
  if (sysVer < 8) {
    [CDVRegisterNotification registerPush];
  } else {
    [CDVRegisterNotification registerPushForIOS8];
  }
#else
  // iOS8之前注册push方法
  // 注册Push服务，注册后才能收到推送
  [CDVRegisterNotification registerPush];
#endif
}

+ (void) registerPush
{
  NSLog(@"[CDVRegisterNotification] register under ios 8");
  [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
}

+ (void) registerPushForIOS8
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= _IPHONE80_
  NSLog(@"[CDVRegisterNotification] register ios 8");

  //Types
  UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;

  //Actions
  UIMutableUserNotificationAction* acceptAction = [[UIMutableUserNotificationAction alloc] init];

  acceptAction.identifier = @"ACCEPT_IDENTIFIER";
  acceptAction.title = @"Accept";

  acceptAction.activationMode = UIUserNotificationActivationModeForeground;
  acceptAction.destructive = NO;
  acceptAction.authenticationRequired = NO;

  //Categories
  UIMutableUserNotificationCategory* inviteCategory = [[UIMutableUserNotificationCategory alloc] init];

  inviteCategory.identifier = @"INVITE_CATEGORY";

  [inviteCategory setActions:@[acceptAction] forContext:UIUserNotificationActionContextDefault];

  [inviteCategory setActions:@[acceptAction] forContext:UIUserNotificationActionContextMinimal];

  // using arc
  // [acceptAction release];

  NSSet* categories = [NSSet setWithObjects:inviteCategory, nil];

  // using arc
  // [inviteCategory release];

  UIUserNotificationSettings* mySettings = [UIUserNotificationSettings settingsForTypes:types categories:categories];

  [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];

  [[UIApplication sharedApplication] registerForRemoteNotifications];
#endif
}

+ (void) registerAPNS {
    float sysVer = [[[UIDevice currentDevice] systemVersion] floatValue];
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
    if (sysVer >= 10) {
        // iOS 10
        [self registerPush10];
    } else if (sysVer >= 8) {
        // iOS 8-9
        [self registerPush8to9];
    } else {
        // before iOS 8
        [self registerPushBefore8];
    }
#else
    if (sysVer < 8) {
        // before iOS 8
        [self registerPushBefore8];
    } else {
        // iOS 8-9
        [self registerPush8to9];
    }
#endif
}

+ (void) registerPush10 {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    center.delegate = self;
    
    
    [center requestAuthorizationWithOptions:UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
        }
    }];
    [[UIApplication sharedApplication] registerForRemoteNotifications];
#endif
}

+ (void) registerPush8to9 {
    UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
    UIUserNotificationSettings *mySettings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
    [[UIApplication sharedApplication] registerForRemoteNotifications];
}

+ (void) registerPushBefore8 {
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
}

@end
