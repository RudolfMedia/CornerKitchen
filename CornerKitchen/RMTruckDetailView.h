//
//  RMTruckDetailView.h
//  CornerKitchen
//
//  Created by Dan Rudolf on 5/9/15.
//  Copyright (c) 2015 com.rudolfmedia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RMTruckDetailView : UIView

+ (id)truckDetailCustomView;
@property (weak, nonatomic) IBOutlet UIView *menutView;
@property (weak, nonatomic) IBOutlet UITableView *menuTableView;
@property (weak, nonatomic) IBOutlet UIButton *editProfileButton;

@end
