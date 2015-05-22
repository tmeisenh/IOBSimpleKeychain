#import "IOBExistsKeychainItemStatement.h"
#import "IOBKeychainConfiguration.h"

@interface IOBExistsKeychainItemStatement()

@property (nonatomic) NSString *itemKey;

@end

@implementation IOBExistsKeychainItemStatement

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
    
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)query, NULL);
    if (status != errSecSuccess && status != errSecInteractionNotAllowed) {
        [self buildError:error errorMessage:@"Unable to find item at key."];
        return NO;
    }
    return YES;
}

@end
