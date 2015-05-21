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
                     image:(PFFile *)imageFile
                completion:(void (^)(NSError *error))onComplete;



@end
