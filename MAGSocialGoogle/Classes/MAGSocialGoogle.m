
/*

Copyright (c) 2017 Magora Systems

This software is provided 'as-is', without any express or implied
warranty. In no event will the authors be held liable for any damages
arising from the use of this software.

Permission is granted to anyone to use this software for any purpose,
including commercial applications, and to alter it and redistribute it
freely, subject to the following restrictions:

1. The origin of this software must not be misrepresented; you must not
   claim that you wrote the original software. If you use this software
   in a product, an acknowledgment in the product documentation would be
   appreciated but is not required.
2. Altered source versions must be plainly marked as such, and must not be
   misrepresented as being the original software.
3. This notice may not be removed or altered from any source distribution.

*/

#import "MAGSocialGoogle.h"
#import "MAGSocialUser.h"
#import <Google/SignIn.h>



@interface MAGSocialGoogle () <GIDSignInDelegate, GIDSignInUIDelegate>

@property (nullable, nonatomic, weak) UIViewController *parentVC;
@property (nonatomic, strong) void(^authSuccess)(MAGSocialAuth *data);
@property (nonatomic, strong) MAGSocialNetworkFailureCallback failure;

@end



@implementation MAGSocialGoogle

//MARK: - Lifecycle
+ (MAGSocialGoogle*)sharedInstance {
    static MAGSocialGoogle *sharedInstance = nil;
    @synchronized(self) {
        if (sharedInstance == nil)
            sharedInstance = [[self alloc] init];
    }
    return sharedInstance;
}



//MARK: - Configuration
+ (void)configureWithApplication:(UIApplication *)application
                andLaunchOptions:(NSDictionary *)launchOptions {
    [[self settings] enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *value, BOOL* stop) {
        if ([key isEqual: @"CLIENT_ID"]) {
            [GIDSignIn sharedInstance].clientID = value;
        }
    }];
    
    /*
    NSError* configureError;
    [[GGLContext sharedInstance] configureWithError: &configureError];
    //TODO: throw exception?
    NSAssert(!configureError, @"Error configuring Google services: %@", configureError);
     */
    
    [GIDSignIn sharedInstance].delegate = [self sharedInstance];
    [GIDSignIn sharedInstance].uiDelegate = [self sharedInstance];
}






+ (BOOL)application:(UIApplication *)application
    openURL:(NSURL *)url
    options:(NSDictionary *)options {

    BOOL handled =
    [[GIDSignIn sharedInstance] handleURL:url
                        sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
                               annotation:options[UIApplicationOpenURLOptionsAnnotationKey]];
    return handled;
}



//MARK: - Auth
+ (void)authenticateWithParentVC:(UIViewController *)parentVC
                         success:(void(^)(MAGSocialAuth *data))success
                         failure:(MAGSocialNetworkFailureCallback)failure {

    [self sharedInstance].parentVC = parentVC;
    [self sharedInstance].authSuccess = success;
    [self sharedInstance].failure = failure;
    
    NSLog(@"%@ authenticate", self.moduleName);
    [[GIDSignIn sharedInstance] signIn];
}


- (void)signIn:(GIDSignIn *)signIn
didSignInForUser:(GIDGoogleUser *)user
    withError:(NSError *)error {
    if (error)
    {
        NSLog(@"%@. Could not authorize: '%@'", self.class.moduleName, error);
        self.failure(error);
    }
    else {
        self.authSuccess([self.class createAuth:user]);
        NSLog(@"%@. Successful authentication", self.class.moduleName);
    }
}


+ (MAGSocialAuth *) createAuth:(GIDGoogleUser *)raw {
    MAGSocialAuth *result = [[MAGSocialAuth alloc] initWith:raw];
    result.token = raw.authentication.accessToken;
    result.userData = [self createUser:raw];
    return result;
}


+ (MAGSocialUser *) createUser:(GIDGoogleUser *)raw {
    MAGSocialUser *result = [[MAGSocialUser alloc] initWith:raw];
    result.objectID = raw.userID;
    result.name = raw.profile.name;
    result.email = raw.profile.email;
    return result;
}


- (void)signIn:(GIDSignIn *)signIn
presentViewController:(UIViewController *)viewController {
    [self.parentVC presentViewController:viewController animated:YES completion:nil];
}


- (void)signIn:(GIDSignIn *)signIn
dismissViewController:(UIViewController *)viewController {
    [self.parentVC dismissViewControllerAnimated:YES completion:nil];
}


@end

