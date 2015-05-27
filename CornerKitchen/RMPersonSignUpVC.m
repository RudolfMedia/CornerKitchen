//
//  RMPersonSignUpVC.m
//  CornerKitchen
//
//  Created by Dan Rudolf on 5/12/15.
//  Copyright (c) 2015 com.rudolfmedia. All rights reserved.
//

#import "RMPersonSignUpVC.h"
#import "RMContentEditVC.h"
#import "RMDataLoader.h"
#import "SCLAlertView.h"

@interface RMPersonSignUpVC ()
@property (weak, nonatomic) IBOutlet UITextField *personEmail;
@property (weak, nonatomic) IBOutlet UITextField *personPassword;
@property (weak, nonatomic) IBOutlet UITextField *personConfirmPassword;
@property (weak, nonatomic) IBOutlet UIButton *personSignUpButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property NSString *errorString;
@property RMDataLoader *dataLoader;
@property UIAlertView *alert;

@end

@implementation RMPersonSignUpVC

- (void)viewDidLoad {
    [super viewDidLoad];

    UITapGestureRecognizer *screenTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.view addGestureRecognizer:screenTap];

    self.personEmail.layer.borderWidth = 2;
    self.personEmail.layer.cornerRadius = 5;
    self.personEmail.layer.borderColor = [UIColor whiteColor].CGColor;
    NSAttributedString *strEmail = [[NSAttributedString alloc] initWithString:@"Email" attributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] }];
    self.personEmail.attributedPlaceholder = strEmail;

    self.personPassword.layer.borderWidth = 2;
    self.personPassword.layer.cornerRadius = 5;
    self.personPassword.layer.borderColor = [UIColor whiteColor].CGColor;

    NSAttributedString *strPass = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] }];
    self.personPassword.attributedPlaceholder = strPass;

    self.personConfirmPassword.layer.borderWidth = 2;
    self.personConfirmPassword.layer.cornerRadius = 5;
    self.personConfirmPassword.layer.borderColor = [UIColor whiteColor].CGColor;

    NSAttributedString *strConfirm = [[NSAttributedString alloc] initWithString:@"Confirm Password" attributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] }];
    self.personConfirmPassword.attributedPlaceholder = strConfirm;

    self.personSignUpButton.layer.masksToBounds = YES;
    self.personSignUpButton.layer.cornerRadius = 5;

    self.cancelButton.layer.masksToBounds = YES;
    self.cancelButton.layer.cornerRadius = 5;


}

- (IBAction)onPersonSignUpPressed:(id)sender {

    if(self.personEmail.text.length < 5){

        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];

        self.errorString = @"Please enter a valid email address.";

        [alert showError:@"Oops! \xF0\x9F\x99\x88"
                subTitle:self.errorString
        closeButtonTitle:@"OK" duration:0.0f];

    }
    else if (self.personPassword.text.length < 5){

        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
        self.errorString = @"Passwords must be at least 5 characters long.";

        [alert showError:@"Oops! \xF0\x9F\x99\x88"
                subTitle:self.errorString
        closeButtonTitle:@"OK" duration:0.0f];

    }
    else if (![self.personPassword.text isEqualToString:self.personConfirmPassword.text]){

        self.errorString = @"Passwords do not match.";
        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];

        [alert showError:@"Oops! \xF0\x9F\x99\x88"
                subTitle:self.errorString
        closeButtonTitle:@"OK" duration:0.0f];
    }

    else{

        self.dataLoader = [[RMDataLoader alloc] init];
        [self.dataLoader createNewRegularUser:self.personEmail.text
                                     password:self.personPassword.text
                                   onComplete:^(NSError *error) {

                                       if (!error) {
                                           UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                                           UITabBarController *userMain = [storyboard instantiateViewControllerWithIdentifier:@"USER_MAIN"];
                                           [self presentViewController:userMain animated:YES completion:^{
                                               
                                           }];


                                       }

                                       else{

                                           self.errorString = [error userInfo][@"error"];
                                           
                                           SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];

                                           [alert showError:@"Oops! \xF0\x9F\x99\x88"
                                                   subTitle:self.errorString
                                           closeButtonTitle:@"OK" duration:0.0f];
                                       }

                                       
        }];

        
    }


}


- (IBAction)onCancelPressed:(id)sender {

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    RMContentEditVC *loginVC = [storyboard instantiateViewControllerWithIdentifier:@"LOGIN_MAIN"];

    [self presentViewController:loginVC animated:YES completion:^{

    }];
}

-(void)hideKeyboard{

    [self.personConfirmPassword resignFirstResponder];
    [self.personEmail resignFirstResponder];
    [self.personPassword resignFirstResponder];
    
}

@end
