//
//  RMTruckEditVC.h
//  CornerKitchen
//
//  Created by Dan Rudolf on 5/5/15.
//  Copyright (c) 2015 com.rudolfmedia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RMDataLoader.h"
#import <Parse/Parse.h>

@interface RMTruckEditVC : UIViewController

@property RMDataLoader *dataLoader;
@property PFObject *currentPFTruck;

@end
