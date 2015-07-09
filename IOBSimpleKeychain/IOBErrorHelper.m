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
    
    NSString *errorUserInfoDescription = errorMessage ?: @"Consider adding an error message to aid debugging.";

    *error = [NSError errorWithDomain:@"com.indexoutofbounds.iobsimplekeychain"
                                 code:errorCode
                             userInfo:@{NSLocalizedDescriptionKey : errorUserInfoDescription}];
    return YES;
}

@end
