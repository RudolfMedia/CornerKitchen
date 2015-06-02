//
//  RMCheckInVC.m
//  CornerKitchen
//
//  Created by Dan Rudolf on 5/5/15.
//  Copyright (c) 2015 com.rudolfmedia. All rights reserved.
//

#import "RMCheckInVC.h"
#import "AppDelegate.h"
#import "RMViewAnimator.h"
#import "RMDataLoader.h"
#import "SCLAlertView.h"
#import "RMTruckEditVC.h"

@interface RMCheckInVC ()<MKMapViewDelegate, CLLocationManagerDelegate, UITabBarControllerDelegate>


@property (weak, nonatomic) IBOutlet MKMapView *checkinMapView;
@property (weak, nonatomic) IBOutlet UIButton *checkinButton;
@property RMViewAnimator *animator;
@property RMDataLoader *dataLoader;
@property CLLocationCoordinate2D checkinLocationCoordinate;
@property CLLocationManager *locationManager;

@end

@implementation RMCheckInVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.delegate = self;
    [self setUpTabBar];

    self.dataLoader = [[RMDataLoader alloc] init];

    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;

    self.checkinButton.layer.masksToBounds = YES;
    self.checkinButton.layer.cornerRadius = 5;

    self.animator = [[RMViewAnimator alloc] init];
    [self getTruck];

}

- (void)viewDidAppear:(BOOL)animated{

    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"checkinMarker"]];

    [imageView setCenter:CGPointMake(self.checkinMapView.frame.size.width/2,
                                     self.checkinMapView.frame.size.height/2 - (imageView.frame.size.height/2))];

    [self.checkinMapView.superview addSubview:imageView];

}

- (void)getTruck{

    [self.dataLoader retreiveCurrentTruckForUser:[PFUser currentUser]
                                      onComplete:^(NSError *error, PFObject *truck) {
                                          if (!error) {

                                              self.currentPFTruck = truck;

                                          }

                                          else{

                                              NSLog(@"Error: %@ %@", error, [error userInfo]);
                                              SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
                                              [alert addButton:@"Try Again" actionBlock:^{

                                              [self getTruck];

                                              }];

                                              [alert showError:@"Oops! \xF0\x9F\x99\x88"
                                                      subTitle:@"Error Retreiving your profile"
                                              closeButtonTitle:@"OK" duration:0.0f];
                                              
                                          }
                                      }];
    
    
}


#pragma mark - Location Manager Delegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{

    for (CLLocation *current in locations) {

        if (current.horizontalAccuracy < 150 && current.verticalAccuracy < 150) {

            [self.locationManager stopUpdatingLocation];
            [self setMapViewRegionWithLocation:self.locationManager.location.coordinate];
            break;

        }
    }

}


-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{

    NSLog(@"%@", error);

}

#pragma mark - Mapview Delegate

-(void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{

    [self.animator alphaInView:self.checkinButton];

}

-(void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated{

    [self.animator alphaOutView:self.checkinButton];
}


-(void)setMapViewRegionWithLocation:(CLLocationCoordinate2D)location{

    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(location, 500, 500);
    [self.checkinMapView setRegion:region animated:NO];

}

#pragma mark - TabBarDelegate

-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{

    if ([viewController.childViewControllers.firstObject isKindOfClass:[RMTruckEditVC class]]) {
        RMTruckEditVC *destination = (RMTruckEditVC *)viewController.childViewControllers.firstObject;
        destination.dataLoader = self.dataLoader;
        destination.currentPFTruck = self.currentPFTruck;

    }
    return TRUE;
}

#pragma mark - Actions

- (IBAction)onCheckinPressed:(id)sender {

    self.checkinLocationCoordinate = self.checkinMapView.centerCoordinate;
    NSLog(@"%f", self.checkinLocationCoordinate.latitude);

}


#pragma mark - View Formatting

- (void)setUpTabBar{

    UITabBar *customTabBar = self.tabBarController.tabBar;

    UITabBarItem *checkinTab = [customTabBar.items objectAtIndex:0];
    checkinTab.image = [[UIImage imageNamed:@"checkin"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    checkinTab.selectedImage = [[UIImage imageNamed:@"checkinPressed"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    checkinTab.title = @"Location";

    UITabBarItem *profileTab = [customTabBar.items objectAtIndex:1];
    profileTab.image = [[UIImage imageNamed:@"profile"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    profileTab.selectedImage = [[UIImage imageNamed:@"profilePressed"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    profileTab.title = @"Profile";


}


@end
