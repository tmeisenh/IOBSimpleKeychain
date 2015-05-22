#import <Foundation/Foundation.h>

#import "IOBAbstractKeychainStatement.h"

@interface IOBInsertKeychainItemStatement : IOBAbstractKeychainStatement

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
- (instancetype)initWithKeychainConfiguration:(IOBKeychainConfiguration *)configuration
                                      itemKey:(NSString *)itemKey
                                     itemData:(NSData *)itemData;

- (BOOL)executeStatementWithError:(NSError **)error;

@end
