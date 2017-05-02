
#include <Foundation/Foundation.h>

typedef void (^MAGSocialNetworkSuccessCallback)();
typedef void (^MAGSocialNetworkFailureCallback)(NSError *error);

@protocol MAGSocialNetwork

+ (void)authenticateWithParentVC:(UIViewController *)parentVC
    success:(MAGSocialNetworkSuccessCallback)success
    failure:(MAGSocialNetworkFailureCallback)failure;

@end

