//
//  MAGSocialCommandAuth.h
//  Pods
//
//  Created by Nikita Rosenberg on 24/05/2017.
//
//

#import "MAGSocialCommandBase.h"
#import "MAGSocialAuth.h"


@interface MAGSocialCommandAuth : MAGSocialCommandBase

@property (nullable, nonatomic, weak) UIViewController *vc;
@property (nullable, nonatomic, strong) MAGSocialAuth *result;

@end
