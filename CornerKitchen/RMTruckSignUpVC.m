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

@interface RMTruckSignUpVC ()
@property (weak, nonatomic) IBOutlet UITextField *truckEmail;
@property (weak, nonatomic) IBOutlet UITextField *truckPassword;
@property (weak, nonatomic) IBOutlet UITextField *truckConfirmPass;
@property (weak, nonatomic) IBOutlet UIButton *setUpTruckButton;
@property RMTruck *createdTruck;
@property NSString *errorString;
@property UIAlertView *alert;

@end

@implementation RMTruckSignUpVC

- (void)viewDidLoad {
    [super viewDidLoad];

    UITapGestureRecognizer *screenTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.view addGestureRecognizer:screenTap];

}

-(void)hideKeyboard{

    [self.truckConfirmPass resignFirstResponder];
    [self.truckEmail resignFirstResponder];
    [self.truckPassword resignFirstResponder];

}



- (IBAction)onSetUpTruckPressed:(id)sender {


    if (self.truckEmail.text.length < 5) {

        self.errorString = @"Please Enter a Valid Email";
        self.alert = [[UIAlertView alloc] initWithTitle:@"Oops! \xF0\x9F\x99\x88"
                                                message:self.errorString
                                               delegate:self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
        [self.alert show];

    }


    else if (self.truckPassword.text.length <5){

        self.errorString = @"Password Must Be At Least 5 Characters Long";
        self.alert = [[UIAlertView alloc] initWithTitle:@"Oops! \xF0\x9F\x99\x88"
                                                message:self.errorString
                                               delegate:self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
        [self.alert show];

    }


    else if (![self.truckPassword.text isEqualToString:self.truckConfirmPass.text]){

        self.errorString = @"Passwords Don't Match";
        self.alert = [[UIAlertView alloc] initWithTitle:@"Oops! \xF0\x9F\x99\x88"
                                                message:self.errorString
                                               delegate:self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
        [self.alert show];



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


@end
