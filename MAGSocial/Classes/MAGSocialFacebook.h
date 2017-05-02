
#include "MAGSocialNetwork.h"

@interface MAGSocialFacebook: NSObject <MAGSocialNetwork>

+ (void)authenticateWithParentVC:(UIViewController *)parentVC
    success:(MAGSocialNetworkSuccessCallback)success
    failure:(MAGSocialNetworkFailureCallback)failure;

@end

