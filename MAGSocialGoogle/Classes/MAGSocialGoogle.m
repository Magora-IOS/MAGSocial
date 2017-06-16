
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
@property (nonatomic, copy) void(^authSuccess)(MAGSocialAuth *data);
@property (nonatomic, copy) void(^userSuccess)(MAGSocialUser *data);
@property (nonatomic, copy) MAGSocialNetworkFailureCallback failure;

@end



@implementation MAGSocialGoogle

//MARK: - Lifecycle
/*+ (MAGSocialGoogle*)sharedInstance {
    static MAGSocialGoogle *sharedInstance = nil;
    @synchronized(self) {
        if (sharedInstance == nil)
            sharedInstance = [[self alloc] init];
    }
    return sharedInstance;
}*/



//MARK: - Configuration
- (void)configureWithApplication:(UIApplication *)application
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
    
    [GIDSignIn sharedInstance].delegate = self;
    [GIDSignIn sharedInstance].uiDelegate = self;
}






- (BOOL)application:(UIApplication *)application
    openURL:(NSURL *)url
    options:(NSDictionary *)options {

    BOOL handled =
    [[GIDSignIn sharedInstance] handleURL:url
                        sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
                               annotation:options[UIApplicationOpenURLOptionsAnnotationKey]];
    return handled;
}


- (BOOL)isSignedIn {
    if ([[GIDSignIn sharedInstance] currentUser]) {
        return YES;
    }
    return NO;
}



//MARK: - Auth
- (void)authenticateWithParentVC:(UIViewController *)parentVC
                         success:(void(^)(MAGSocialAuth *data))success
                         failure:(MAGSocialNetworkFailureCallback)failure {

    self.parentVC = parentVC;
    self.authSuccess = success;
    self.failure = failure;
    
    NSLog(@"%@ authenticate", self.moduleName);
    [[GIDSignIn sharedInstance] signIn];
}


- (void)signIn:(GIDSignIn *)signIn didSignInForUser:(GIDGoogleUser *)user
    withError:(NSError *)error {
    if (error)
    {
        NSLog(@"%@. Could not authorize: '%@'", self.moduleName, error);
        if (self.failure) {
            self.failure(error);
        }
    }
    else {
        if (self.authSuccess) {
            self.authSuccess([self createAuth:user]);
        }
        if (self.userSuccess) {
            self.userSuccess([self createUser:user]);
        }
        NSLog(@"%@. Successful authentication", self.moduleName);
    }
    
    self.authSuccess = nil;
    self.userSuccess = nil;
    self.failure = nil;
}


- (void)loadMyProfile:(void (^)(MAGSocialUser * _Nonnull))success failure:(MAGSocialNetworkFailureCallback)failure {
    self.userSuccess = success;
    self.failure = failure;
    
    [[GIDSignIn sharedInstance] signIn];
}


- (MAGSocialAuth *)createAuth:(GIDGoogleUser *)raw {
    MAGSocialAuth *result = [[MAGSocialAuth alloc] initWith:raw];
    result.token = raw.authentication.accessToken;
    result.userID = raw.userID;
    result.userData = [self createUser:raw];
    return result;
}


- (MAGSocialUser *)createUser:(GIDGoogleUser *)raw {
    MAGSocialUser *result = [[MAGSocialUser alloc] initWith:raw];
    result.objectID = raw.userID;
    result.name = raw.profile.name;
    result.email = raw.profile.email;
    result.firstName = raw.profile.givenName;
    result.lastName = raw.profile.familyName;
    result.pictureUrl = [raw.profile imageURLWithDimension:self.preferredPhotoSize].absoluteString;
    return result;
}


- (void)signIn:(GIDSignIn *)signIn presentViewController:(UIViewController *)viewController {
    [self.parentVC presentViewController:viewController animated:YES completion:nil];
}


- (void)signIn:(GIDSignIn *)signIn dismissViewController:(UIViewController *)viewController {
    [self.parentVC dismissViewControllerAnimated:YES completion:nil];
}


@end

