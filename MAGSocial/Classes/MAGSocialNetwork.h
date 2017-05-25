//
//  MAGSocialNetwork.h
//  Pods
//
//  Created by Nikita Rosenberg on 24/05/2017.
//
//

#ifndef MAGSocialNetwork_h
#define MAGSocialNetwork_h

NS_ASSUME_NONNULL_BEGIN

typedef void (^MAGSocialNetworkSuccessCallback)();
typedef void (^MAGSocialNetworkFailureCallback)(NSError * _Nullable error);




@protocol MAGSocialNetwork <NSObject>


@property (class, nonatomic, nonnull, readonly) NSString *moduleName;


+ (void)configure;
+ (void)configureWithApplication:(nullable UIApplication *)application
                andLaunchOptions:(nullable NSDictionary *)launchOptions;



+ (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
            options:(NSDictionary *)options;
+ (void)authenticateWithParentVC:(UIViewController *)parentVC
                         success:(MAGSocialNetworkSuccessCallback)success
                         failure:(MAGSocialNetworkFailureCallback)failure;

@end

NS_ASSUME_NONNULL_END

#endif /* MAGSocialNetwork_h */
