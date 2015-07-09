#import "IOBExistsKeychainItemStatement.h"

#import "IOBKeychainConfiguration.h"

@implementation IOBExistsKeychainItemStatement

- (instancetype)initWithKeychainConfiguration:(IOBKeychainConfiguration *)configuration
                                      itemKey:(NSString *)itemKey {
    
    return[super initWithKeychainConfiguration:configuration
                                       itemKey:itemKey];
}

- (BOOL)executeStatementWithError:(NSError **)error {
    
    NSMutableDictionary *query = [self commonAttributesQuery];
    
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)query,
                                          NULL);
    
    if (status != errSecSuccess) {
        [self buildError:error
               errorCode:status
            errorMessage:@"Unable to find item at key."];
        return NO;
    }
    return YES;
}

@end
