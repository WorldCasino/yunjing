#import <Foundation/Foundation.h>

typedef void (^CallbackBlock)(void);

@interface CDVXGPushUtil: NSObject

- (void) startApp;
- (void) initForReregister;
- (void) registerDevice:(NSData*)deviceToken;
- (void) registerPush:(NSString*)alias successCallback:(CallbackBlock)success errorCallback:(CallbackBlock)error;
- (void) unregisterPush:(CallbackBlock)success errorCallback:(CallbackBlock)error;
- (uint32_t) getAccessID;
- (NSString*) getAccessKey;

- (NSString*) getDeviceTokenString;

@property NSData* deviceToken;

@end
