#import "IOBInsertKeychainItemStatement.h"
#import "IOBKeychainConfiguration.h"

@interface IOBInsertKeychainItemStatement()

@property (nonatomic) NSData *itemData;

@end

@implementation IOBInsertKeychainItemStatement

- (instancetype)initWithKeychainConfiguration:(IOBKeychainConfiguration *)configuration
                                      itemKey:(NSString *)itemKey
                                     itemData:(NSData *)itemData {
    
    if (self = [super initWithKeychainConfiguration:configuration
                                            itemKey:itemKey]) {
        _itemData = itemData;
    }
    return self;
}

- (BOOL)executeStatementWithError:(NSError **)error {
    
    NSMutableDictionary *attributes = [self commonAttributesQuery];
    attributes[(__bridge __strong id)kSecValueData] = self.itemData;
    attributes[(__bridge __strong id)kSecAttrAccessible] = (__bridge id)self.keychainConfiguration.keychainAccessibility;
    
    OSStatus status = SecItemAdd((__bridge CFDictionaryRef)attributes,
                                 NULL);
    
    if (status != errSecSuccess) {
        [self buildError:error
               errorCode:status
            errorMessage:[NSString stringWithFormat:@"Unable to insert item at key %@", self.itemKey]];
        return NO;
    }
    return YES;
}

@end
