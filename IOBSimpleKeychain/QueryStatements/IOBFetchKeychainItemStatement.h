#import <Foundation/Foundation.h>

#import "IOBAbstractKeychainStatement.h"

@interface IOBFetchKeychainItemStatement : IOBAbstractKeychainStatement

@property (nonatomic, readonly) NSDictionary *fetchedAttributes;

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
- (instancetype)initWithKeychainConfiguration:(IOBKeychainConfiguration *)configuration
                                      itemKey:(NSString *)itemKey;

- (NSMutableData *)executeStatementWithError:(NSError **)error;

@end
