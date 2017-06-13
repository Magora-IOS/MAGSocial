//
//  MAGSocialNetworkBase.h
//  Pods
//
//  Created by Nikita Rosenberg on 24/05/2017.
//
//

#import <Foundation/Foundation.h>
#import "MAGSocialNetwork.h"





@interface MAGSocialNetworkBase: NSObject <MAGSocialNetwork>

+ (nullable NSDictionary *) settings;
- (nonnull NSString *) moduleName;


@end
