//
//  RMContentEditVCViewController.m
//  CornerKitchen
//
//  Created by Dan Rudolf on 5/12/15.
//  Copyright (c) 2015 com.rudolfmedia. All rights reserved.
//

#import "RMContentEditVC.h"
#import "RMTruckEditView.h"

@interface RMContentEditVC ()<UIScrollViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *contentScroll;
@property RMTruckEditView *editView;
@property NSString *errorString;
@property UIAlertView *alert;

#define kOFFSET_FOR_KEYBOARD 80.0

@end

@implementation RMContentEditVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.editView = [RMTruckEditView editForumInterface];
    self.contentScroll.delegate = self;
    [self.editView.saveIndicator setHidden:YES];

    self.contentScroll.contentSize = CGSizeMake(self.view.frame.size.width, self.editView.frame.size.height);

    self.contentScroll.decelerationRate = UIScrollViewDecelerationRateFast;
    [self.contentScroll addSubview:self.editView];

    [self roundViewCorners:self.editView.saveButton];
    [self roundViewCorners:self.editView.cancelButton];

    [self applySelectors];

    [self fillOutDetails:self.currentTruck];

    UITapGestureRecognizer *hideKeyboard = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(hidekeyboards)];
    [self.view addGestureRecognizer:hideKeyboard];


    UITapGestureRecognizer *changeImage = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                  action:@selector(presentImagePicker)];
    [self.editView.imageContainer addGestureRecognizer:changeImage];
    
}

#pragma mark - View formatting

- (UIView *)roundViewCorners:(UIView *)viewToRound{

    viewToRound.layer.masksToBounds = YES;
    viewToRound.layer.cornerRadius = 5;
    return viewToRound;
}

#pragma mark - ImageDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {

    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.editView.editScrollView.delegate = self;
    self.editView.editImageView.image = chosenImage;
    self.editView.editScrollView.minimumZoomScale = self.editView.imageContainer.frame.size.width / chosenImage.size.width;
    self.editView.editScrollView.zoomScale =  self.editView.editScrollView.minimumZoomScale;

    [picker dismissViewControllerAnimated:YES completion:NULL];

}


#pragma mark - ScrollView Delegate

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{

    return self.editView.editImageView;
}

#pragma mark - Selectors

- (void)applySelectors{

    [self.editView.cancelButton addTarget:self
                                   action:@selector(onCancelPressed)
                         forControlEvents:UIControlEventTouchUpInside];

    [self.editView.saveButton addTarget:self
                                 action:@selector(onSavePressed)
                       forControlEvents:UIControlEventTouchUpInside];

}

- (void)presentImagePicker{


    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;

    [self presentViewController:picker animated:YES completion:NULL];



}

- (void)onCancelPressed{


        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        RMContentEditVC *loginVC = [storyboard instantiateViewControllerWithIdentifier:@"LOGIN_MAIN"];

        [self presentViewController:loginVC animated:YES completion:^{
            
        }];

}

-(void)onSavePressed{

    if (self.editView.editImageView.image == nil) {

        self.errorString = @"Show Us Your Truck! We Know You Worked Hard On It.";
        self.alert = [[UIAlertView alloc] initWithTitle:@"Oops! \xF0\x9F\x99\x88"
                                                message:self.errorString
                                               delegate:self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
        [self.alert show];

    }

    else if (self.editView.truckLogin.text.length < 5){

        self.errorString = @"You Need An Email To Log In";
        self.alert = [[UIAlertView alloc] initWithTitle:@"Oops! \xF0\x9F\x99\x88"
                                                message:self.errorString
                                               delegate:self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
        [self.alert show];

    }

    else if (self.editView.truckName.text.length < 3){

        self.errorString = @"Please Enter Your Truck Name";
        self.alert = [[UIAlertView alloc] initWithTitle:@"Oops! \xF0\x9F\x99\x88"
                                                message:self.errorString
                                               delegate:self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
        [self.alert show];

    }
    else if (self.editView.truckFoodType.text.length < 3){

        self.errorString = @"Tell Us What Kind Of Food You Serve";
        self.alert = [[UIAlertView alloc] initWithTitle:@"Oops! \xF0\x9F\x99\x88"
                                                message:self.errorString
                                               delegate:self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
        [self.alert show];

    }

    else if (self.editView.ownerName.text.length <1){

        self.errorString = @"Please Enter Your Name";
        self.alert = [[UIAlertView alloc] initWithTitle:@"Oops! \xF0\x9F\x99\x88"
                                                message:self.errorString
                                               delegate:self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
        [self.alert show];


    }

    else{

        if ([PFUser currentUser]) {


        }

        else{

        [self.editView.saveButton setHidden:YES];
        [self.editView.cancelButton setHidden:YES];
        [self.editView.saveIndicator startAnimating];
        [self.editView.saveIndicator setHidden:NO];

        PFUser *newUser = [PFUser user];
        newUser.username = [self.editView.truckLogin.text lowercaseString];
        newUser.password = self.currentTruck.password;
        newUser[@"isTruck"] = [NSNumber numberWithBool:YES];

        [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {

            if (!error) {

                PFObject *truck = [PFObject objectWithClassName:@"Truck"];
                truck[@"name"] = self.editView.truckName.text;
                truck[@"ownerName"] = self.editView.ownerName.text;
                truck[@"foodType"] = self.editView.truckFoodType.text;
                truck[@"user"] = [PFUser currentUser];

                [truck saveInBackgroundWithBlock:^(BOOL suceeded, NSError *error){

                    if (!error) {
                        
                        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                        UITabBarController *truckMain = [storyboard instantiateViewControllerWithIdentifier:@"TRUCK_MAIN"];

                        [self presentViewController:truckMain animated:YES completion:^{



                        }];

                    }

                    else{

                        [self.editView.saveButton setHidden:NO];
                        [self.editView.cancelButton setHidden:NO];
                        [self.editView.saveIndicator stopAnimating];
                        [self.editView.saveIndicator setHidden:YES];

                        self.errorString = @"Something Went Wrong, Please Try Again";
                        self.alert = [[UIAlertView alloc] initWithTitle:@"Oops! \xF0\x9F\x99\x88"
                                                                message:self.errorString
                                                               delegate:self
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                        [self.alert show];
                    }

                }];

            }


            else {

                [self.editView.saveButton setHidden:NO];
                [self.editView.cancelButton setHidden:NO];
                [self.editView.saveIndicator stopAnimating];
                [self.editView.saveIndicator setHidden:YES];

                NSString *errorString = [error userInfo][@"error"];

                self.alert = [[UIAlertView alloc] initWithTitle:@"Oops! \xF0\x9F\x99\x88"
                                                        message:errorString
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
                [self.alert show];

            }
        }];


    }

    }



}

- (void)hidekeyboards{

    [self.editView.truckName resignFirstResponder];
    [self.editView.truckFoodType resignFirstResponder];
    [self.editView.ownerName resignFirstResponder];
    [self.editView.truckLogin resignFirstResponder];

}

#pragma mark - content Population

- (void)fillOutDetails:(RMTruck *)visible{

    self.editView.truckLogin.text = visible.email;


}

#pragma mark - KeyBoard Delegate


-(void)keyboardWillShow {
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

-(void)keyboardWillHide {
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)sender
{
    if ([sender isEqual:self.editView.truckLogin])
    {
        if  (self.view.frame.origin.y >= 0)
        {
            [self setViewMovedUp:YES];
        }
    }
}

-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];

    CGRect rect = self.view.frame;
    if (movedUp)
    {
               rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        rect.size.height += kOFFSET_FOR_KEYBOARD;
    }
    else
    {
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        rect.size.height -= kOFFSET_FOR_KEYBOARD;
    }
    self.view.frame = rect;

    [UIView commitAnimations];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}















@end
