#import "IOBDeleteKeychainItemStatement.h"

#import "IOBKeychainConfiguration.h"

@implementation IOBDeleteKeychainItemStatement

- (instancetype)initWithKeychainConfiguration:(IOBKeychainConfiguration *)configuration
                                      itemKey:(NSString *)itemKey {
    
    return[super initWithKeychainConfiguration:configuration
                                       itemKey:itemKey];
}

- (BOOL)executeStatementWithError:(NSError **)error {
    
    NSMutableDictionary *query = [self commonAttributesQuery];
    
    OSStatus status = SecItemDelete((__bridge CFDictionaryRef)query);
    if (status != errSecSuccess && status != errSecItemNotFound) {
        [self buildError:error
               errorCode:status
            errorMessage:@"Error removing item."];
        return NO;
    }
    return YES;
}

@end
