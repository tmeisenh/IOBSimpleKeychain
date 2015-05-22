#import <Foundation/Foundation.h>

#import "IOBAbstractKeychainStatement.h"

@interface IOBDeleteKeychainItemStatement : IOBAbstractKeychainStatement

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
- (instancetype)initWithKeychainConfiguration:(IOBKeychainConfiguration *)configuration
                                      itemKey:(NSString *)itemKey;

- (BOOL)executeStatementWithError:(NSError **)error;

@end
