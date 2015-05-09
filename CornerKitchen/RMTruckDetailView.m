//
//  RMTruckDetailView.m
//  CornerKitchen
//
//  Created by Dan Rudolf on 5/9/15.
//  Copyright (c) 2015 com.rudolfmedia. All rights reserved.
//

#import "RMTruckDetailView.h"

@implementation RMTruckDetailView

+ (id)truckDetailCustomView{

    RMTruckDetailView *detailView = [[[NSBundle mainBundle] loadNibNamed:@"RMTruckDetailView"
                                                                   owner:nil
                                                                 options:nil] lastObject];

    if ([detailView isKindOfClass:[RMTruckDetailView class]]) {

        return detailView;

    }
    else{
        return nil;
    }

}

@end
