//
//  MAGSocialCommandAuth.h
//  Pods
//
//  Created by Nikita Rosenberg on 24/05/2017.
//
//

#import "MAGSocialCommand.h"
#import "MAGSocialAuth.h"


@interface MAGSocialCommandAuth : NSObject <MAGSocialCommand>

@property (nullable, nonatomic, weak) UIViewController *vc;
@property (nullable, nonatomic, strong) MAGSocialAuth *result;

@end
