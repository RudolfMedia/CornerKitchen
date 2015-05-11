//
//  RMTruckEditVC.m
//  CornerKitchen
//
//  Created by Dan Rudolf on 5/5/15.
//  Copyright (c) 2015 com.rudolfmedia. All rights reserved.
//

#import "RMTruckEditVC.h"
#import "RMTruckDetailView.h"

@interface RMTruckEditVC ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *contentScroll;
@property RMTruckDetailView *detailView;

@end

@implementation RMTruckEditVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.detailView = [RMTruckDetailView truckDetailCustomView];
    self.contentScroll.delegate = self;
    //self.contentScroll.contentSize = CGSizeMake(self.view.frame.size.width, self.detailView.frame.size.height);
    //CGRect sizedFrame = CGRectMake(0, 0, self.view.frame.size.width, self.detailView.frame.size.height);
    //self.detailView.frame = sizedFrame;

    [self.contentScroll addSubview:self.detailView];


}



@end
