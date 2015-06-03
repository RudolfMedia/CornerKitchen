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
#import "RMMenuCell.h"
#import "SCLAlertView.h"

@interface RMTruckEditVC ()<UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIScrollView *contentScroll;
@property RMTruckDetailView *detailView;
@property RMMenuCell *menuCell;
@property UIImage *truckImage;
@property NSMutableArray *menuArray;
@property UIColor *green;


@end

@implementation RMTruckEditVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.detailView = [RMTruckDetailView truckDetailCustomView];
    self.menuArray = [NSMutableArray new];
    self.green = [UIColor colorWithRed:(26/255.0f) green:(216/255.0f) blue:(149/255.0f) alpha:1];

    self.contentScroll.delegate = self;
    self.contentScroll.contentSize = CGSizeMake(self.view.frame.size.width, self.detailView.frame.size.height);
    self.contentScroll.decelerationRate = UIScrollViewDecelerationRateFast;

    [self addButtonCorner:self.detailView.editMenuButton];
    [self addButtonCorner:self.detailView.checkoutButton];
    [self addButtonCorner:self.detailView.addMenuItemButton];
    self.detailView.editProfileButton.layer.borderWidth = 2;
    self.detailView.editProfileButton.layer.borderColor = self.green.CGColor;

    [self roundViewCorners:self.detailView.editMenuButton];
    [self roundViewCorners:self.detailView.checkoutButton];
    [self roundViewCorners:self.detailView.truckDetailViewLogout];
    [self roundViewCorners:self.detailView.menuTableView];
    [self roundViewCorners:self.detailView.menutView];
    [self roundViewCorners:self.detailView.editProfileButton];
    [self roundViewCorners:self.detailView.locationContainer];
    [self roundViewCorners:self.detailView.locationView];
    [self roundViewCorners:self.detailView.addMenuItemButton];


    [self.contentScroll addSubview:self.detailView];
    [self applySelectors];

    UINib *cellNib = [UINib nibWithNibName:@"RMMenuCell" bundle:nil];
    [self.detailView.menuTableView registerNib:cellNib
                        forCellReuseIdentifier:@"MENU_CELL"];

    self.detailView.menuTableView.delegate = self;
    self.detailView.menuTableView.dataSource = self;
    self.detailView.menuTableView.separatorInset = UIEdgeInsetsZero;


    [self populateViewWithCurrentTruck:self.currentPFTruck];
    [self downloadMenuContent];

}



#pragma mark - TableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.menuArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    PFObject *item = [self.menuArray objectAtIndex:indexPath.row];
    self.menuCell = [tableView dequeueReusableCellWithIdentifier:@"MENU_CELL" forIndexPath:indexPath];

    self.menuCell.menuItemName.text = item[@"name"];
    self.menuCell.menuItemDescription = item[@"description"];
    self.menuCell.menuPrice = item[@"price"];

    return self.menuCell;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{

    if (editingStyle == UITableViewCellEditingStyleDelete) {
        PFObject *itemToDelete = [self.menuArray objectAtIndex:indexPath.row];

        [itemToDelete deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error){

            if (succeeded) {

                [self.menuArray removeObjectAtIndex:indexPath.row];
                [self.detailView.menuTableView reloadData];
            }


         }];
    }

    else if (editingStyle == UITableViewCellEditingStyleInsert){

        //insertRow
    }


}



#pragma mark - ViewFormatting

- (UIView *)roundViewCorners:(UIView *)viewToRound{

    viewToRound.layer.masksToBounds = YES;
    viewToRound.layer.cornerRadius = 5;
    return viewToRound;

}

- (UIButton *)addButtonCorner:(UIButton *)button{

    button.layer.borderWidth = 2;
    button.layer.borderColor = [UIColor whiteColor].CGColor;
    button.layer.borderColor = [UIColor whiteColor].CGColor;

    return button;
}

#pragma mark - Selectors

-(void)applySelectors{

    [self.detailView.editProfileButton addTarget:self
                                          action:@selector(onEditPressed)
                                forControlEvents:UIControlEventTouchUpInside];

    [self.detailView.editMenuButton addTarget:self
                                       action:@selector(onEditMenuPressed)
                             forControlEvents:UIControlEventTouchUpInside];

    [self.detailView.addMenuItemButton addTarget:self
                                          action:@selector(addMenuItem)
                                forControlEvents:UIControlEventTouchUpInside];

}

-(void)onEditMenuPressed{

    if (self.detailView.menuTableView.isEditing) {

        [self.detailView.menuTableView setEditing:NO animated:YES];
    }
    else{

        [self.detailView.menuTableView setEditing:YES animated:YES];
    }
}

- (void)addMenuItem{

    SCLAlertView *newItem = [[SCLAlertView alloc] initWithNewWindow];
    UITextField *nameField = [newItem addTextField:@"Item Name"];
    UITextField *description = [newItem addTextField:@"Description"];
    description.autocapitalizationType = UITextAutocapitalizationTypeSentences;
    UITextField *price = [newItem addTextField:@"Price"];
    [price setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
    price.text = @"$";

    __block RMTruckEditVC *nonRetainSelf = self;
    [newItem addButton:@"Save" actionBlock:^{
        if (nameField.text.length > 3 &&
            description.text.length > 3 &&
            price.text.length >= 1) {

            [self.dataLoader addNewMenuItemToCurrentTruck:self.currentPFTruck name:nameField.text description:description.text price:price.text onComplete:^(BOOL succeeded, NSError *error) {

                if (succeeded) {
                    [nonRetainSelf downloadMenuContent];

                }

            }];

        }
        else{

            SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
            [alert showError:@"Oops! \xF0\x9F\x99\x88"
                    subTitle:@"Missing info! Please fill out all of your menu item details and try again."
            closeButtonTitle:@"OK" duration:0.0f];

        }

    }];

    [newItem showCustom:[UIImage imageNamed:@""]
                  color:self.green
                  title:@"Add Item"
               subTitle:@"Please add a Name, Description and Price for this item."
       closeButtonTitle:@"Cancel"
               duration:0.0f];

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

- (void)downloadMenuContent{

    [self.menuArray removeAllObjects];

    [self.dataLoader getMenuItemsForCurrentTruck:self.currentPFTruck onComplete:^(NSError *error, NSArray *items) {

        if (!error) {
            for (PFObject *menuItem in items) {
                [self.menuArray addObject:menuItem];
                [self.detailView.menuTableView reloadData];

            }
            
        }
        
    }];
    
}


@end
