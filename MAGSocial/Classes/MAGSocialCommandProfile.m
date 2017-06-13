//
//  MAGSocialCommandProfile.m
//  Pods
//
//  Created by Nikita on 26.05.17.
//
//

#import "MAGSocialCommandProfile.h"

@implementation MAGSocialCommandProfile

- (void)executeWithSuccess:(MAGSocialNetworkSuccessCallback)success
                   failure:(MAGSocialNetworkFailureCallback)failure {
    
    [self.network loadMyProfile:^(MAGSocialUser *user) {
        self.result = user;
        success();
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end
