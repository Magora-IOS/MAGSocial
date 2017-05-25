//
//  MAGSocialNetwork.h
//  Pods
//
//  Created by Nikita Rosenberg on 24/05/2017.
//
//




#import <Foundation/Foundation.h>
#import "MAGSocialAuth.h"
#import "Constants.h"


NS_ASSUME_NONNULL_BEGIN


@protocol MAGSocialNetwork <NSObject>

@property (class, nonatomic, nonnull, readonly) NSString *moduleName;

//MARK: - Setup
+ (void)configure;
+ (void)configureWithApplication:(nullable UIApplication *)application
                andLaunchOptions:(nullable NSDictionary *)launchOptions;


//MARK: - Actions
+ (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
            options:(NSDictionary *)options;

+ (void)authenticateWithParentVC:(UIViewController *)parentVC
                         success:(void(^)(MAGSocialAuth *data))success
                         failure:(MAGSocialNetworkFailureCallback)failure;

@end

NS_ASSUME_NONNULL_END

