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

@interface RMTruckEditVC ()<UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIScrollView *contentScroll;
@property RMTruckDetailView *detailView;
@property RMMenuCell *menuCell;
@property UIImage *truckImage;
@property NSMutableArray *menuArray;


@end

@implementation RMTruckEditVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.detailView = [RMTruckDetailView truckDetailCustomView];
    self.menuArray = [NSMutableArray new];

    self.contentScroll.delegate = self;
    self.contentScroll.contentSize = CGSizeMake(self.view.frame.size.width, self.detailView.frame.size.height);
    self.contentScroll.decelerationRate = UIScrollViewDecelerationRateFast;

    [self addButtonCorner:self.detailView.editMenuButton];
    [self addButtonCorner:self.detailView.checkoutButton];
    self.detailView.editProfileButton.layer.borderWidth = 2;
    self.detailView.editProfileButton.layer.borderColor = [UIColor colorWithRed:(26/255.0f) green:(216/255.0f) blue:(149/255.0f) alpha:1].CGColor;

    [self roundViewCorners:self.detailView.editMenuButton];
    [self roundViewCorners:self.detailView.checkoutButton];
    [self roundViewCorners:self.detailView.truckDetailViewLogout];
    [self roundViewCorners:self.detailView.menuTableView];
    [self roundViewCorners:self.detailView.menutView];
    [self roundViewCorners:self.detailView.editProfileButton];
    [self roundViewCorners:self.detailView.locationContainer];
    [self roundViewCorners:self.detailView.locationView];


    [self.contentScroll addSubview:self.detailView];
    [self applySelectors];

    UINib *cellNib = [UINib nibWithNibName:@"RMMenuCell" bundle:nil];
    [self.detailView.menuTableView registerNib:cellNib
                        forCellReuseIdentifier:@"MENU_CELL"];

    self.detailView.menuTableView.delegate = self;
    self.detailView.menuTableView.dataSource = self;
    self.detailView.menuTableView.separatorInset = UIEdgeInsetsZero;


    [self populateViewWithCurrentTruck:self.currentPFTruck];
    [self menuContent];

}



#pragma mark - TableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.menuArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    PFObject *item = [self.menuArray objectAtIndex:indexPath.row];
    self.menuCell = [tableView dequeueReusableCellWithIdentifier:@"MENU_CELL" forIndexPath:indexPath];

    self.menuCell.menuItemName.text = item[@"name"];

    return self.menuCell;
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
    //[UIColor colorWithRed:(26/255.0f) green:(216/255.0f) blue:(149/255.0f) alpha:1].CGColor;

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

}

-(void)onEditMenuPressed{

    [self.detailView.menuTableView setEditing:YES animated:YES];

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

- (void)menuContent{

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
