#import "IOBSimpleKeychain.h"

#import "IOBInsertKeychainItemStatement.h"
#import "IOBExistsKeychainItemStatement.h"
#import "IOBFetchKeychainItemStatement.h"
#import "IOBUpdateKeychainItemStatement.h"
#import "IOBDeleteKeychainItemStatement.h"

@interface IOBSimpleKeychain()

@property (nonatomic) IOBKeychainConfiguration *keychainConfiguration;

@end

@implementation IOBSimpleKeychain

- (instancetype)initWithServiceName:(NSString *)serviceName {
    return [self initWithServiceName:serviceName sharedKeychainAccessGroup:@""];
}

- (instancetype)initWithServiceName:(NSString *)serviceName
          sharedKeychainAccessGroup:(NSString *)sharedKeychainAccessGroup {
    
    if (self = [super init]) {
        NSAssert(serviceName.length > 0 , @"Service name is required");
        _keychainConfiguration = [[IOBKeychainConfiguration alloc] initWithService:serviceName accessGroup:sharedKeychainAccessGroup];
    }
    return self;
}

#pragma mark - Get items

- (NSMutableData *)dataForKey:(NSString *)key {
    
    IOBFetchKeychainItemStatement *statement = [[IOBFetchKeychainItemStatement alloc] initWithKeychainConfiguration:self.keychainConfiguration
                                                                                                            itemKey:key];
    return [statement executeStatementWithError:nil];
}

- (NSMutableString *)stringForKey:(NSString *)key {
    NSData *data = [self dataForKey:key];
    return (data) ? [[NSMutableString alloc] initWithData:data
                                                 encoding:NSASCIIStringEncoding] : nil;
}

#pragma mark - Put items

- (BOOL)putData:(NSData *)data atKey:(NSString *)key {
    NSAssert(key.length > 0, @"Key must not be nil.");
    BOOL itemAlreadyExistsInKeychain = [self itemExistsInKeychainWithKey:key];
    
    if (itemAlreadyExistsInKeychain) {
        return [self updateItemIntoKeychain:data atKey:key];
    } else {
        return [self insertItemIntoKeychain:data atKey:key];
    }
}

- (BOOL)putString:(NSString *)string atKey:(NSString *)key {
    return [self putData:[string dataUsingEncoding:NSASCIIStringEncoding] atKey:key];
}

#pragma mark - Remove item

- (BOOL)removeItemForKey:(NSString *)key {
    IOBDeleteKeychainItemStatement *statement = [[IOBDeleteKeychainItemStatement alloc] initWithKeychainConfiguration:self.keychainConfiguration
                                                                                                              itemKey:key];
    
    return [statement executeStatementWithError:nil];
}

- (NSString *)bundleSeedId {
    NSString *bundleSeedKey = @"IOBBundleSeedId";
    if ([self itemExistsInKeychainWithKey:bundleSeedKey]) {
        
    } else {
        
    }
    return nil;
}

#pragma mark - Private API


#pragma mark - Item Exists
- (BOOL)itemExistsInKeychainWithKey:(NSString *)key {
    IOBExistsKeychainItemStatement *statement = [[IOBExistsKeychainItemStatement alloc] initWithKeychainConfiguration:self.keychainConfiguration
                                                                                                              itemKey:key];
    
    return [statement executeStatementWithError:nil];
}

#pragma mark - Insert item

- (BOOL)insertItemIntoKeychain:(NSData *)data atKey:(NSString *)key {
    
    IOBInsertKeychainItemStatement *statement = [[IOBInsertKeychainItemStatement alloc] initWithKeychainConfiguration:self.keychainConfiguration
                                                                                                              itemKey:key
                                                                                                             itemData:data];
    return [statement executeStatementWithError:nil];
}

#pragma mark - Update item

- (BOOL)updateItemIntoKeychain:(NSData *)data atKey:(NSString *)key {
    
    IOBUpdateKeychainItemStatement *statement = [[IOBUpdateKeychainItemStatement alloc] initWithKeychainConfiguration:self.keychainConfiguration
                                                                                                              itemKey:key
                                                                                                             itemData:data];
    
    return [statement executeStatementWithError:nil];
}

@end
