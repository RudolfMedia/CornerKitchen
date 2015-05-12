//
//  RMTruckEditVC.m
//  CornerKitchen
//
//  Created by Dan Rudolf on 5/5/15.
//  Copyright (c) 2015 com.rudolfmedia. All rights reserved.
//

#import "RMTruckEditVC.h"
#import "RMTruckDetailView.h"
#import "RMContentEditVC.h"

@interface RMTruckEditVC ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *contentScroll;
@property RMTruckDetailView *detailView;

@end

@implementation RMTruckEditVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.detailView = [RMTruckDetailView truckDetailCustomView];
    self.contentScroll.delegate = self;
    self.contentScroll.contentSize = CGSizeMake(self.view.frame.size.width, self.detailView.frame.size.height);
    self.contentScroll.decelerationRate = UIScrollViewDecelerationRateFast;

    [self roundViewCorners:self.detailView.menuTableView];
    [self roundViewCorners:self.detailView.menutView];
    [self roundViewCorners:self.detailView.editProfileButton];


    [self.contentScroll addSubview:self.detailView];
    [self applySelectors];


}


#pragma mark - ViewFormatting

- (UIView *)roundViewCorners:(UIView *)viewToRound{

    viewToRound.layer.masksToBounds = YES;
    viewToRound.layer.cornerRadius = 5;
    return viewToRound;
}

#pragma mark - Selectors

-(void)applySelectors{

    [self.detailView.editProfileButton addTarget:self
                                          action:@selector(onEditPressed)
                                forControlEvents:UIControlEventTouchUpInside];

}

-(void)onEditPressed{

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    RMContentEditVC *editVC = [storyboard instantiateViewControllerWithIdentifier:@"EditTruck"];

    [self presentViewController:editVC animated:YES completion:^{

    }];

}


@end
