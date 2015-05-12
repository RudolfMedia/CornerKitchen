//
//  RMTruckSignUpVC.m
//  CornerKitchen
//
//  Created by Dan Rudolf on 5/12/15.
//  Copyright (c) 2015 com.rudolfmedia. All rights reserved.
//

#import "RMTruckSignUpVC.h"

@interface RMTruckSignUpVC ()
@property (weak, nonatomic) IBOutlet UITextField *truckEmail;
@property (weak, nonatomic) IBOutlet UITextField *truckPassword;
@property (weak, nonatomic) IBOutlet UITextField *truckConfirmPass;
@property (weak, nonatomic) IBOutlet UIButton *setUpTruckButton;

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


}

@end
