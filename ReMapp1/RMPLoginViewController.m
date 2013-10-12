//
//  RMPLoginViewController.m
//  ReMapp1
//
//  Created by nishiba on 2013/09/25.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "RMPLoginViewController.h"
#import "RMPKeyboardMoveScrollView.h"
#import "RMPHTTPConnection.h"
#import "RMPActivityIndicatorView.h"

@interface RMPLoginViewController () <UITextFieldDelegate>
{
@private
    RMPActivityIndicatorView *_activityIndicatorView;
}

@end

@implementation RMPLoginViewController

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
    self.emailTextField.delegate = self;
    self.passwordTextField.delegate = self;

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




- (IBAction)tappedLogin:(id)sender {
    [_activityIndicatorView
     doTask:^bool(void){
         return [RMPHTTPConnection loginWithEmail:self.emailTextField.text Password:self.passwordTextField.text];
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
        [self tappedLogin:nil];
        [textField resignFirstResponder];
    }
    return YES;
}

@end
