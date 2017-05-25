
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
#import <VKSdk.h>



@interface MAGSocialVK () <VKSdkDelegate, VKSdkUIDelegate>

@property (nullable, nonatomic, weak) UIViewController *parentVC;
@property (nonatomic, strong) MAGSocialNetworkSuccessCallback success;
@property (nonatomic, strong) MAGSocialNetworkFailureCallback failure;

@end



@implementation MAGSocialVK


//MARK: - Lifecycle
+ (MAGSocialVK*)sharedInstance {
    static MAGSocialVK *sharedInstance = nil;
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
        if ([key isEqual: @"AppID"]) {
            [VKSdk initializeWithAppId:@"6044011"];
        }
    }];
    
    VKSdk.instance.uiDelegate = [self sharedInstance];
    [VKSdk.instance registerDelegate:[self sharedInstance]];
}





+ (BOOL)application:(UIApplication *)application
    openURL:(NSURL *)url
    options:(NSDictionary *)options {

    BOOL handled = [VKSdk processOpenURL:url fromApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]];
    return handled;
}


+ (void)authenticateWithParentVC:(UIViewController *)parentVC
    success:(MAGSocialNetworkSuccessCallback)success
    failure:(MAGSocialNetworkFailureCallback)failure {

    [self sharedInstance].parentVC = parentVC;
    [self sharedInstance].success = success;
    [self sharedInstance].failure = failure;
    
    NSLog(@"%@. authenticate. VC: '%@'", self.moduleName, parentVC);
    [VKSdk authorize:@[@"email"]];
}




//MARK: - VKSdkDelegate
- (void)vkSdkAccessAuthorizationFinishedWithResult:(VKAuthorizationResult *)result {
    if (result.token) {
        self.success();
        NSLog(@"%@. Successful authentication", self.class.moduleName);
    } else if (result.error) {
        NSLog(@"%@. Could not authorize: '%@'", self.class.moduleName, result.error);
        self.failure(result.error);
    }
}

- (void)vkSdkUserAuthorizationFailed {
    NSLog(@"%@. Could not authorize", self.class.moduleName);
    self.failure(nil);
}




//MARK: - VKSdkUIDelegate
- (void)vkSdkShouldPresentViewController:(UIViewController *)controller {
    [self.parentVC presentViewController:controller animated:YES completion:nil];
}





- (void)vkSdkNeedCaptchaEnter:(VKError *)captchaError {
    //TODO: captcha ui
}


@end

