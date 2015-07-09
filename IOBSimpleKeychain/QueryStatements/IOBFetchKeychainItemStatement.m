#import "IOBFetchKeychainItemStatement.h"

#import "IOBKeychainConfiguration.h"

@interface IOBFetchKeychainItemStatement()

@property (nonatomic, readwrite) NSDictionary *fetchedAttributes;

@end

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
    
    query[(__bridge id)kSecMatchLimit] = (__bridge id) kSecMatchLimitOne;
    query[(__bridge id)kSecReturnData] = (__bridge id) kCFBooleanTrue;
    query[(__bridge id)kSecReturnAttributes] = (__bridge id) kCFBooleanTrue;
    query[(__bridge id)kSecAttrAccount] = self.itemKey;
    
    CFTypeRef data = nil;
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)query,
                                          &data);

    NSMutableData *ret;
    
    if (status == errSecSuccess) {
        self.fetchedAttributes = (__bridge_transfer NSDictionary *)data;
        ret = [self.fetchedAttributes objectForKey:(__bridge id)kSecValueData];
    } else {
        [self buildError:error
               errorCode:status
            errorMessage:[NSString stringWithFormat:@"Error fetching item at key %@", self.itemKey]];
    }
    return ret;
}

@end
