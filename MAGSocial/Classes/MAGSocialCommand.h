//
//  MAGSocialCommand.h
//  Pods
//
//  Created by Nikita Rosenberg on 24/05/2017.
//
//





#import <Foundation/Foundation.h>
#import "MAGSocialNetwork.h"


NS_ASSUME_NONNULL_BEGIN



@protocol MAGSocialCommand <NSObject>

//MARK: - Convenience
- (instancetype) initWith:(Class<MAGSocialNetwork>)network;


//MARK: - Interface
@property (nonatomic, strong) Class<MAGSocialNetwork> network;
- (void) executeWithSuccess:(MAGSocialNetworkSuccessCallback)success
                    failure:(MAGSocialNetworkFailureCallback)failure;

@end



NS_ASSUME_NONNULL_END


