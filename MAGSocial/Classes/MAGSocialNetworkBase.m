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

@synthesize socialAuth;
@synthesize socialUser;
@synthesize preferredPhotoSize;


//MARK: - Setup
- (void)configure {
    [self configureWithApplication:nil andLaunchOptions:nil];
    self.preferredPhotoSize = 720;
}


- (void)configureWithApplication:(nullable UIApplication *)application
                andLaunchOptions:(nullable NSDictionary *)launchOptions {
    NSAssert(false, @"Should be implemented in subclasses");
}




//MARK: - Common Properties
- (nullable NSDictionary *)settings {
    return [[MAGSocial.sharedInstance settingsPlist] objectForKey:NSStringFromClass(self.class)];
}


- (nonnull NSString *)moduleName {
    return NSStringFromClass(self.class);
}

+ (nonnull NSString *)moduleName {
    return NSStringFromClass(self);
}


//MARK: - Stubs
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
            options:(NSDictionary *)options {
    NSAssert(false, @"Should be implemented in subclasses");
    return false;
}


- (BOOL)isSignedIn {
    NSAssert(false, @"Should be implemented in subclasses");
    return NO;
}


- (void)authenticateWithParentVC:(UIViewController *)parentVC
                         success:(void(^)(MAGSocialAuth *data))success
                         failure:(MAGSocialNetworkFailureCallback)failure {
    NSAssert(false, @"Should be implemented in subclasses");
}


- (void)loadMyProfile:(void (^)(MAGSocialUser * _Nonnull))success failure:(MAGSocialNetworkFailureCallback)failure {
    NSAssert(false, @"Should be implemented in subclasses");
}




@end
