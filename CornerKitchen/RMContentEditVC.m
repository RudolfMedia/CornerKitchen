//
//  RMContentEditVCViewController.m
//  CornerKitchen
//
//  Created by Dan Rudolf on 5/12/15.
//  Copyright (c) 2015 com.rudolfmedia. All rights reserved.
//

#import "RMContentEditVC.h"
#import "RMTruckEditView.h"

@interface RMContentEditVC ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *contentScroll;
@property RMTruckEditView *editView;


@end

@implementation RMContentEditVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.editView = [RMTruckEditView editForumInterface];
    self.contentScroll.delegate = self;


    self.contentScroll.contentSize = CGSizeMake(self.view.frame.size.width, self.editView.frame.size.height);

    self.contentScroll.decelerationRate = UIScrollViewDecelerationRateFast;
    [self.contentScroll addSubview:self.editView];

    [self roundViewCorners:self.editView.saveButton];
    [self roundViewCorners:self.editView.cancelButton];

    [self applySelectors];
}

#pragma mark - View formatting

- (UIView *)roundViewCorners:(UIView *)viewToRound{

    viewToRound.layer.masksToBounds = YES;
    viewToRound.layer.cornerRadius = 5;
    return viewToRound;
}

#pragma mark - Selectors

- (void)applySelectors{

    [self.editView.cancelButton addTarget:self
                                   action:@selector(onCancelPressed)
                         forControlEvents:UIControlEventTouchUpInside];

}

- (void)onCancelPressed{

    [self dismissViewControllerAnimated:YES completion:^{


    }];
}


@end
