//
//  RMViewAnimator.m
//  CornerKitchen
//
//  Created by Dan Rudolf on 5/23/15.
//  Copyright (c) 2015 com.rudolfmedia. All rights reserved.
//

#import "RMViewAnimator.h"

@implementation RMViewAnimator


- (void)alphaInView:(UIView *)view{

    view.alpha = 0;
    [UIView animateWithDuration:.2
                     animations:^{
                         view.alpha = 1;
                     }
                     completion:^(BOOL finished) {

                     }];
}

- (void)alphaOutView:(UIView *)view{

    view.alpha = 1;
    [UIView animateWithDuration:.2
                     animations:^{
                         view.alpha = 0;
                     }
                     completion:^(BOOL finished) {

                     }];}

@end
