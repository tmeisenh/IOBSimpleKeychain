#import "IOBKeychainConfiguration.h"

@interface IOBKeychainConfiguration()

@property (nonatomic, readwrite) NSString *service;
@property (nonatomic, readwrite) NSString *accessGroup;

@end

@implementation IOBKeychainConfiguration

- (instancetype)initWithService:(NSString *)service
                    accessGroup:(NSString *)accessGroup {
    
    self = [super init];
    if (self) {
        _service = service;
        _accessGroup = accessGroup;
    }
    return self;
}

@end
