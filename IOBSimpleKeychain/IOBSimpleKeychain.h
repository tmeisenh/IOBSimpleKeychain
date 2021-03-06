#import <Foundation/Foundation.h>

#import "IOBKeychainSecurityAccessible.h"

/**
 
 Simple, generic iOS keychain wrapper that encapsulates CRUD operations.
 
 **/

@interface IOBSimpleKeychain : NSObject

/*
 Default init is unavailable.
 */
- (instancetype)init UNAVAILABLE_ATTRIBUTE;

/*
 Initializes a IOBSimpleKeychain with a serviceName that represents your organization or your application.
 Default securityAccessibility is SecAttrAccessibleWhenUnlockedThisDeviceOnly.
 */
- (instancetype)initWithServiceName:(NSString *)serviceName;

/*
 Initializes a IOBSimpleKeychain with a serviceName that represents your organization and the sharedKeyChainAccessGroup defined in your project's
 Xcode -> Capabilities -> Keychain Sharing -> group identifier
 Default securityAccessibility is SecAttrAccessibleWhenUnlockedThisDeviceOnly.
 */
- (instancetype)initWithServiceName:(NSString *)serviceName
          sharedKeychainAccessGroup:(NSString *)sharedKeychainAccessGroup;

- (instancetype)initWithServiceName:(NSString *)serviceName
          sharedKeychainAccessGroup:(NSString *)sharedKeychainAccessGroup
              securityAccessibility:(SecAttrAccessible)securityAccessibility;

- (NSMutableString *)stringForKey:(NSString *)key;
- (NSMutableData *)dataForKey:(NSString *)key;

- (BOOL)putString:(NSString *)string atKey:(NSString *)key;
- (BOOL)putData:(NSData *)data atKey:(NSString *)key;

- (BOOL)putString:(NSString *)string atKey:(NSString *)key error:(NSError **)error;
- (BOOL)putData:(NSData *)data atKey:(NSString *)key error:(NSError **)error;

- (BOOL)removeItemForKey:(NSString *)key;

@end