
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

#import <Fabric/Fabric.h>
#import <TwitterKit/TwitterKit.h>



@interface MAGSocialTwitter ()

@end



@implementation MAGSocialTwitter



//MARK: - Configuration
+ (void)configureWithApplication:(UIApplication *)application
                andLaunchOptions:(NSDictionary *)launchOptions {
    //[Fabric with:@[Twitter.class]];
    NSDictionary *settings = [self settings];
    [[Twitter sharedInstance] startWithConsumerKey:settings[@"consumerKey"] consumerSecret:settings[@"consumerSecret"]];
}


+ (BOOL)application:(UIApplication *)application
    openURL:(NSURL *)url
    options:(NSDictionary *)options {

    BOOL handled = [[Twitter sharedInstance] application:application openURL:url options:options];
    return handled;
}


+ (void)authenticateWithParentVC:(UIViewController *)parentVC
    success:(MAGSocialNetworkSuccessCallback)success
    failure:(MAGSocialNetworkFailureCallback)failure {

    NSLog(@"%@. authenticate. VC: '%@'", self.moduleName, parentVC);
    [[Twitter sharedInstance] logInWithCompletion:^(TWTRSession *session, NSError *error) {
        if (session) {
            NSLog(@"%@. Successful authentication", self.moduleName);
            success();
        } else {
            NSLog(@"%@. Could not authorize: '%@'", self.moduleName, error);
            failure(error);
        }
    }];
}

@end

