//
//  RMTruckSignUpVC.m
//  CornerKitchen
//
//  Created by Dan Rudolf on 5/12/15.
//  Copyright (c) 2015 com.rudolfmedia. All rights reserved.
//

#import "RMTruckSignUpVC.h"
#import "RMTruck.h"
#import "RMContentEditVC.h"
#import "SCLAlertView.h"


@interface RMTruckSignUpVC ()
@property (weak, nonatomic) IBOutlet UITextField *truckEmail;
@property (weak, nonatomic) IBOutlet UITextField *truckPassword;
@property (weak, nonatomic) IBOutlet UITextField *truckConfirmPass;
@property (weak, nonatomic) IBOutlet UIButton *setUpTruckButton;
@property RMTruck *createdTruck;
@property NSString *errorString;
@property UIAlertView *alert;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@end

@implementation RMTruckSignUpVC

- (void)viewDidLoad {
    [super viewDidLoad];

    UITapGestureRecognizer *screenTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.view addGestureRecognizer:screenTap];

    self.setUpTruckButton.layer.masksToBounds = YES;
    self.setUpTruckButton.layer.cornerRadius = 5;

    self.truckEmail.layer.borderWidth = 2;
    self.truckEmail.layer.cornerRadius = 5;
    self.truckEmail.layer.borderColor = [UIColor whiteColor].CGColor;
    NSAttributedString *strEmail = [[NSAttributedString alloc] initWithString:@"Email" attributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] }];
    self.truckEmail.attributedPlaceholder = strEmail;

    self.truckPassword.layer.borderWidth = 2;
    self.truckPassword.layer.cornerRadius = 5;
    self.truckPassword.layer.borderColor = [UIColor whiteColor].CGColor;

    NSAttributedString *strPass = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] }];
    self.truckPassword.attributedPlaceholder = strPass;

    self.truckConfirmPass.layer.borderWidth = 2;
    self.truckConfirmPass.layer.cornerRadius = 5;
    self.truckConfirmPass.layer.borderColor = [UIColor whiteColor].CGColor;

    NSAttributedString *strConfirm = [[NSAttributedString alloc] initWithString:@"Confirm Password" attributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] }];
    self.truckConfirmPass.attributedPlaceholder = strConfirm;

    self.cancelButton.layer.masksToBounds = YES;
    self.cancelButton.layer.cornerRadius = 5;

}

-(void)hideKeyboard{

    [self.truckConfirmPass resignFirstResponder];
    [self.truckEmail resignFirstResponder];
    [self.truckPassword resignFirstResponder];

}



- (IBAction)onSetUpTruckPressed:(id)sender {


    if (self.truckEmail.text.length < 5) {

        self.errorString = @"Please enter a valid email address.";

        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
        [alert showError:@"Oops! \xF0\x9F\x99\x88"
                subTitle:self.errorString
        closeButtonTitle:@"OK" duration:0.0f];
    }


    else if (self.truckPassword.text.length <5){

        self.errorString = @"Password must be at least 5 characters long.";

        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
        [alert showError:@"Oops! \xF0\x9F\x99\x88"
                subTitle:self.errorString
        closeButtonTitle:@"OK" duration:0.0f];
    }


    else if (![self.truckPassword.text isEqualToString:self.truckConfirmPass.text]){

        self.errorString = @"Passwords do not match.";
        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
        [alert showError:@"Oops! \xF0\x9F\x99\x88"
                subTitle:self.errorString
        closeButtonTitle:@"OK" duration:0.0f];
    }

    else{

    self.createdTruck = [[RMTruck alloc] init];
    self.createdTruck.email = self.truckEmail.text;
    self.createdTruck.password = self.truckPassword.text;

    [self performSegueWithIdentifier:@"SETUP_TRUCK" sender:self];

    }

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    if ([segue.identifier isEqualToString:@"SETUP_TRUCK"]) {

        RMContentEditVC *destination = [segue destinationViewController];
        destination.currentTruck = self.createdTruck;
    }


}

- (IBAction)onCancelPressed:(id)sender {

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    RMContentEditVC *loginVC = [storyboard instantiateViewControllerWithIdentifier:@"LOGIN_MAIN"];

    [self presentViewController:loginVC animated:NO completion:^{

    }];
}

@end
