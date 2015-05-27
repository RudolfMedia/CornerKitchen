//
//  RMDataLoader.h
//  CornerKitchen
//
//  Created by Dan Rudolf on 5/5/15.
//  Copyright (c) 2015 com.rudolfmedia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface RMDataLoader : NSObject

//create new truck user
//create new regular user
//login

- (void)createNewTruckUser:(NSString *)username
                  password:(NSString *)password
                 truckName:(NSString *)truckName
                typeOfFood:(NSString *)typeOfFood
                 ownerName:(NSString *)ownerName
                     image:(UIImage *)imageFile
                completion:(void (^)(NSError *error))onComplete;

- (void)createNewRegularUser:(NSString *)username
                    password:(NSString *)password
                  onComplete:(void (^) (NSError *))callback;

- (void)retreiveCurrentTruckForUser:(PFUser *)currentUser
                         onComplete:(void (^)(NSError *error, PFObject *truck))callback;

@end
