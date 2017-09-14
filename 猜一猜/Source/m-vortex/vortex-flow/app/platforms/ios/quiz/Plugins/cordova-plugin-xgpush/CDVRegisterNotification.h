#import <Foundation/Foundation.h>

@interface CDVRegisterNotification : NSObject

+ (void) registerPush;
+ (void) registerPushForIOS8;
+ (void) registerNotification;

+ (void) registerAPNS;
+ (void) registerPush10;
+ (void) registerPush8to9;
+ (void) registerPushBefore8;

@end
