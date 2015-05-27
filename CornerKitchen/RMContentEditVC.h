//
//  RMContentEditVCViewController.h
//  CornerKitchen
//
//  Created by Dan Rudolf on 5/12/15.
//  Copyright (c) 2015 com.rudolfmedia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RMTruck.h"
#import <Parse/Parse.h>

@interface RMContentEditVC : UIViewController

@property (nonatomic, weak) RMTruck *currentTruck;
@property PFObject *currentPFTruck;
@property BOOL cameFromLogin;

@end
