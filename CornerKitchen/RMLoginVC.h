//
//  ViewController.h
//  CornerKitchen
//
//  Created by Dan Rudolf on 5/5/15.
//  Copyright (c) 2015 com.rudolfmedia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <Parse/Parse.h>
#import "RMDataLoader.h"

@interface RMLoginVC : UIViewController

@property RMDataLoader *dataLoader;
@property PFObject *currentPFTruck;

@end

