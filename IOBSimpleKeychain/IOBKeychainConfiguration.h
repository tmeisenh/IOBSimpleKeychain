#import <Foundation/Foundation.h>

@interface IOBKeychainConfiguration : NSObject

@property (nonatomic, readonly) NSString *service;
@property (nonatomic, readonly) NSString *accessGroup;
@property (nonatomic, readonly) CFTypeRef keychainAccessibility;

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
- (instancetype)initWithService:(NSString *)service accessGroup:(NSString *)accessGroup;

@end
