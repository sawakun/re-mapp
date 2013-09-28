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

@interface RMPLoginViewController () <UITextFieldDelegate>

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)tappedLogin:(id)sender {
    BOOL result = [RMPHTTPConnection loginWithEmail:self.emailTextField.text Password:self.passwordTextField.text];

    // move to map
    if (result) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
        UIViewController *mainView  = [storyboard instantiateViewControllerWithIdentifier:@"RMPInitialSlidingViewController"];
        mainView.view.frame = self.view.frame;
        [self presentViewController:mainView animated:YES completion:nil];
    }
}
@end
