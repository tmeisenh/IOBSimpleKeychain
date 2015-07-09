#import <Foundation/Foundation.h>

#import "IOBKeychainConfiguration.h"

@interface IOBAbstractKeychainStatement : NSObject

@property (nonatomic, readonly) IOBKeychainConfiguration *keychainConfiguration;
@property (nonatomic, readonly) NSString *itemKey;

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
- (instancetype)initWithKeychainConfiguration:(IOBKeychainConfiguration *)keychainConfiguration
                                      itemKey:(NSString *)itemKey NS_DESIGNATED_INITIALIZER;

- (BOOL)buildError:(NSError **)error
         errorCode:(NSUInteger)errorCode
      errorMessage:(NSString *)errorMessage;

- (NSMutableDictionary *)commonAttributesQuery;

@end
