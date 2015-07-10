#import <Foundation/Foundation.h>

#import "IOBAbstractKeychainStatement.h"

@interface IOBFetchKeychainItemStatement : IOBAbstractKeychainStatement

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
- (instancetype)initWithKeychainConfiguration:(IOBKeychainConfiguration *)configuration
                                      itemKey:(NSString *)itemKey;

@property (nonatomic, readonly) NSMutableData *resultData;

- (BOOL)executeStatementWithError:(NSError **)error;

@end
