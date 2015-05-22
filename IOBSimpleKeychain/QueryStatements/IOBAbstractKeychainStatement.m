#import "IOBAbstractKeychainStatement.h"

@interface IOBAbstractKeychainStatement()

@property (nonatomic, readwrite) IOBKeychainConfiguration *keychainConfiguration;

@end

@implementation IOBAbstractKeychainStatement

- (instancetype)initWithKeychainConfiguration:(IOBKeychainConfiguration *)keychainConfiguration {
    
    self = [super init];
    if (self) {
        _keychainConfiguration = keychainConfiguration;
    }
    return self;
}

- (void)buildError:(NSError **)error
      errorMessage:(NSString *)errorMessage {
    
    if (error) {
        *error = [NSError errorWithDomain:@"com.indexoutofbounds.iobsimplekeychain"
                                     code:0
                                 userInfo:@{NSLocalizedDescriptionKey : errorMessage}];
    }
}

- (NSMutableDictionary *)commonAttributesQuery {
    NSMutableDictionary *query = [[NSMutableDictionary alloc] init];
    
    // We intentionally just want generic password since we're storing plain uncategorized data
    query[(__bridge __strong id)kSecClass] = (__bridge id) kSecClassGenericPassword;
    query[(__bridge __strong id)kSecAttrSynchronizable] = (__bridge id)kSecAttrSynchronizableAny;
    
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
