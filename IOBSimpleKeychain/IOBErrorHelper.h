#import <Foundation/Foundation.h>

@interface IOBErrorHelper : NSObject

- (BOOL)buildError:(NSError **)error
         errorCode:(NSUInteger)errorCode
      errorMessage:(NSString *)errorMessage;

+ (BOOL)buildError:(NSError **)error
         errorCode:(NSUInteger)errorCode
      errorMessage:(NSString *)errorMessage;

@end
