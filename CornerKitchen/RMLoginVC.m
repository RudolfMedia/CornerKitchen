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




}

-(void)viewWillAppear:(BOOL)animated{

    [self.isPersonButton setHidden:YES];
    [self.isTruckButton setHidden:YES];
    
}


#pragma mark - Actions

- (IBAction)onLoginPressed:(id)sender{



}


- (IBAction)onSignupPressed:(id)sender{

    [self.isPersonButton setHidden:NO];
    [self.isTruckButton setHidden:NO];

}

- (IBAction)onIsPersonPressed:(id)sender {



}


- (IBAction)onIsTruckPressed:(id)sender {


}







@end
