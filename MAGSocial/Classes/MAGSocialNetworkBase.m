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
    NSAssert(false, @"Should be implemented in subclasses");
}



//MARK: - Common Properties
+ (nullable NSDictionary *) settings {
    return [[MAGSocial settingsPlist] objectForKey:NSStringFromClass(self)];
}


+ (nonnull NSString *) moduleName {
    return NSStringFromClass(self);
}




//MARK: - Stubs
+ (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
            options:(NSDictionary *)options {
    NSAssert(false, @"Should be implemented in subclasses");
    return false;
}


+ (void)authenticateWithParentVC:(UIViewController *)parentVC
                         success:(MAGSocialNetworkSuccessCallback)success
                         failure:(MAGSocialNetworkFailureCallback)failure {
    NSAssert(false, @"Should be implemented in subclasses");
}




@end
