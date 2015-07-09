#import "IOBDeleteKeychainItemStatement.h"

#import "IOBKeychainConfiguration.h"

@interface IOBDeleteKeychainItemStatement()

@property (nonatomic) NSString *itemKey;

@end

@implementation IOBDeleteKeychainItemStatement

- (instancetype)initWithKeychainConfiguration:(IOBKeychainConfiguration *)configuration
                                      itemKey:(NSString *)itemKey {
    
    if (self = [super initWithKeychainConfiguration:configuration]) {
        _itemKey = itemKey;
    }
    return self;
}

- (BOOL)executeStatementWithError:(NSError **)error {
    
    NSMutableDictionary *query = [self commonAttributesQuery];
    query[(__bridge __strong id)kSecAttrAccount] = self.itemKey;
    
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
