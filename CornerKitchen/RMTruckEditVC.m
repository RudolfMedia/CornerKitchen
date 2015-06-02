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
#import "RMTruck.h"

@interface RMTruckEditVC ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *contentScroll;
@property RMTruckDetailView *detailView;
@property UIImage *truckImage;

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

    [self populateViewWithCurrentTruck:self.currentPFTruck];


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

    [self performSegueWithIdentifier:@"EDIT_TRUCK_LOGGED" sender:self];

}

- (void)populateViewWithCurrentTruck:(PFObject *)truck{

    [self.detailView.activityIndicator startAnimating];
    [self.detailView.activityIndicator setHidden:NO];
    self.detailView.truckName.text = truck[@"name"];
    self.detailView.foodType.text = truck[@"foodType"];

    PFFile *truckPhotoFile = truck[@"profileImage"];
    [truckPhotoFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
        if (!error) {

            self.truckImage = [UIImage imageWithData:imageData];
            self.detailView.truckImage.image = self.truckImage;
        }

    }];

    [self.detailView.activityIndicator stopAnimating];
    [self.detailView.activityIndicator setHidden:YES];


}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    if ([segue.identifier isEqualToString:@"EDIT_TRUCK_LOGGED"]) {
        RMContentEditVC *destintion = [segue destinationViewController];
        destintion.cameFromLogin = YES;
        destintion.currentPFTruck = self.currentPFTruck;
        destintion.truckImage = self.truckImage;
    }

}

- (IBAction)unwindFromDetail:(UIStoryboardSegue *)segue{

    [self.dataLoader retreiveCurrentTruckForUser:[PFUser currentUser]
                                      onComplete:^(NSError *error, PFObject *truck) {

                                          if (!error) {

                                              self.currentPFTruck = truck;
                                              [self populateViewWithCurrentTruck:truck];
                                          }
    }];
}


@end
