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

- (void)createNewRegularUser:(NSString *)username
                    password:(NSString *)password
                  onComplete:(void (^)(NSError *error))callback{

    PFUser *newUser = [PFUser user];
    newUser.username = username;
    newUser.password = password;
    newUser[@"isTruck"] = [NSNumber numberWithBool:NO];

    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            callback(nil);
        }

        else {
            callback(error);
        }

    }];


}

- (void)retreiveCurrentTruckForUser:(PFUser *)currentUser
                         onComplete:(void (^)(NSError *error, PFObject *truck))callback{

    PFQuery *query = [PFQuery queryWithClassName:@"Truck"];
    [query whereKey:@"user" equalTo:currentUser];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {

        if (objects.count == 1) {
            callback(nil, objects.firstObject);
        }
        else{

            NSError *findError = [[NSError alloc] initWithDomain:@"No Profile" code:101 userInfo:@{@"user" : @"Erro Retreiving Profile"}];
            callback(findError, nil);
        }

    }];

}


-(void)updateCurrentTruckProfile:(PFObject *)truck
                       truckName:(NSString *)truckName
                      typeOfFood:(NSString *)typeOfFood
                       ownerName:(NSString *)ownerName
                           image:(UIImage *)image
                      onComplete:(void (^)(NSError *))onComplete{

    PFObject *currentTruck = truck;
    currentTruck[@"name"] = truckName;
    currentTruck[@"foodType"] = typeOfFood;
    currentTruck[@"ownerName"] = ownerName;

    [currentTruck saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {

            NSData *raw = UIImagePNGRepresentation(image);
            PFFile *file = [PFFile fileWithName:@"truckImage.png" data:raw];
            [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
                if (succeeded) {

                    currentTruck[@"profileImage"] = file;
                    [currentTruck saveInBackgroundWithBlock:^(BOOL succeded, NSError *error){

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

- (void)getMenuItemsForCurrentTruck:(PFObject *)truck
                         onComplete:(void (^)(NSError *error, NSArray *menuItems))callback{

    PFQuery *menuQuery = [PFQuery queryWithClassName:@"MenuItem"];
    [menuQuery whereKey:@"truck" equalTo:truck];
    [menuQuery orderByAscending:@"name"];
    [menuQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {

        if (!error) {

            callback(nil, objects);
        }

        else {
            callback(error, nil);

        }


    }];

}


-(void)addNewMenuItemToCurrentTruck:(PFObject *)truck
                               name:(NSString *)name
                        description:(NSString *)description
                              price:(NSString *)price
                         onComplete:(void (^)(BOOL succeeded, NSError *error))onComplete{

    PFObject *menuItem = [PFObject objectWithClassName:@"MenuItem"];
    menuItem[@"name"] = name;
    menuItem[@"description"] = description;
    menuItem[@"price"] = price;
    menuItem[@"truck"] = truck;

    [menuItem saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error){

        if (succeeded) {
            onComplete(succeeded, nil);
        }
        else{
            onComplete(nil, error);
        }

    }];
}






@end
