#import "IOBUpdateKeychainItemStatement.h"
#import "IOBKeychainConfiguration.h"

@interface IOBUpdateKeychainItemStatement()

@property (nonatomic) NSString *itemKey;
@property (nonatomic) NSData *itemData;

@end

@implementation IOBUpdateKeychainItemStatement

- (instancetype)initWithKeychainConfiguration:(IOBKeychainConfiguration *)configuration
                                      itemKey:(NSString *)itemKey
                                     itemData:(NSData *)itemData {
    
    if (self = [super initWithKeychainConfiguration:configuration]) {
        _itemKey = itemKey;
        _itemData = itemData;
    }
    return self;
}

- (BOOL)executeStatementWithError:(NSError **)error {
    
    NSMutableDictionary *query = [self commonAttributesQuery];
    query[(__bridge __strong id)kSecAttrAccount] = self.itemKey;

    NSMutableDictionary *attributes = [self commonAttributesQuery];
    attributes[(__bridge __strong id)kSecValueData] = self.itemData;
    attributes[(__bridge __strong id)kSecAttrAccessible] = (__bridge id)self.keychainConfiguration.keychainAccessibility;
    
    OSStatus status = SecItemUpdate((__bridge CFDictionaryRef)query, (__bridge CFDictionaryRef)attributes);
    if (status != errSecSuccess) {
        [self buildError:error
               errorCode:status
            errorMessage:[NSString stringWithFormat:@"Unable to update item at key %@", self.itemKey]];
        return NO;
    }
    return YES;
}


@end
