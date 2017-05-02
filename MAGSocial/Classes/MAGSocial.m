
#import "MAGSocial.h"

@interface MAGSocial ()

@end

@implementation MAGSocial

+ (void)authenticateNetwork:(Class<MAGSocialNetwork>)networkClass
    withParentVC:(UIViewController *)parentVC
    success:(MAGSocialNetworkSuccessCallback)success
    failure:(MAGSocialNetworkFailureCallback)failure {

    [networkClass
        authenticateWithParentVC:parentVC
        success:success
        failure:failure];
}

+ (void)registerNetwork:(Class<MAGSocialNetwork>)networkClass {
    NSLog(@"MAGSocial.registerNetwork: '%@'", networkClass);
}

@end

