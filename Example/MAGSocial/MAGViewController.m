
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

#import "MAGViewController.h"

#import "MAGSocial.h"
#import "MAGSocialFacebook.h"
#import "MAGSocialTwitter.h"
#import "MAGSocialGoogle.h"
#import "MAGSocialVK.h"



@interface MAGViewController ()

@end



@implementation MAGViewController

#pragma mark - PUBLIC
- (void)viewDidLoad {
    [super viewDidLoad];
}



#pragma mark - PRIVATE
- (IBAction)authenticateFacebook:(id)sender {
    [self authenticateNetwork:[MAGSocialFacebook class]];
}

- (IBAction)authenticateTwitter:(id)sender {
    [self authenticateNetwork:[MAGSocialTwitter class]];
}

- (IBAction)authenticateGoogle:(id)sender {
    [self authenticateNetwork:[MAGSocialGoogle class]];
}

- (IBAction)authenticateVK:(id)sender {
    [self authenticateNetwork:[MAGSocialVK class]];
}


- (IBAction)profileFacebookAction:(id)sender {
    [self loadMyProfileWithNetwork:[MAGSocialFacebook class]];
}

- (IBAction)profileTwitterAction:(id)sender {
    [self loadMyProfileWithNetwork:[MAGSocialTwitter class]];
}

- (IBAction)profileGoogleAction:(id)sender {
    [self loadMyProfileWithNetwork:[MAGSocialGoogle class]];
}

- (IBAction)profileVKAction:(id)sender {
    [self loadMyProfileWithNetwork:[MAGSocialVK class]];
}




//MARK: - Routines
- (void)authenticateNetwork:(_Nonnull Class<MAGSocialNetwork>)network {
    NSLog(@"MAGViewController. Authenticate %@ started", [network moduleName]);
    [MAGSocial.sharedInstance authenticateNetwork:network
                      withParentVC:self
                           success:^(MAGSocialAuth * _Nonnull data) {
                               
        NSLog(@"MAGViewController. Successful %@ authentication", [network moduleName]);
                               NSString *message = [NSString stringWithFormat:@"%@\n\n%@", data, data.userData];
                               [self showResultMessage:message];
                    
    } failure:^(NSError * _Nullable error) {
        NSLog(@"MAGViewController. %@ authentication failed", [network moduleName]);
        [self showError:error];
    }];
}


- (void)loadMyProfileWithNetwork:(_Nonnull Class<MAGSocialNetwork>)network {
    
    [MAGSocial.sharedInstance loadMyProfile:network success:^(MAGSocialUser * _Nonnull data) {
        NSString *message = [NSString stringWithFormat:@"%@\n\n%@", data, data.objectID];
        [self showResultMessage:message];
        
    } failure:^(NSError * _Nullable error) {
        NSLog(@"MAGViewController. %@ authentication failed", [network moduleName]);
        [self showError:error];
    }];
}


- (void)showResultMessage:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Result"
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    
    [self presentViewController:alert animated:true completion:nil];
}


- (void)showError:(NSError *)error {
    NSString *message = [NSString stringWithFormat:@"%@\n%@", error.localizedDescription, error.localizedFailureReason];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    
    [self presentViewController:alert animated:true completion:nil];
}


@end

