
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

#import "MAGSocialFacebook.h"
#import "MAGSocialUser.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>



@interface MAGSocialFacebook ()

@end




@implementation MAGSocialFacebook


//MARK: - Configuration
- (void)configureWithApplication:(UIApplication *)application
                andLaunchOptions:(NSDictionary *)launchOptions {
    [[self settings] enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *value, BOOL* stop) {
        if ([key isEqual: @"FacebookAppID"]) {
            [FBSDKSettings setAppID:value];
        }
        else if ([key isEqual: @"FacebookDisplayName"]) {
            [FBSDKSettings setDisplayName:value];
        }
    }];
    
    [[FBSDKApplicationDelegate sharedInstance]
     application:application
     didFinishLaunchingWithOptions:launchOptions];
}





- (BOOL)application:(UIApplication *)application
    openURL:(NSURL *)url
    options:(NSDictionary *)options {

    BOOL handled =
        [[FBSDKApplicationDelegate sharedInstance]
            application:application
            openURL:url
            sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
            annotation:options[UIApplicationOpenURLOptionsAnnotationKey]];
    return handled;
}


- (BOOL)isSignedIn {
    if ([FBSDKAccessToken currentAccessToken]) {
        return YES;
    }
    return NO;
}


//MARK: - Actions
- (void)authenticateWithParentVC:(UIViewController *)parentVC
    success:(void(^)(MAGSocialAuth *data))success
    failure:(MAGSocialNetworkFailureCallback)failure {

    NSLog(@"%@ authenticate", self.moduleName);
    FBSDKLoginManager *lm = [FBSDKLoginManager new];
    
    //TODO: Get permissions from outside.
    [lm logInWithReadPermissions:@[@"public_profile", @"email"]
        fromViewController:parentVC
        handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
            if (error) {
                NSLog(@"%@. Could not authorize: '%@'", self.moduleName, error);
                failure(error);
            }
            else if (result.isCancelled) {
                NSLog(@"%@. User cancelled authentication", self.moduleName);
            }
            else {
                success([self createAuth:result]);
                NSLog(@"%@. Successful authentication", self.moduleName);
            }
        }];
}


- (void)loadMyProfile:(void(^)(MAGSocialUser *user))success failure:(MAGSocialNetworkFailureCallback)failure {
    
    NSString *fields = [NSString stringWithFormat:@"name, first_name, last_name, email, gender, id, picture.width(%li).height(%li)",
                        self.preferredPhotoSize, self.preferredPhotoSize];
    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc] initWithGraphPath:@"me"
                                                                   parameters:@{@"fields": fields}];
    
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
        if (error) {
            NSLog(@"%@. Could not get profile: '%@'", self.moduleName, error);
            failure(error);
            
        } else {
            NSLog(@"%@. User cancelled request", self.moduleName);
            MAGSocialUser *user = [self createUserWithDictionary:result];
            success(user);
        }
    }];
}


- (MAGSocialUser *)createUserWithDictionary:(NSDictionary *)data {
    MAGSocialUser *result = [[MAGSocialUser alloc] initWith:data];
    result.objectID = data[@"id"];
    result.email = data[@"email"];
    result.name = data[@"name"];
    result.firstName = data[@"first_name"];
    result.lastName = data[@"last_name"];
    result.gender = data[@"gender"];
    result.pictureUrl = [data valueForKeyPath:@"picture.data.url"];
    
    return result;
}


- (MAGSocialAuth *)createAuth:(FBSDKLoginManagerLoginResult *)raw {
    MAGSocialAuth *result = [[MAGSocialAuth alloc] initWith:raw];
    result.token = raw.token.tokenString;
    result.userID = raw.token.userID;
    result.userData = [self createUser:raw];
    return result;
}


- (MAGSocialUser *)createUser:(FBSDKLoginManagerLoginResult *)raw {
    MAGSocialUser *result = [[MAGSocialUser alloc] initWith:raw];
    result.objectID = raw.token.userID;
    return result;
}




@end

