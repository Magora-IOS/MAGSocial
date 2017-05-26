//
//  MAGSocialCommandBase.m
//  Pods
//
//  Created by Nikita on 26.05.17.
//
//

#import "MAGSocialCommandBase.h"



@implementation MAGSocialCommandBase
@synthesize network;


- (instancetype) initWith:(Class<MAGSocialNetwork>)paramNetwork {
    self = [self init];
    self.network = paramNetwork;
    return self;
}



- (void) executeWithSuccess:(MAGSocialNetworkSuccessCallback)success
                    failure:(MAGSocialNetworkFailureCallback)failure {
    NSAssert(false, @"Should be implemented in subclasses");
}



@end
