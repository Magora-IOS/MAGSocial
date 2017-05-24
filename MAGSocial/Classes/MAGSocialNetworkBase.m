//
//  MAGSocialNetworkBase
//  Pods
//
//  Created by Nikita Rosenberg on 24/05/2017.
//
//

#import "MAGSocialNetworkBase.h"
#import "MAGSocial.h"



@implementation MAGSocialNetworkBase


//MARK: - Configuration
+ (void)configure {
    [self configureWithApplication:nil andLaunchOptions:nil];
}


+ (void)configureWithApplication:(nullable UIApplication *)application
                andLaunchOptions:(nullable NSDictionary *)launchOptions {
    
}


+ (nullable NSDictionary *) settings {
    return [[MAGSocial settingsPlist] objectForKey:NSStringFromClass(self)];
}


@end
