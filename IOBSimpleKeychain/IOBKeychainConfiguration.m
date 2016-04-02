#import "IOBKeychainConfiguration.h"

@interface IOBKeychainConfiguration()

@property (nonatomic, readwrite) NSString *service;
@property (nonatomic, readwrite) NSString *accessGroup;
@property (nonatomic, readwrite) CFTypeRef keychainAccessibility;

@end

@implementation IOBKeychainConfiguration

- (instancetype)initWithService:(NSString *)service
                    accessGroup:(NSString *)accessGroup
          securityAccessibility:(SecAttrAccessible)securityAccessibility {
    
    self = [super init];
    if (self) {
        _service = service;
        _accessGroup = accessGroup;
        _keychainAccessibility = [IOBKeychainSecurityAccessible kSecAttrAccessibleFromAccessibleEnum:securityAccessibility];
    }
    return self;
    
}

@end
