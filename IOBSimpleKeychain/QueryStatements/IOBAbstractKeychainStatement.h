#import <Foundation/Foundation.h>

#import "IOBKeychainConfiguration.h"

@interface IOBAbstractKeychainStatement : NSObject

@property (nonatomic, readonly) IOBKeychainConfiguration *keychainConfiguration;

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
- (instancetype)initWithKeychainConfiguration:(IOBKeychainConfiguration *)keychainConfiguration;

- (BOOL)buildError:(NSError **)error
         errorCode:(NSUInteger)errorCode
      errorMessage:(NSString *)errorMessage;

- (NSMutableDictionary *)commonAttributesQuery;

@end
