//
//  ViewController.m
//  CornerKitchen
//
//  Created by Dan Rudolf on 5/5/15.
//  Copyright (c) 2015 com.rudolfmedia. All rights reserved.
//

#import "RMLoginVC.h"
#import "RMCheckInVC.h"
#import "RMViewAnimator.h"
#import "SCLAlertView.h"

@interface RMLoginVC ()
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;
@property (weak, nonatomic) IBOutlet UIButton *isTruckButton;
@property (weak, nonatomic) IBOutlet UIButton *isPersonButton;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextfield;
@property RMViewAnimator *animator;
@property NSString *errorString;
@property UIAlertView *alert;

@end

@implementation RMLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.loginButton.layer.masksToBounds = YES;
    self.loginButton.layer.cornerRadius = 5;

    self.signUpButton.layer.masksToBounds = YES;
    self.signUpButton.layer.cornerRadius = 5;

    self.emailTextField.layer.borderWidth = 2;
    self.emailTextField.layer.cornerRadius = 5;
    self.emailTextField.layer.borderColor = [UIColor whiteColor].CGColor;
    NSAttributedString *strEmail = [[NSAttributedString alloc] initWithString:@"Email" attributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] }];
    self.emailTextField.attributedPlaceholder = strEmail;

    self.passwordTextfield.layer.borderWidth = 2;
    self.passwordTextfield.layer.cornerRadius = 5;
    self.passwordTextfield.layer.borderColor = [UIColor whiteColor].CGColor;

    NSAttributedString *strPass = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] }];
    self.passwordTextfield.attributedPlaceholder = strPass;

    self.isTruckButton.layer.masksToBounds = YES;
    self.isTruckButton.layer.cornerRadius = 5;
    [self.isTruckButton.layer setBorderWidth:2.0f];
    [self.isTruckButton.layer setBorderColor:[UIColor whiteColor].CGColor];

    self.isPersonButton.layer.masksToBounds = YES;
    self.isPersonButton.layer.cornerRadius = 5;
    [self.isPersonButton.layer setBorderWidth:2.0f];
    [self.isPersonButton.layer setBorderColor:[UIColor whiteColor].CGColor];

    UITapGestureRecognizer *screenTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toggleLogin)];
    [self.view addGestureRecognizer:screenTap];

    self.emailTextField.alpha = 0;
    self.passwordTextfield.alpha = 0;

    self.animator = [[RMViewAnimator alloc] init];

}

-(void)viewWillAppear:(BOOL)animated{

    [self.isPersonButton setHidden:YES];
    [self.isTruckButton setHidden:YES];
    
}

-(void)toggleLogin{

    [self.animator alphaInView:self.loginButton];
    [self.animator alphaOutView:self.isPersonButton];
    [self.animator alphaOutView:self.isTruckButton];

    [self.emailTextField resignFirstResponder];
    [self.passwordTextfield resignFirstResponder];
    
}


#pragma mark - Actions

- (IBAction)onLoginPressed:(id)sender{

    if (self.emailTextField.alpha == 1) {

        if (self.emailTextField.text.length < 5) {

            SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];

            self.errorString = @"Please enter a valid email address.";

            [alert showError:@"Oops! \xF0\x9F\x99\x88"
                    subTitle:self.errorString
            closeButtonTitle:@"OK" duration:0.0f];

        }
        else if (self.passwordTextfield.text.length <5){

            SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
            self.errorString = @"Passwords must be at least 5 characters long.";

            [alert showError:@"Oops! \xF0\x9F\x99\x88"
                    subTitle:self.errorString
            closeButtonTitle:@"OK" duration:0.0f];
        }

        else{

            [PFUser logInWithUsernameInBackground:[self.emailTextField.text lowercaseString]
                                         password:self.passwordTextfield.text
                                            block:^(PFUser *user, NSError *error) {
                                                if (user) {


                                                    if ([user[@"isTruck"] isEqualToNumber:[NSNumber numberWithBool:YES]]) {

                                                        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                                                        UITabBarController *truckMain = [storyboard instantiateViewControllerWithIdentifier:@"TRUCK_MAIN"];

                                                        [self presentViewController:truckMain animated:YES completion:^{


                                                        }];

                                                    }

                                                }
                                                else{

                                                }



            }];


        }
    }

    [self.emailTextField setHidden:NO];
    [self.passwordTextfield setHidden:NO];


}


- (IBAction)onSignupPressed:(id)sender{

    [self.isPersonButton setHidden:NO];
    [self.isTruckButton setHidden:NO];
    [self.loginButton setHidden:YES];
    [self.emailTextField setHidden:YES];
    [self.passwordTextfield setHidden:YES];

}

- (IBAction)onIsPersonPressed:(id)sender {



}


- (IBAction)onIsTruckPressed:(id)sender {


}







@end
