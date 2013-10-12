//
//  RMPProfileViewController.m
//  ReMapp1
//
//  Created by nishiba on 2013/07/28.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "RMPProfileViewController.h"
#import "RMPUser.h"
#import "RMPHTTPConnection.h"

@interface RMPProfileViewController ()
@end

@implementation RMPProfileViewController

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
    RMPUser *user = [RMPUser sharedManager];
	// Do any additional setup after loading the view.
    self.iconImageView.image = user.iconImage;
    self.nameTextField.text = user.name;
    self.emailTextField.text = user.email;
    self.profileTextView.text = user.profile;
    self.nameTextField.delegate = self;
    self.emailTextField.delegate = self;
    self.profileTextView.delegate = self;
    
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyboard)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    
    
    
    //set tap gesture
    self.iconImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapped = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedIconImageView:)];
    tapped.numberOfTapsRequired = 1;
    [self.iconImageView addGestureRecognizer:tapped];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tappedToReturnToMenu:(id)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"])
        [textView resignFirstResponder];
    return YES;
}

- (IBAction)tappedToSave:(id)sender {
    [RMPHTTPConnection sendModifiedUserName:self.nameTextField.text
                                      Email:self.emailTextField.text
                                    Profile:self.profileTextView.text];
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void)tappedIconImageView:(id)sender{
    /*
     if (self.iconImageView.image == nil) {
     return;
     }
     */
    UIActionSheet *sheet =[[UIActionSheet alloc]
                           initWithTitle:@"Action Sheet"
                           delegate:self
                           cancelButtonTitle:@"Cancel"
                           destructiveButtonTitle:@"Delete photo"
                           otherButtonTitles:nil, nil];
    
    [sheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
    
    [sheet showInView:self.view];
}

- (void) closeKeyboard {
    [self.view endEditing:YES];
}

@end
