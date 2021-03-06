//
//  RMContentEditVCViewController.m
//  CornerKitchen
//
//  Created by Dan Rudolf on 5/12/15.
//  Copyright (c) 2015 com.rudolfmedia. All rights reserved.
//

#import "RMContentEditVC.h"
#import "RMTruckEditView.h"
#import "RMDataLoader.h"
#import "SCLAlertView.h"

@interface RMContentEditVC ()<UIScrollViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *contentScroll;
@property RMTruckEditView *editView;
@property RMDataLoader *dataLoader;
@property PFFile *truckImageFile;
@property NSString *errorString;
@property UIAlertView *alert;
@property BOOL edited;
@property BOOL cameFromPicker;

#define kOFFSET_FOR_KEYBOARD 80.0

@end

@implementation RMContentEditVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.editView = [RMTruckEditView editForumInterface];
    self.contentScroll.delegate = self;
    [self.editView.saveIndicator setHidden:YES];

    self.cameFromPicker = NO;

    self.contentScroll.contentSize = CGSizeMake(self.view.frame.size.width, self.editView.frame.size.height);
    self.contentScroll.decelerationRate = UIScrollViewDecelerationRateFast;
    [self.contentScroll addSubview:self.editView];

    [self roundViewCorners:self.editView.saveButton];
    [self roundViewCorners:self.editView.cancelButton];
    [self roundViewCorners:self.editView.positionButton];

    [self applySelectors];
    [self fillOutDetails:self.currentTruck];

    self.editView.editScrollView.delegate = self;

    UITapGestureRecognizer *hideKeyboard = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                   action:@selector(hidekeyboards)];
    [self.view addGestureRecognizer:hideKeyboard];


    UITapGestureRecognizer *changeImage = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                  action:@selector(presentImagePicker)];
    [self.editView.imageContainer addGestureRecognizer:changeImage];


    [self.editView.positionButton setHidden:YES];


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
    [picker.navigationBar setTintColor:[UIColor greenColor]];
    self.editView.editScrollView.delegate = self;
    self.editView.editImageView.image = chosenImage;
    self.editView.editScrollView.minimumZoomScale = self.editView.imageContainer.frame.size.width / chosenImage.size.width;
    self.editView.editScrollView.zoomScale =  self.editView.editScrollView.minimumZoomScale;

    [picker dismissViewControllerAnimated:YES completion:NULL];

    [self.editView.positionButton setHidden:NO];
    self.contentScroll.scrollEnabled = NO;
    self.editView.editScrollView.scrollEnabled = YES;
    self.cameFromPicker = YES;

}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{

    self.cameFromPicker = YES;
    [picker dismissViewControllerAnimated:YES completion:NULL];

}


-(UIImage *)cropImageFromImageView:(UIImage *)image withView:(UIImageView *)view inContainer:(UIScrollView *)scrollConatiner{

    float scale = 1.0f/scrollConatiner.zoomScale;

    CGRect cropRect;
    cropRect.origin.x = scrollConatiner.contentOffset.x * scale;
    cropRect.origin.y = scrollConatiner.contentOffset.y * scale;
    cropRect.size.height = scrollConatiner.bounds.size.height * scale;
    cropRect.size.width = scrollConatiner.bounds.size.width * scale;

    CGImageRef imgRef = CGImageCreateWithImageInRect([image CGImage], cropRect);

    UIImage *cropped = [UIImage imageWithCGImage:imgRef];

    return cropped;
}

#pragma mark - ScrollView Delegate

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{

    return self.editView.editImageView;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

    if (scrollView == self.editView.editScrollView) {
        [self.editView.positionButton setTitle:@"Set Picture" forState:UIControlStateNormal];
        self.edited = YES;
    }
}

#pragma mark - Selectors

- (void)applySelectors{

    [self.editView.cancelButton addTarget:self
                                   action:@selector(onCancelPressed)
                         forControlEvents:UIControlEventTouchUpInside];

    [self.editView.saveButton addTarget:self
                                 action:@selector(onSavePressed)
                       forControlEvents:UIControlEventTouchUpInside];
    
    [self.editView.positionButton addTarget:self
                                     action:@selector(editDone)
                           forControlEvents:UIControlEventTouchUpInside];

}
- (void)editDone{

    if (self.edited == YES) {
        
        [self.editView.positionButton setHidden:YES];
        self.editView.editScrollView.scrollEnabled = NO;
        self.contentScroll.scrollEnabled = YES;
    }

}


- (void)presentImagePicker{


    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;

    [self presentViewController:picker animated:YES completion:NULL];


}

- (void)onCancelPressed{

    if (self.cameFromLogin == NO) {

        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        RMContentEditVC *loginVC = [storyboard instantiateViewControllerWithIdentifier:@"LOGIN_MAIN"];

        [self presentViewController:loginVC animated:YES completion:^{
            
        }];
    }
    else if (self.cameFromLogin == YES){

        [self dismissViewControllerAnimated:YES completion:^{

        }];
    }
}

-(void)onSavePressed{

    if ([self.editView.editImageView image] == nil) {

        self.errorString = @"Show us your Truck! We know you worked hard on it.";

        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
        [alert showError:@"Oops! \xF0\x9F\x99\x88"
                subTitle:self.errorString
        closeButtonTitle:@"OK" duration:0.0f];
    }

    else if (self.editView.truckLogin.text.length < 5){

        self.errorString = @"You need an email to log in with.";
        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
        [alert showError:@"Oops! \xF0\x9F\x99\x88"
                subTitle:self.errorString
        closeButtonTitle:@"OK" duration:0.0f];
    }

    else if (self.editView.truckName.text.length < 3){

        self.errorString = @"Please enter your Truck's name.";
        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
        [alert showError:@"Oops! \xF0\x9F\x99\x88"
                subTitle:self.errorString
        closeButtonTitle:@"OK" duration:0.0f];
    }

    else if (self.editView.truckFoodType.text.length < 3){

        self.errorString = @"Tell us what kind of food you serve.";

        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
        [alert showError:@"Oops! \xF0\x9F\x99\x88"
                subTitle:self.errorString
        closeButtonTitle:@"OK" duration:0.0f];
    }

    else if (self.editView.ownerName.text.length <1){

        self.errorString = @"Please enter your name";

        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
        [alert showError:@"Oops! \xF0\x9F\x99\x88"
                subTitle:self.errorString
        closeButtonTitle:@"OK" duration:0.0f];
    }

    else{

        self.dataLoader = [[RMDataLoader alloc] init];
        self.truckImageFile = [[PFFile alloc] init];

        [self.editView.saveButton setHidden:YES];
        [self.editView.cancelButton setHidden:YES];
        [self.editView.saveIndicator startAnimating];
        [self.editView.saveIndicator setHidden:NO];

        if (self.cameFromLogin == NO) {

        [self.dataLoader createNewTruckUser:self.currentTruck.email
                                   password:self.currentTruck.password
                                  truckName:self.editView.truckName.text
                                 typeOfFood:self.editView.truckFoodType.text
                                  ownerName:self.editView.ownerName.text
                                      image:[self cropImageFromImageView:self.editView.editImageView.image
                                                                withView:self.editView.editImageView
                                                             inContainer:self.editView.editScrollView]
         
                                 completion:^(NSError *error) {

            if (!error) {

                SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
                [alert addButton:@"Ok" actionBlock:^{
                    
                    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                    UITabBarController *truckMain = [storyboard instantiateViewControllerWithIdentifier:@"TRUCK_MAIN"];
                    [self presentViewController:truckMain animated:YES completion:^{

                    }];


                }];

                [alert showSuccess:@"Congratulations"
                          subTitle:[NSString stringWithFormat:@"%@ is now registered with Corner Kitchen, add a menu and start checking in!", self.editView.truckName.text]
                  closeButtonTitle:nil
                          duration:0.0f];

            }
            else{

                [self.editView.saveButton setHidden:NO];
                [self.editView.cancelButton setHidden:NO];
                [self.editView.saveIndicator stopAnimating];
                [self.editView.saveIndicator setHidden:YES];
                NSString *errorString = [error userInfo][@"error"];

                SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
                [alert showError:@"Oops! \xF0\x9F\x99\x88"
                        subTitle:errorString
                closeButtonTitle:@"OK" duration:0.0f];
            }

        }];

        }
        else{


            [self.dataLoader updateCurrentTruckProfile:self.currentPFTruck
                                             truckName:self.editView.truckName.text
                                            typeOfFood:self.editView.truckFoodType.text
                                             ownerName:self.editView.ownerName.text
                                                 image:[self cropImageFromImageView:self.editView.editImageView.image

                                                                           withView:self.editView.editImageView

                                                                        inContainer:self.editView.editScrollView]

                                            onComplete:^(NSError *error) {


                                                if (!error) {

                                                    SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
                                                    [alert showSuccess:@"Congratulations"
                                                              subTitle:@"Your profile has been updated!"
                                                      closeButtonTitle:@"OK"
                                                              duration:0.0f];

                                                    [self performSegueWithIdentifier:@"UNWIND_FROM_EDIT" sender:self];

                                                }
                                                else{

                                                    NSString *errorString = [error userInfo][@"error"];
                                                    SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
                                                    [alert showError:@"Oops! \xF0\x9F\x99\x88"
                                                            subTitle:errorString
                                                    closeButtonTitle:@"OK" duration:0.0f];

                                                }

                                             }];
            
        }

    }

}



#pragma mark - content Population

- (void)fillOutDetails:(RMTruck *)visible{

    self.editView.truckLogin.text = visible.email;


}

- (void)presentCurrentTruck{

    self.editView.truckName.text = self.currentPFTruck[@"name"];
    self.editView.truckFoodType.text = self.currentPFTruck[@"foodType"];
    self.editView.editImageView.image = self.truckImage;
    self.editView.ownerName.text = self.currentPFTruck[@"ownerName"];
    self.editView.truckLogin.text = [PFUser currentUser].username;

    self.editView.editScrollView.minimumZoomScale = self.editView.imageContainer.frame.size.width / self.truckImage.size.width;
    self.editView.editScrollView.zoomScale =  self.editView.editScrollView.minimumZoomScale;

}



#pragma mark - KeyBoard Delegate

- (void)hidekeyboards{

    [self.editView.truckName resignFirstResponder];
    [self.editView.truckFoodType resignFirstResponder];
    [self.editView.ownerName resignFirstResponder];
    [self.editView.truckLogin resignFirstResponder];
    
}

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

#pragma mark - NavigationBarDelegate


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

- (void)viewDidAppear:(BOOL)animated{

    if (self.cameFromLogin == YES && self.cameFromPicker == NO) {
        [self presentCurrentTruck];
    }
    else if (self.cameFromLogin == NO && self.cameFromPicker == NO){
        [self fillOutDetails:self.currentTruck];
    }
}








@end
