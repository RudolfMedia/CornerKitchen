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
                completion:(void (^) (NSError *error))onComplete;

- (void)createNewRegularUser:(NSString *)username
                    password:(NSString *)password
                  onComplete:(void (^) (NSError *))callback;

- (void)retreiveCurrentTruckForUser:(PFUser *)currentUser
                         onComplete:(void (^) (NSError *error, PFObject *truck))callback;

- (void)updateCurrentTruckProfile:(PFObject *)truck truckName:(NSString *)truckname
                       typeOfFood:(NSString *)typeOfFood
                        ownerName:(NSString *)ownerName
                            image:(UIImage *)image
                       onComplete:(void (^) (NSError *error))onComplete;

- (void)getMenuItemsForCurrentTruck:(PFObject *)truck
                         onComplete:(void (^) (NSError *error, NSArray *items))callback;

- (void)addNewMenuItemToCurrentTruck:(PFObject *)truck
                                name:(NSString *)name
                         description:(NSString *)description
                               price:(NSString *)price
                          onComplete:(void (^) (BOOL succeeded, NSError *error))onComplete;

@end
