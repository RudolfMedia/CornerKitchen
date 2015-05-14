//
//  RMPersonSignUpVC.m
//  CornerKitchen
//
//  Created by Dan Rudolf on 5/12/15.
//  Copyright (c) 2015 com.rudolfmedia. All rights reserved.
//

#import "RMPersonSignUpVC.h"
#import "RMContentEditVC.h"

@interface RMPersonSignUpVC ()
@property (weak, nonatomic) IBOutlet UITextField *personEmail;
@property (weak, nonatomic) IBOutlet UITextField *personPassword;
@property (weak, nonatomic) IBOutlet UITextField *personConfirmPassword;
@property (weak, nonatomic) IBOutlet UIButton *personSignUpButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

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
