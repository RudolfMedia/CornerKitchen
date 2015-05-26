//
//  RMTruckEditView.h
//  CornerKitchen
//
//  Created by Dan Rudolf on 5/12/15.
//  Copyright (c) 2015 com.rudolfmedia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RMTruckEditView : UIView

+(id)editForumInterface;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIView *imageContainer;
@property (weak, nonatomic) IBOutlet UIScrollView *editScrollView;
@property (weak, nonatomic) IBOutlet UIImageView *editImageView;
@property (weak, nonatomic) IBOutlet UITextField *truckName;
@property (weak, nonatomic) IBOutlet UITextField *truckFoodType;
@property (weak, nonatomic) IBOutlet UITextField *ownerName;
@property (weak, nonatomic) IBOutlet UITextField *truckLogin;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *saveIndicator;
@property (weak, nonatomic) IBOutlet UIButton *positionButton;

@end
