#import "IOBFetchKeychainItemStatement.h"

#import "IOBKeychainConfiguration.h"

@implementation IOBFetchKeychainItemStatement

- (instancetype)initWithKeychainConfiguration:(IOBKeychainConfiguration *)configuration
                                      itemKey:(NSString *)itemKey {
    
    return[super initWithKeychainConfiguration:configuration
                                       itemKey:itemKey];
}

- (NSMutableData *)executeStatementWithError:(NSError **)error {
    
    if (!self.itemKey.length) {
        [self buildError:error
               errorCode:errSecBadReq
            errorMessage:@"Key must not be nil."];
        
        return nil;
    }
    
    NSMutableDictionary *query = [self commonAttributesQuery];
    query[(__bridge __strong id)kSecMatchLimit] = (__bridge id)kSecMatchLimitOne;
    query[(__bridge __strong id)kSecReturnData] = (__bridge id)kCFBooleanTrue;
    
    CFTypeRef data = nil;
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)query,
                                          &data);
    
    NSMutableData *ret;
    
    if (status == errSecSuccess) {
        ret = (__bridge_transfer NSMutableData *)data;
    } else {
        [self buildError:error
               errorCode:status
            errorMessage:[NSString stringWithFormat:@"Error fetching item at key %@", self.itemKey]];
    }
    return ret;
}

@end
