#import <Foundation/Foundation.h>

#import "IOBKeychainConfiguration.h"

@interface IOBAbstractKeychainStatement : NSObject

@property (nonatomic, readonly) IOBKeychainConfiguration *configuration;

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
- (instancetype)initWithKeychainConfiguration:(IOBKeychainConfiguration *)keychainConfiguration;

- (void)buildError:(NSError **)error
      errorMessage:(NSString *)errorMessage;

- (NSMutableDictionary *)commonAttributesQuery;

@end
