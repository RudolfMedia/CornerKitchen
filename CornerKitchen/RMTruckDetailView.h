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
@property (weak, nonatomic) IBOutlet UIView *scrollContainerView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UITableView *menuTableView;
@property (weak, nonatomic) IBOutlet UIButton *editProfileButton;
@property (weak, nonatomic) IBOutlet UIImageView *truckImage;
@property (weak, nonatomic) IBOutlet UILabel *truckName;
@property (weak, nonatomic) IBOutlet UILabel *foodType;
@property (weak, nonatomic) IBOutlet UIButton *truckDetailViewLogout;
@property (weak, nonatomic) IBOutlet UIView *locationContainer;
@property (weak, nonatomic) IBOutlet UIView *locationView;
@property (weak, nonatomic) IBOutlet UIButton *checkoutButton;
@property (weak, nonatomic) IBOutlet UIButton *editMenuButton;

@end
