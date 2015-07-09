#import "IOBAbstractKeychainStatement.h"

@interface IOBAbstractKeychainStatement()

@property (nonatomic, readwrite) IOBKeychainConfiguration *keychainConfiguration;
@property (nonatomic, readwrite) NSString *itemKey;

@end

@implementation IOBAbstractKeychainStatement

- (instancetype)initWithKeychainConfiguration:(IOBKeychainConfiguration *)keychainConfiguration
                                      itemKey:(NSString *)itemKey {
    
    self = [super init];
    if (self) {
        _keychainConfiguration = keychainConfiguration;
        _itemKey = itemKey;
    }
    return self;
}


- (BOOL)buildError:(NSError **)error
         errorCode:(NSUInteger)errorCode
      errorMessage:(NSString *)errorMessage {
    
    if (error) {
        *error = [NSError errorWithDomain:@"com.indexoutofbounds.iobsimplekeychain"
                                     code:errorCode
                                 userInfo:@{NSLocalizedDescriptionKey : errorMessage}];
    }
    return error == nil;
}

- (NSMutableDictionary *)commonAttributesQuery {
    NSMutableDictionary *query = [[NSMutableDictionary alloc] init];
    
    // We intentionally just want generic password since we're storing plain uncategorized data
    query[(__bridge __strong id)kSecClass] = (__bridge id) kSecClassGenericPassword;
    query[(__bridge __strong id)kSecAttrSynchronizable] = (__bridge id)kSecAttrSynchronizableAny;
    query[(__bridge __strong id)kSecAttrAccount] = self.itemKey;

    query[(__bridge __strong id)(kSecAttrService)] = self.keychainConfiguration.service;
    
    // Simulator does not support access groups.
#if !TARGET_IPHONE_SIMULATOR
    if (self.keychainConfiguration.accessGroup) {
        query[(__bridge __strong id)kSecAttrAccessGroup] = self.keychainConfiguration.accessGroup;
    }
#endif
    
    return query;
}

@end
