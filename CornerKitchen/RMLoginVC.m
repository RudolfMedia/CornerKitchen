//
//  ViewController.m
//  CornerKitchen
//
//  Created by Dan Rudolf on 5/5/15.
//  Copyright (c) 2015 com.rudolfmedia. All rights reserved.
//

#import "RMLoginVC.h"

@interface RMLoginVC ()
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;
@property (weak, nonatomic) IBOutlet UIButton *isTruckButton;
@property (weak, nonatomic) IBOutlet UIButton *isPersonButton;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextfield;
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

    [self.emailTextField setHidden:YES];
    [self.passwordTextfield setHidden:YES];

}

-(void)viewWillAppear:(BOOL)animated{

    [self.isPersonButton setHidden:YES];
    [self.isTruckButton setHidden:YES];
    
}

-(void)toggleLogin{

    [self.loginButton setHidden:NO];
    [self.isPersonButton setHidden:YES];
    [self.isTruckButton setHidden:YES];
    [self.emailTextField resignFirstResponder];
    [self.passwordTextfield resignFirstResponder];
}


#pragma mark - Actions

- (IBAction)onLoginPressed:(id)sender{

    if (self.emailTextField.isHidden == NO) {

        if (self.emailTextField.text.length < 5) {

            self.errorString = @"Please Enter a Valid Email";
            self.alert = [[UIAlertView alloc] initWithTitle:@"Oops! \xF0\x9F\x99\x88"
                                                    message:self.errorString
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
            [self.alert show];

        }
        else if (self.passwordTextfield.text.length <5){

            self.errorString = @"Please Enter a Valid Password";
            self.alert = [[UIAlertView alloc] initWithTitle:@"Oops! \xF0\x9F\x99\x88"
                                                    message:self.errorString
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
            [self.alert show];

        }

        else{



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
