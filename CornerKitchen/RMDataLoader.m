//
//  RMDataLoader.m
//  CornerKitchen
//
//  Created by Dan Rudolf on 5/5/15.
//  Copyright (c) 2015 com.rudolfmedia. All rights reserved.
//

#import "RMDataLoader.h"

@implementation RMDataLoader

-(void)createNewTruckUser:(NSString *)username
                 password:(NSString *)password
                truckName:(NSString *)truckName
               typeOfFood:(NSString *)typeOfFood
                ownerName:(NSString *)ownerName
                    image:(UIImage *)imageFile
               completion:(void (^)(NSError *error))onComplete{

    NSString *noSpace = [username stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];

    PFUser *newUser = [PFUser user];
    newUser.username = [noSpace lowercaseString];
    newUser.password = password;
    newUser[@"isTruck"] = [NSNumber numberWithBool:YES];

    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {

            PFObject *newTruck = [PFObject objectWithClassName:@"Truck"];
            newTruck[@"user"] = newUser;
            newTruck[@"name"] = truckName;
            newTruck[@"foodType"] = typeOfFood;
            newTruck[@"ownerName"] = ownerName;

            [newTruck saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {

                    NSData *raw = UIImagePNGRepresentation(imageFile);
                    PFFile *file = [PFFile fileWithName:@"truckImage.png" data:raw];
                    [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
                        if (succeeded) {

                            newTruck[@"profileImage"] = file;
                            [newTruck saveInBackgroundWithBlock:^(BOOL succeded, NSError *error){

                                if (succeeded) {
                                    onComplete(nil);
                                }
                                else{
                                    onComplete(error);
                                }

                            }];

                        }

                        else{
                            onComplete(error);
                        }

                    }];

                }

                else {
                    onComplete(error);
                }

            }];

        }

        else {
            onComplete(error);
        }

    }];

}




@end
