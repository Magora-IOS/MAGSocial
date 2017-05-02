
#import "MAGSocialFacebook.h"

@interface MAGSocialFacebook ()

@end

@implementation MAGSocialFacebook

+ (void)authenticateWithParentVC:(UIViewController *)parentVC
    success:(MAGSocialNetworkSuccessCallback)success
    failure:(MAGSocialNetworkFailureCallback)failure {

    NSLog(@"MAGSocialFacebook.authenticate VC: '%@'", parentVC);
}

@end

