//
//  MAGSocialCommandAuth.m
//  Pods
//
//  Created by Nikita Rosenberg on 24/05/2017.
//
//

#import "MAGSocialCommandAuth.h"



@implementation MAGSocialCommandAuth


- (void) executeWithSuccess:(MAGSocialNetworkSuccessCallback)success
                    failure:(MAGSocialNetworkFailureCallback)failure {
    [self.network authenticateWithParentVC:self.vc
                                   success:^(MAGSocialAuth *data) {
                                       self.result = data;
                                       success();
    }
                                   failure:^(NSError *error) {
                                       failure(error);
    }];
}




@end
