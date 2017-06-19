//
//  MAGSocialUser.h
//  Pods
//
//  Created by Nikita Rosenberg on 25/05/2017.
//
//

#import <Foundation/Foundation.h>
#import "MAGSocialAuth.h"


typedef enum : NSUInteger {
    MAGSocialUserGenderUndefined,
    MAGSocialUserGenderMale,
    MAGSocialUserGenderFemale,
} MAGSocialUserGender;


@interface MAGSocialUser : NSObject

- (instancetype _Nonnull) initWith:(id _Nullable)raw;

@property (nullable, nonatomic, weak) MAGSocialAuth *authData;

@property (nullable, nonatomic, strong) id raw;
@property (nullable, nonatomic, strong) NSString *objectID;
@property (nullable, nonatomic, strong) NSString *name;
@property (nullable, nonatomic, strong) NSString *email;
@property (nullable, nonatomic, strong) NSString *firstName;
@property (nullable, nonatomic, strong) NSString *lastName;
@property (nonatomic, assign) MAGSocialUserGender gender;
@property (nullable, nonatomic, strong) NSString *pictureUrl;

@end
