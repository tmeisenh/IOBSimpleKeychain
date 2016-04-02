#import "IOBKeychainSecurityAccessible.h"

@implementation IOBKeychainSecurityAccessible

+ (CFStringRef)kSecAttrAccessibleFromAccessibleEnum:(SecAttrAccessible)accessibleEnum {
    switch (accessibleEnum) {
        case SecAttrAccessibleWhenUnlocked:
            return kSecAttrAccessibleWhenUnlocked;
            break;
        case SecAttrAccessibleAfterFirstUnlock:
            return kSecAttrAccessibleAfterFirstUnlock;
            break;
        case SecAttrAccessibleAlways:
            return kSecAttrAccessibleAlways;
            break;
        case SecAttrAccessibleWhenPasscodeSetThisDeviceOnly:
            return kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly;
            break;
        case SecAttrAccessibleWhenUnlockedThisDeviceOnly:
            return kSecAttrAccessibleWhenUnlockedThisDeviceOnly;
            break;
        case SecAttrAccessibleAfterFirstUnlockThisDeviceOnly:
            return kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly;
            break;
        case SecAttrAccessibleAlwaysThisDeviceOnly:
            return kSecAttrAccessibleAlwaysThisDeviceOnly;
            break;
        default:
            return (__bridge CFStringRef) @"unknown";
            break;
    }
}


@end
