//
//  RMMenuCell.h
//  CornerKitchen
//
//  Created by Dan Rudolf on 6/2/15.
//  Copyright (c) 2015 com.rudolfmedia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RMMenuCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *menuItemName;
@property (weak, nonatomic) IBOutlet UITextView *menuItemDescription;
@property (weak, nonatomic) IBOutlet UILabel *menuPrice;

@end
