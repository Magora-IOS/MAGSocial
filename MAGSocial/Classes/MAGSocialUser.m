//
//  MAGSocialUser.m
//  Pods
//
//  Created by Nikita Rosenberg on 25/05/2017.
//
//

#import "MAGSocialUser.h"

@implementation MAGSocialUser

- (instancetype _Nonnull ) initWith:(id _Nullable)raw {
    self = [self init];
    self.raw = raw;
    return self;
}


- (NSString *) description {
    return [NSString stringWithFormat:@"User: id %@\n email: %@\n name: %@\n firstName: %@\n lastName: %@\n gender: %@\n picture: %@", self.objectID, self.email, self.name, self.firstName, self.lastName, self.gender, self.pictureUrl];
}



@end
