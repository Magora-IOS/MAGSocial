
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

#import "MAGSocialVK.h"
#import "MAGSocialUser.h"
#import <VKSdk.h>



@interface MAGSocialVK () <VKSdkDelegate, VKSdkUIDelegate>

@property (nullable, nonatomic, weak) UIViewController *parentVC;
@property (nonatomic, copy) void(^authSuccess)(MAGSocialAuth *data);
@property (nonatomic, copy) void(^userSuccess)(MAGSocialUser *data);
@property (nonatomic, copy) MAGSocialNetworkFailureCallback failure;

@end



@implementation MAGSocialVK


//MARK: - Lifecycle
/*+ (MAGSocialVK*)sharedInstance {
    static MAGSocialVK *sharedInstance = nil;
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
        if ([key isEqual: @"AppID"]) {
            [VKSdk initializeWithAppId:@"6044011"];
        }
    }];
    
    VKSdk.instance.uiDelegate = self;
    [VKSdk.instance registerDelegate:self];
}




//MARK: - Actions
- (BOOL)application:(UIApplication *)application
    openURL:(NSURL *)url
    options:(NSDictionary *)options {

    BOOL handled = [VKSdk processOpenURL:url fromApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]];
    return handled;
}


- (void)authenticateWithParentVC:(UIViewController *)parentVC
    success:(void(^)(MAGSocialAuth *data))success
    failure:(MAGSocialNetworkFailureCallback)failure {

    self.parentVC = parentVC;
    self.authSuccess = success;
    self.failure = failure;
    
    NSLog(@"%@ authenticate", self.moduleName);
    if ( [VKSdk isLoggedIn] ) {
        [VKSdk forceLogout];
    }
    [VKSdk authorize:@[@"email"]];
}


- (void)loadMyProfile:(void (^)(MAGSocialUser * _Nonnull))success failure:(MAGSocialNetworkFailureCallback)failure {
    /*self.userSuccess = success;
    self.failure = failure;
    
    NSLog(@"%@ load profile", self.moduleName);
    //if ( [VKSdk isLoggedIn] == NO ) {
        //[VKSdk forceLogout];
        [VKSdk authorize:@[@"email"]];
    //}
     */
    
    MAGSocialUser *result = self.socialAuth.userData;
    if (result) {
        success(result);
    } else {
        failure([NSError errorWithDomain:@"MAGSocialVK" code:1 userInfo:@{NSLocalizedDescriptionKey : @"Not authorized user"}]);
    }
}


- (void)vkSdkAccessAuthorizationFinishedWithResult:(VKAuthorizationResult *)result {
    if (result.token) {
        [self.parentVC dismissViewControllerAnimated:true completion:nil];
        
        if (self.authSuccess) {
            self.authSuccess([self createAuth:result]);
        }
        if (self.userSuccess) {
            self.userSuccess([self createUser:result.user]);
        }
        NSLog(@"%@. Successful authentication", self.moduleName);
    } else if (result.error) {
        NSLog(@"%@. Could not authorize: '%@'", self.moduleName, result.error);
        if (self.failure) {
            self.failure(result.error);
        }
    }
    
    self.authSuccess = nil;
    self.userSuccess = nil;
    self.failure = nil;
}


- (void)vkSdkUserAuthorizationFailed {
    NSLog(@"%@. Could not authorize", self.moduleName);
    self.failure(nil);
}


- (void)vkSdkShouldPresentViewController:(UIViewController *)controller {
    [self.parentVC presentViewController:controller animated:YES completion:nil];
}


- (void)vkSdkNeedCaptchaEnter:(VKError *)captchaError {
    //TODO: captcha ui
}


- (MAGSocialAuth *)createAuth:(VKAuthorizationResult *)raw {
    MAGSocialAuth *result = [[MAGSocialAuth alloc] initWith:raw];
    result.token = raw.token.accessToken;
    result.userID = raw.user.id.stringValue;
    result.userData = [self createUser:raw.user];
    return result;
}


- (MAGSocialUser *) createUser:(VKUser *)raw {
    MAGSocialUser *result = [[MAGSocialUser alloc] initWith:raw];
    result.objectID = raw.id.stringValue;
    result.name = [NSString stringWithFormat:@"%@ %@", raw.first_name, raw.last_name];
    result.email = nil;
    result.firstName = raw.first_name;
    result.lastName = raw.last_name;
    result.gender = raw.sex.stringValue;
    result.pictureUrl = raw.photo_max_orig;
    return result;
}






@end

