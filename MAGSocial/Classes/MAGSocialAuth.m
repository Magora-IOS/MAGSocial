//
//  MAGSocialAuth.m
//  Pods
//
//  Created by Nikita Rosenberg on 25/05/2017.
//
//

#import "MAGSocialAuth.h"


@implementation MAGSocialAuth

- (instancetype _Nonnull ) initWith:(id _Nullable)raw {
    self = [self init];
    self.raw = raw;
    return self;
}


- (NSString *) description {
    return [NSString stringWithFormat:@"Auth: token %@", self.token];
}


@end
