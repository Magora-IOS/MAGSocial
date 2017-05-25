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

- (instancetype _Nonnull) initWith:(id _Nullable)raw;

@property (nullable, nonatomic, weak) MAGSocialAuth *authData;

@property (nullable, nonatomic, strong) id raw;
@property (nullable, nonatomic, strong) NSString *objectID;
@property (nullable, nonatomic, strong) NSString *name;
@property (nullable, nonatomic, strong) NSString *email;

@end
