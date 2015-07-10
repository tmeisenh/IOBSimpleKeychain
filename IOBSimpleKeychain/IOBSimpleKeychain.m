#import "IOBSimpleKeychain.h"

#import "IOBInsertKeychainItemStatement.h"
#import "IOBExistsKeychainItemStatement.h"
#import "IOBFetchKeychainItemStatement.h"
#import "IOBUpdateKeychainItemStatement.h"
#import "IOBDeleteKeychainItemStatement.h"

#import "IOBErrorHelper.h"

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
        NSAssert(serviceName.length > 0 , @"Service name is required to allow for uniqueness of items in the keychain.");
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

- (BOOL)putData:(NSData *)data
          atKey:(NSString *)key {
    
    return [self putData:data
                   atKey:key
                   error:nil];
}

- (BOOL)putString:(NSString *)string
            atKey:(NSString *)key {
    
    return [self putString:string
                     atKey:key
                     error:nil];
}

- (BOOL)putString:(NSString *)string
            atKey:(NSString *)key
            error:(NSError **)error {
    
    return [self putData:[string dataUsingEncoding:NSASCIIStringEncoding]
                   atKey:key
                   error:error];
}

- (BOOL)putData:(NSData *)data
          atKey:(NSString *)key
          error:(NSError **)error {
    
    if ([self isValidForSavingKey:key data:data]) {
        [IOBErrorHelper buildError:error
                         errorCode:0
                      errorMessage:@"Invalid arguments"];
        return NO;
    }
    
    BOOL itemAlreadyExistsInKeychain = [self itemExistsInKeychainWithKey:key];
    
    if (itemAlreadyExistsInKeychain) {
        return [self updateItemIntoKeychain:data atKey:key error:error];
    } else {
        return [self insertItemIntoKeychain:data atKey:key error:error];
    }
}

#pragma mark - Remove item

- (BOOL)removeItemForKey:(NSString *)key {
    IOBDeleteKeychainItemStatement *statement = [[IOBDeleteKeychainItemStatement alloc] initWithKeychainConfiguration:self.keychainConfiguration
                                                                                                              itemKey:key];
    
    return [statement executeStatementWithError:nil];
}

#pragma mark - Private API

- (BOOL)isValidForSavingKey:(NSString *)key data:(NSData *)data {
    return (key.length < 1 || data.length < 1);
}

#pragma mark - Item Exists
- (BOOL)itemExistsInKeychainWithKey:(NSString *)key {
    IOBExistsKeychainItemStatement *statement = [[IOBExistsKeychainItemStatement alloc] initWithKeychainConfiguration:self.keychainConfiguration
                                                                                                              itemKey:key];
    
    return [statement executeStatementWithError:nil];
}

#pragma mark - Insert item

- (BOOL)insertItemIntoKeychain:(NSData *)data
                         atKey:(NSString *)key
                         error:(NSError **)error {
    
    IOBInsertKeychainItemStatement *statement = [[IOBInsertKeychainItemStatement alloc] initWithKeychainConfiguration:self.keychainConfiguration
                                                                                                              itemKey:key
                                                                                                             itemData:data];
    return [statement executeStatementWithError:nil];
}

#pragma mark - Update item

- (BOOL)updateItemIntoKeychain:(NSData *)data
                         atKey:(NSString *)key
                         error:(NSError **)error {
    
    IOBUpdateKeychainItemStatement *statement = [[IOBUpdateKeychainItemStatement alloc] initWithKeychainConfiguration:self.keychainConfiguration
                                                                                                              itemKey:key
                                                                                                             itemData:data];
    
    return [statement executeStatementWithError:error];
}

@end
