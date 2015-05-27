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

    if (view.alpha == 0) {

    view.alpha = 0;
    [UIView animateWithDuration:.2
                     animations:^{
                         view.alpha = 1;
                     }
                     completion:^(BOOL finished) {

                     }];
    }
}

- (void)alphaOutView:(UIView *)view{

    if (view.alpha == 1) {

    view.alpha = 1;
    [UIView animateWithDuration:.2
                     animations:^{
                         view.alpha = 0;
                     }
                     completion:^(BOOL finished) {

                     }];
    }

}

@end
