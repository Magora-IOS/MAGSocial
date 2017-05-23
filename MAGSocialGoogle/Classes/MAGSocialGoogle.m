
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
#import <Google/SignIn.h>



@interface MAGSocialGoogle () <GIDSignInDelegate, GIDSignInUIDelegate>

@property (nullable, nonatomic, weak) UIViewController *parentVC;
@property (nonatomic, strong) MAGSocialNetworkSuccessCallback success;
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



+ (void)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    NSError* configureError;
    [[GGLContext sharedInstance] configureWithError: &configureError];
    //TODO: throw exception?
    NSAssert(!configureError, @"Error configuring Google services: %@", configureError);
    
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

+ (void)authenticateWithParentVC:(UIViewController *)parentVC
    success:(MAGSocialNetworkSuccessCallback)success
    failure:(MAGSocialNetworkFailureCallback)failure {

    [self sharedInstance].parentVC = parentVC;
    [self sharedInstance].success = success;
    [self sharedInstance].failure = failure;
    
    NSLog(@"MAGSocialGoogle. authenticate. VC: '%@'", parentVC);
    [[GIDSignIn sharedInstance] signIn];
}




//MARK: - GIDSignInDelegate
- (void)signIn:(GIDSignIn *)signIn
didSignInForUser:(GIDGoogleUser *)user
    withError:(NSError *)error {
    if (error)
    {
        NSLog(@"MAGSocialGoogle. Could not authorize: '%@'", error);
        self.failure(error);
    }
    else {
        self.success();
        NSLog(@"MAGSocialGoogle. Successful authentication");
    }
}






//MARK: - GIDSignInUIDelegate
// Present a view that prompts the user to sign in with Google
- (void)signIn:(GIDSignIn *)signIn
presentViewController:(UIViewController *)viewController {
    [self.parentVC presentViewController:viewController animated:YES completion:nil];
}

// Dismiss the "Sign in with Google" view
- (void)signIn:(GIDSignIn *)signIn
dismissViewController:(UIViewController *)viewController {
    [self.parentVC dismissViewControllerAnimated:YES completion:nil];
}


@end

