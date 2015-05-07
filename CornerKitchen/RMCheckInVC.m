//
//  RMCheckInVC.m
//  CornerKitchen
//
//  Created by Dan Rudolf on 5/5/15.
//  Copyright (c) 2015 com.rudolfmedia. All rights reserved.
//

#import "RMCheckInVC.h"

@interface RMCheckInVC ()<MKMapViewDelegate, CLLocationManagerDelegate>


@property (weak, nonatomic) IBOutlet MKMapView *checkinMapView;
@property CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet UIButton *checkinButton;

@end

@implementation RMCheckInVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;

    self.checkinButton.layer.masksToBounds = YES;
    self.checkinButton.layer.cornerRadius = 5;


}

- (void)viewDidAppear:(BOOL)animated{

    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"checkinMarker"]];

    [imageView setCenter:CGPointMake(self.checkinMapView.frame.size.width/2,
                                     self.checkinMapView.frame.size.height/2 - (imageView.frame.size.height/2))];

    [self.checkinMapView.superview addSubview:imageView];

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

    self.checkinButton.alpha = 0;
    [UIView animateWithDuration:.2
                     animations:^{
                         self.checkinButton.alpha = 1;
                     }
                     completion:^(BOOL finished) {
                         
                     }];

}

-(void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated{

    self.checkinButton.alpha = 1;
    [UIView animateWithDuration:.2
                     animations:^{
                         self.checkinButton.alpha = 0;
                     }
                     completion:^(BOOL finished) {
                         

                     }];
}


-(void)setMapViewRegionWithLocation:(CLLocationCoordinate2D)location{

    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(location, 500, 500);
    [self.checkinMapView setRegion:region animated:NO];



}

#pragma mark - Actions

- (IBAction)onCheckinPressed:(id)sender {



}


@end
