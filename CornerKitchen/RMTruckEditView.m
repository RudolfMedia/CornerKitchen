//
//  RMTruckEditView.m
//  CornerKitchen
//
//  Created by Dan Rudolf on 5/12/15.
//  Copyright (c) 2015 com.rudolfmedia. All rights reserved.
//

#import "RMTruckEditView.h"

@implementation RMTruckEditView

+(id)editForumInterface{

    RMTruckEditView *customView = [[[NSBundle mainBundle] loadNibNamed:@"RMTruckEditView"
                                                                 owner:nil
                                                               options:nil] lastObject];

    if ([customView isKindOfClass:[RMTruckEditView class]]) {

        return customView;

    }

    else{

    return nil;

    }

}

@end
