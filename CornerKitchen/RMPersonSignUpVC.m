//
//  RMPersonSignUpVC.m
//  CornerKitchen
//
//  Created by Dan Rudolf on 5/12/15.
//  Copyright (c) 2015 com.rudolfmedia. All rights reserved.
//

#import "RMPersonSignUpVC.h"

@interface RMPersonSignUpVC ()
@property (weak, nonatomic) IBOutlet UITextField *personEmail;
@property (weak, nonatomic) IBOutlet UITextField *personPassword;
@property (weak, nonatomic) IBOutlet UITextField *personConfirmPassword;
@property (weak, nonatomic) IBOutlet UIButton *personSignUpButton;

@end

@implementation RMPersonSignUpVC

- (void)viewDidLoad {
    [super viewDidLoad];

    UITapGestureRecognizer *screenTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.view addGestureRecognizer:screenTap];


}

- (IBAction)onPersonSignUpPressed:(id)sender {



}



-(void)hideKeyboard{

    [self.personConfirmPassword resignFirstResponder];
    [self.personEmail resignFirstResponder];
    [self.personPassword resignFirstResponder];
    
}

@end
