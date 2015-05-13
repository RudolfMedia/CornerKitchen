//
//  AppDelegate.m
//  CornerKitchen
//
//  Created by Dan Rudolf on 5/5/15.
//  Copyright (c) 2015 com.rudolfmedia. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [Parse setApplicationId:@"HkRTw4cVCl4rX8aXpzH2njpM9Oulptji90VGr7fk"
                  clientKey:@"j1pI1viI2dY53O2MfOemWLbtYz9v2s7nwlF3FoJk"];

    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];

    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];


    [[UINavigationBar appearance] setTitleTextAttributes:@{
       NSForegroundColorAttributeName : [UIColor whiteColor],
       NSFontAttributeName : [UIFont fontWithName:@"Quicksand-Bold" size:22]

       }];

    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSFontAttributeName : [UIFont fontWithName:@"Quicksand-Bold" size:14.0f], NSForegroundColorAttributeName : [UIColor whiteColor] }
                                             forState:UIControlStateNormal];

    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor colorWithRed:(35/255.00) green:(211/255.00) blue:(131/255.00) alpha:1] }
                                             forState:UIControlStateSelected];

   CGRect screen =  [[UIScreen mainScreen] bounds];


    [[UITabBar appearance] setSelectionIndicatorImage:[AppDelegate imageFromColor:[UIColor whiteColor]
                                                                                   forSize:CGSizeMake(screen.size.width/2, 49)
                                                                                   withCornerRadius:0]];

    return YES;
}

+ (UIImage *)imageFromColor:(UIColor *)color forSize:(CGSize)size withCornerRadius:(CGFloat)radius
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    // Begin a new image that will be the new image with the rounded corners
    // (here with the size of an UIImageView)
    UIGraphicsBeginImageContext(size);

    // Add a clip before drawing anything, in the shape of an rounded rect
    [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius] addClip];
    // Draw your image
    [image drawInRect:rect];

    // Get the image, here setting the UIImageView image
    image = UIGraphicsGetImageFromCurrentImageContext();

    // Lets forget about that we were drawing
    UIGraphicsEndImageContext();
    
    return image;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
