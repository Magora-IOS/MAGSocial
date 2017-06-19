
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
#import "MAGSocial.h"
#import "MAGSocialUser.h"
#import <TwitterKit/TwitterKit.h>



@interface MAGSocialTwitter ()

@end



@implementation MAGSocialTwitter



//MARK: - Configuration
- (void)configureWithApplication:(UIApplication *)application
                andLaunchOptions:(NSDictionary *)launchOptions {
    NSDictionary *settings = [self settings];
    [[Twitter sharedInstance] startWithConsumerKey:settings[@"consumerKey"] consumerSecret:settings[@"consumerSecret"]];
}




//MARK: - Actions
- (BOOL)application:(UIApplication *)application
    openURL:(NSURL *)url
    options:(NSDictionary *)options {

    BOOL handled = [[Twitter sharedInstance] application:application openURL:url options:options];
    return handled;
}


- (BOOL)isSignedIn {
    TWTRSessionStore *store = [[Twitter sharedInstance] sessionStore];
    //NSString *userID = store.session.userID;
    if (store.session) {
        return YES;
    }
    return NO;
}


- (void)authenticateWithParentVC:(UIViewController *)parentVC
    success:(void(^)(MAGSocialAuth *data))success
    failure:(MAGSocialNetworkFailureCallback)failure {

    NSLog(@"%@ authenticate", self.moduleName);
    [[Twitter sharedInstance] logInWithCompletion:^(TWTRSession *session, NSError *error) {
        if (session) {
            NSLog(@"%@. Successful authentication", self.moduleName);
            success([self createAuth:session]);
        } else {
            NSLog(@"%@. Could not authorize: '%@'", self.moduleName, error);
            failure(error);
        }
    }];
}


- (void)loadMyProfile:(void (^)(MAGSocialUser * _Nonnull))success failure:(MAGSocialNetworkFailureCallback)failure {
    TWTRSessionStore *store = [[Twitter sharedInstance] sessionStore];
    NSString *userID = store.session.userID; //self.socialAuth.userID;
    
    TWTRAPIClient *client = [[TWTRAPIClient alloc] initWithUserID:userID];
    [client loadUserWithID:userID completion:^(TWTRUser * _Nullable user, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@. Could not get profile: '%@'", self.moduleName, error);
            failure(error);
            
        } else {
            NSLog(@"%@. User cancelled request", self.moduleName);
            MAGSocialUser *socialUser = [self createUserProfile:user];
            success(socialUser);
        }
    }];
}


- (MAGSocialUser *)createUserProfile:(TWTRUser *)user {
    MAGSocialUser *result = [[MAGSocialUser alloc] initWith:user];
    result.objectID = user.userID;
    result.email = nil;
    result.name = user.screenName;
    result.firstName = user.name;
    result.lastName = nil;
    result.gender = MAGSocialUserGenderUndefined;
    result.pictureUrl = user.profileImageLargeURL;
    
    return result;
}


- (MAGSocialAuth *)createAuth:(TWTRSession *)raw {
    MAGSocialAuth *result = [[MAGSocialAuth alloc] initWith:raw];
    result.token = raw.authToken;
    result.userID = raw.userID;
    result.userData = [self createUser:raw];
    return result;
}


- (MAGSocialUser *)createUser:(TWTRSession *)raw {
    MAGSocialUser *result = [[MAGSocialUser alloc] initWith:raw];
    result.objectID = raw.userID;
    result.name = raw.userName;
    return result;
}



@end

