#import "IOBAbstractKeychainStatement.h"

#import "IOBErrorHelper.h"

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
    
    return [IOBErrorHelper buildError:error
                            errorCode:errorCode
                         errorMessage:errorMessage];
}

- (NSMutableDictionary *)commonAttributesQuery {
    // We intentionally just want kSecClassGenericPassword since we're storing plain uncategorized data
    NSMutableDictionary *query = [self requiredAttributesForGenericPassword];
    query[(__bridge __strong id)kSecAttrSynchronizable] = (__bridge id)kSecAttrSynchronizableAny;

#if !TARGET_IPHONE_SIMULATOR
    
    // @see https://developer.apple.com/library/ios/samplecode/GenericKeychain/Listings/Classes_KeychainItemWrapper_m.html
    // Ignore the access group if running on the iPhone simulator.
    //
    // Apps that are built for the simulator aren't signed, so there's no keychain access group
    // for the simulator to check. This means that all apps can see all keychain items when run
    // on the simulator.
    //
    // If a SecItem contains an access group attribute, SecItemAdd and SecItemUpdate on the
    // simulator will return -25243 (errSecNoAccessForItem).
    
    if (self.keychainConfiguration.accessGroup) {
        query[(__bridge __strong id)kSecAttrAccessGroup] = self.keychainConfiguration.accessGroup;
    }
    
#endif
    
    return query;
}

- (NSMutableDictionary *)requiredAttributesForGenericPassword {
    NSMutableDictionary *query = [[NSMutableDictionary alloc] init];
    /*
     * An item of kSecClassGenericPassword needs kSecAttrAccount and kSecAttrService for uniqueness.  These are the composite primary keys, in database speak.
     * @see http://www.opensource.apple.com/source/libsecurity_cdsa_utilities/libsecurity_cdsa_utilities-55006/lib/Schema.m4
     */
    query[(__bridge __strong id)kSecClass] = (__bridge id) kSecClassGenericPassword;
    query[(__bridge __strong id)kSecAttrAccount] = self.itemKey;
    query[(__bridge __strong id)kSecAttrService] = self.keychainConfiguration.service;
    
    return query;
}

@end
