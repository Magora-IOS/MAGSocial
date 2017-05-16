
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

#import "MAGSocialTwitter.h"

// TODO Twitter imports

@interface MAGSocialTwitter ()

@end

@implementation MAGSocialTwitter

+ (void)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    /*
     * TODO
     *
    [[FBSDKApplicationDelegate sharedInstance]
        application:application
        didFinishLaunchingWithOptions:launchOptions];
        */
}

+ (BOOL)application:(UIApplication *)application
    openURL:(NSURL *)url
    options:(NSDictionary *)options {

    BOOL handled =
        false;
        /*
         * TODO
         *
        [[FBSDKApplicationDelegate sharedInstance]
            application:application
            openURL:url
            sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
            annotation:options[UIApplicationOpenURLOptionsAnnotationKey]];
            */
    return handled;
}

+ (void)authenticateWithParentVC:(UIViewController *)parentVC
    success:(MAGSocialNetworkSuccessCallback)success
    failure:(MAGSocialNetworkFailureCallback)failure {

    NSLog(@"MAGSocialTwitter. authenticate. VC: '%@'", parentVC);
    /*
    FBSDKLoginManager *lm = [FBSDKLoginManager new];
    // TODO: Get permissions from outside.
    NSArray *permissions = @[ @"public_profile" ];
    [lm logInWithReadPermissions:permissions
        fromViewController:parentVC
        handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
            if (error)
            {
                NSLog(@"MAGSocialFacebook. Could not authorize: '%@'", error);
                if (failure) {
                    failure(error);
                }
            }
            else if (result.isCancelled) {
                NSLog(@"MAGSocialFacebook. User cancelled authentication");
            }
            else {
                if (success) {
                    success();
                }
                NSLog(@"MAGSocialFacebook. Successful authentication");
            }


        }];
        */
}

@end

