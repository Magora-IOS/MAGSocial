
#include "MAGSocialNetwork.h"

@interface MAGSocial: NSObject

+ (void)authenticateNetwork:(Class<MAGSocialNetwork>)networkClass
    withParentVC:(UIViewController *)parentVC
    success:(MAGSocialNetworkSuccessCallback)success
    failure:(MAGSocialNetworkFailureCallback)failure;
+ (void)registerNetwork:(Class<MAGSocialNetwork>)networkClass;

@end

