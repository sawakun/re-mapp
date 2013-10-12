//
//  RMPRegisterViewController.m
//  ReMapp1
//
//  Created by nishiba on 2013/09/28.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "RMPRegisterViewController.h"
#import "RMPTrimImageViewController.h"
#import "RMPActivityIndicatorView.h"
#import "RMPHTTPConnection.h"


@interface RMPRegisterViewController () <UITextFieldDelegate>
{
    @private
    RMPActivityIndicatorView *_activityIndicatorView;
}
@property RMPTrimImageViewController *trimImageViewController;
@end

@implementation RMPRegisterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.userNameTextField.delegate = self;
    self.emailTextField.delegate = self;
    self.passwordTextField.delegate = self;
    //set tap gesture
    self.userImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapped = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedUserImageView)];
    tapped.numberOfTapsRequired = 1;
    [self.userImageView addGestureRecognizer:tapped];
    
    // set RMPTrimImageViewController
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
    self.trimImageViewController = [storyboard instantiateViewControllerWithIdentifier:@"RMPTrimImageViewController"];
    self.trimImageViewController.view.frame = self.view.frame;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(trimmingDidFinish) name:@"RMPTrimImageViewControllerWillDisappear" object:nil];

    
    //set activity indicator view
    _activityIndicatorView = [RMPActivityIndicatorView createWithOwner:self];
    [self.view addSubview:_activityIndicatorView];
    [_activityIndicatorView moveCenterInView:self.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tappedUserImageView
{
    
    [self pickImageInCameraRoll];
    if (self.pickedImage) {
        self.userImageView.image = self.pickedImage;
    }
}

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker pushViewController:self.trimImageViewController animated:YES];
    self.trimImageViewController.imageView.image = [info objectForKey:UIImagePickerControllerOriginalImage];
}

- (void)trimmingDidFinish {
    self.userImageView.image = self.trimImageViewController.trimmedImage;
}

- (IBAction)tappedRegister:(id)sender {    
    [_activityIndicatorView
     doTask:^bool(void){
         return[RMPHTTPConnection registerWithUserName:self.userNameTextField.text
                                                 Email:self.emailTextField.text
                                              Password:self.passwordTextField.text
                                             UserImage:self.userImageView.image];
    }
     competion:^void(bool result){
         if (result) {
             UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
             UIViewController *mainView  = [storyboard instantiateViewControllerWithIdentifier:@"RMPInitialSlidingViewController"];
             mainView.view.frame = self.view.frame;
             [self presentViewController:mainView animated:YES completion:nil];
         }
     }];
 }


#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSInteger nextTag = textField.tag + 1;
    // Try to find next responder
    UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
    if (nextResponder) {
        // Found next responder, so set it.
        [nextResponder becomeFirstResponder];
    } else {
        // Not found, so remove keyboard.
        [self tappedRegister:nil];
        [textField resignFirstResponder];
    }
    return YES;
}

@end
