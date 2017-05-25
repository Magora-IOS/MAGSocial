//
//  MAGSocialNetwork.h
//  Pods
//
//  Created by Nikita Rosenberg on 24/05/2017.
//
//

#ifndef MAGSocialNetwork_h
#define MAGSocialNetwork_h


typedef void (^MAGSocialNetworkSuccessCallback)();
typedef void (^MAGSocialNetworkFailureCallback)(NSError *error);




@protocol MAGSocialNetwork <NSObject>

+ (void)configure;
+ (void)configureWithApplication:(UIApplication *)application
                andLaunchOptions:(NSDictionary *)launchOptions;



+ (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
            options:(NSDictionary *)options;
+ (void)authenticateWithParentVC:(UIViewController *)parentVC
                         success:(MAGSocialNetworkSuccessCallback)success
                         failure:(MAGSocialNetworkFailureCallback)failure;

@end


#endif /* MAGSocialNetwork_h */
