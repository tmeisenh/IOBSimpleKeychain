#import "IOBUpdateKeychainItemStatement.h"
#import "IOBKeychainConfiguration.h"

@interface IOBUpdateKeychainItemStatement()

@property (nonatomic) NSData *itemData;

@end

@implementation IOBUpdateKeychainItemStatement

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
    
    NSMutableDictionary *query = [self commonAttributesQuery];

    NSMutableDictionary *attributes = [[NSMutableDictionary alloc] initWithCapacity:1];
    attributes[(__bridge __strong id)kSecValueData] = self.itemData;
    
    OSStatus status = SecItemUpdate((__bridge CFDictionaryRef)query,
                                    (__bridge CFDictionaryRef)attributes);
    
    if (status != errSecSuccess) {
        [self buildError:error
               errorCode:status
            errorMessage:[NSString stringWithFormat:@"Unable to update item at key %@", self.itemKey]];
        return NO;
    }
    return YES;
}


@end
