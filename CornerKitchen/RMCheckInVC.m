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

@end

@implementation RMCheckInVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;

}

- (void)viewDidAppear:(BOOL)animated{

    [self.locationManager startUpdatingLocation];

}

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


-(void)setMapViewRegionWithLocation:(CLLocationCoordinate2D)location{

    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(location, 500, 500);
    [self.checkinMapView setRegion:region animated:YES];

}



@end
