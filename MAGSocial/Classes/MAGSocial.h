
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



#import <Foundation/Foundation.h>
#import "MAGSocialNetworkBase.h"
#import "Constants.h"


NS_ASSUME_NONNULL_BEGIN




@interface MAGSocial: NSObject

+ (MAGSocial *)sharedInstance;

//MARK: - Configuration
- (void)registerNetwork:(Class<MAGSocialNetwork>)networkClass;
- (void)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;

- (nullable NSDictionary *) settingsPlist;
- (id<MAGSocialNetwork>)socialNetwork:(Class<MAGSocialNetwork>)networkClass;


//MARK: - Actions
- (BOOL)application:(UIApplication *)application
    openURL:(NSURL *)url
    options:(NSDictionary *)options;

- (void)authenticateNetwork:(Class<MAGSocialNetwork>)networkClass
               withParentVC:(UIViewController *)parentVC
                    success:(void(^)(MAGSocialAuth *data))success
                    failure:(MAGSocialNetworkFailureCallback)failure;

- (void)loadMyProfile:(Class<MAGSocialNetwork>)networkClass
              success:(void(^)(MAGSocialUser *data))success
              failure:(MAGSocialNetworkFailureCallback)failure;


@end
NS_ASSUME_NONNULL_END
