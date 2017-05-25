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
    return [NSString stringWithFormat:@"User: id %@, email: %@, name: %@", self.objectID, self.email, self.name];
}



@end
