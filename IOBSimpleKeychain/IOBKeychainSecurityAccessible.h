#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, SecAttrAccessible) {
    SecAttrAccessibleWhenUnlocked,
    SecAttrAccessibleAfterFirstUnlock,
    SecAttrAccessibleAlways,
    SecAttrAccessibleWhenPasscodeSetThisDeviceOnly,
    SecAttrAccessibleWhenUnlockedThisDeviceOnly,
    SecAttrAccessibleAfterFirstUnlockThisDeviceOnly,
    SecAttrAccessibleAlwaysThisDeviceOnly
};


@interface IOBKeychainSecurityAccessible : NSObject

+ (CFStringRef)kSecAttrAccessibleFromAccessibleEnum:(SecAttrAccessible)accessibleEnum;

@end
