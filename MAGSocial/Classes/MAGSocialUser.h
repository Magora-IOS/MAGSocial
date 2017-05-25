//
//  MAGSocialUser.h
//  Pods
//
//  Created by Nikita Rosenberg on 25/05/2017.
//
//

#import <Foundation/Foundation.h>
#import "MAGSocialAuth.h"



@interface MAGSocialUser : NSObject

@property (nullable, nonatomic, strong) MAGSocialAuth *authData;
@property (nullable, nonatomic, strong) id raw;

@property (nullable, nonatomic, strong) NSString *objectID;
@property (nullable, nonatomic, strong) NSString *name;

@end
