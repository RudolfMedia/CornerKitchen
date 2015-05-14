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

@end

@implementation RMLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.loginButton.layer.masksToBounds = YES;
    self.loginButton.layer.cornerRadius = 5;

    self.signUpButton.layer.masksToBounds = YES;
    self.signUpButton.layer.cornerRadius = 5;

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

}

-(void)viewWillAppear:(BOOL)animated{

    [self.isPersonButton setHidden:YES];
    [self.isTruckButton setHidden:YES];
    
}

-(void)toggleLogin{

    [self.loginButton setHidden:NO];
    [self.isPersonButton setHidden:YES];
    [self.isTruckButton setHidden:YES];
}


#pragma mark - Actions

- (IBAction)onLoginPressed:(id)sender{



}


- (IBAction)onSignupPressed:(id)sender{

    [self.isPersonButton setHidden:NO];
    [self.isTruckButton setHidden:NO];
    [self.loginButton setHidden:YES];

}

- (IBAction)onIsPersonPressed:(id)sender {



}


- (IBAction)onIsTruckPressed:(id)sender {


}







@end
