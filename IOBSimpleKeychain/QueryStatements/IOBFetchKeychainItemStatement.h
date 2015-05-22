#import <Foundation/Foundation.h>

#import "IOBAbstractKeychainStatement.h"

@interface IOBFetchKeychainItemStatement : IOBAbstractKeychainStatement

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
- (instancetype)initWithKeychainConfiguration:(IOBKeychainConfiguration *)configuration
                                      itemKey:(NSString *)itemKey;

- (NSMutableData *)executeStatementWithError:(NSError **)error;

@end
