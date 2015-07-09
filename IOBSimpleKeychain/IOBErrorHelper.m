#import "IOBErrorHelper.h"

@implementation IOBErrorHelper

- (BOOL)buildError:(NSError **)error
         errorCode:(NSUInteger)errorCode
      errorMessage:(NSString *)errorMessage {
    
    return [IOBErrorHelper buildError:error
                            errorCode:errorCode
                         errorMessage:errorMessage];
}

+ (BOOL)buildError:(NSError **)error
         errorCode:(NSUInteger)errorCode
      errorMessage:(NSString *)errorMessage {
    
    if (!error) {
        return NO;
    }
    
    *error = [NSError errorWithDomain:@"com.indexoutofbounds.iobsimplekeychain"
                                 code:errorCode
                             userInfo:@{NSLocalizedDescriptionKey : errorMessage}];
    return YES;
}

@end
