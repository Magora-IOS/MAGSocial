//
//  MAGSocialAuth.h
//  Pods
//
//  Created by Nikita Rosenberg on 25/05/2017.
//
//

#import <Foundation/Foundation.h>
@class MAGSocialUser;


@interface MAGSocialAuth : NSObject

- (instancetype _Nonnull) initWith:(id _Nullable)raw;

@property (nullable, nonatomic, strong) MAGSocialUser *userData;

@property (nullable, nonatomic, strong) NSString *token;
@property (nullable, nonatomic, strong) id raw;

@end
