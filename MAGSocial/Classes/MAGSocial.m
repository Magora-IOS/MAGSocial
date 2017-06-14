
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

#import "MAGSocial.h"
#import "MAGSocialSettings.h"
#import "MAGSocialCommandAuth.h"
#import "MAGSocialCommandProfile.h"


//static NSMutableArray<MAGSocialNetworkBase *> *magSocialNetworks;
//static NSMutableDictionary *magSocialNetworks;



@interface MAGSocial ()

@property (strong, nonatomic) NSMutableDictionary *magSocialNetworks;

@end




@implementation MAGSocial



#pragma mark - PUBLIC

+ (MAGSocial *)sharedInstance {
    static MAGSocial *sharedInstance = nil;
    @synchronized(self) {
        if (sharedInstance == nil)
            sharedInstance = [[self alloc] init];
    }
    return sharedInstance;
}


- (void)registerNetwork:(Class<MAGSocialNetwork>)networkClass {
    if ([networkClass.class conformsToProtocol:@protocol(MAGSocialNetwork)]) {
        NSLog(@"MAGSocial. Register network: '%@'", networkClass);
        
        MAGSocialNetworkBase *network = [networkClass.class new];
        [[self networks] setValue:network forKey:NSStringFromClass(networkClass)];
    }
    else {
        NSLog(
              @"MAGSocial. Could not register network '%@', "
              @"because it does not conform to MAGSocialNetwork protocol",
              networkClass);
        
    }
}



- (void)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    for (MAGSocialNetworkBase *network in [self networks].allValues) {
        [network configureWithApplication:application andLaunchOptions:launchOptions];
    }
}


- (nullable NSDictionary *) settingsPlist {
    static NSDictionary *result = nil;
    @synchronized(self) {
        if (result == nil) {
            NSString *path = [[NSBundle mainBundle] pathForResource:MAGSocialSettings.plistFileName ofType:@"plist"];
            if (path != nil) {
                result = [[NSDictionary alloc]initWithContentsOfFile:path];
            }
            else {
                result = @{};
            }
        }
    }
    return result;
}




- (BOOL)application:(UIApplication *)application
    openURL:(NSURL *)url
    options:(NSDictionary *)options {

    for (Class network in [self networks].allValues) {
        BOOL handled = 
            [network
                application:application
                openURL:url
                options:options];
        if (handled)
            return YES;
    }
    return NO;
}


- (void)authenticateNetwork:(Class<MAGSocialNetwork>)networkClass
    withParentVC:(UIViewController *)parentVC
    success:(void(^)(MAGSocialAuth *data))success
    failure:(MAGSocialNetworkFailureCallback)failure {
    
    id<MAGSocialNetwork> network = [self networkByClass:networkClass];
    MAGSocialCommandAuth *command = [[MAGSocialCommandAuth alloc] initWith:network];
    command.vc = parentVC;
    
    [command executeWithSuccess:^{
        success(command.result);
    }
                        failure:^(NSError * _Nullable error) {
        failure(error);
    }];
}


- (void)loadMyProfile:(Class<MAGSocialNetwork>)networkClass
              success:(void(^)(MAGSocialUser *data))success
              failure:(MAGSocialNetworkFailureCallback)failure {
    
    id<MAGSocialNetwork> network = [self networkByClass:networkClass];
    MAGSocialCommandProfile *command = [[MAGSocialCommandProfile alloc] initWith:network];
    
    [command executeWithSuccess:^{
        success(command.result);
        
    } failure:^(NSError * _Nullable error) {
        failure(error);
    }];
}

         
#pragma mark - PRIVATE

- (NSMutableDictionary *)networks {
    if (!self.magSocialNetworks) {
        self.magSocialNetworks = @{}.mutableCopy;
    }
    return self.magSocialNetworks;
}


- (id<MAGSocialNetwork>)networkByClass:(Class<MAGSocialNetwork>)networkClass {
    id<MAGSocialNetwork> network = [self networks][NSStringFromClass(networkClass)];
    
    return network;
}

         
@end

