
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

@interface MAGSocial ()

@end

@implementation MAGSocial

+ (void)authenticateNetwork:(Class<MAGSocialNetwork>)networkClass
    withParentVC:(UIViewController *)parentVC
    success:(MAGSocialNetworkSuccessCallback)success
    failure:(MAGSocialNetworkFailureCallback)failure {

    [networkClass
        authenticateWithParentVC:parentVC
        success:success
        failure:failure];
}

+ (void)registerNetwork:(Class<MAGSocialNetwork>)networkClass {
    /*
    if (![networkClass conformsToProtocol:@protocol(MAGSocialNetwork)]) {
        NSLog(
            @"MAGSocial. Could not register network '%@', "
            @"because it does not conform to MAGSocialNetwork protocol",
            networkClass);
    }
     */
}

@end

