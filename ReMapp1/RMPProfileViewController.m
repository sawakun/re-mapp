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
@property (nonatomic) UITextField *activeTextField;
@property (nonatomic) UITextView *activeTextView;
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
    
    //set delegate
    self.nameTextField.delegate = self;
    self.emailTextField.delegate = self;
    self.profileTextView.delegate = self;
    self.nameTextField.returnKeyType = UIReturnKeyDone;
    self.emailTextField.returnKeyType = UIReturnKeyDone;
    self.profileTextView.returnKeyType = UIReturnKeyDone;
    


    // Set notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillChangeFrameNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
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

- (void)keyboardWillShow:(NSNotification *)notification {
    NSDictionary *info = [notification userInfo];
    CGRect keyboardFrame = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat heightInputForm = 0.0;
    if (self.activeTextField != nil) {
        heightInputForm = self.activeTextField.frame.origin.y + self.activeTextField.frame.size.height;
    }
    else if (self.activeTextView != nil) {
        heightInputForm = self.activeTextView.frame.origin.y + self.activeTextView.frame.size.height;
    }
    
    CGFloat heightKeyboard = self.scrollView.bounds.size.height - keyboardFrame.size.height - 30;
    
    if (heightInputForm > heightKeyboard)
    {
        CGPoint scrollPoint = CGPointMake(0.0, heightInputForm - heightKeyboard);
        [self.scrollView setContentOffset:scrollPoint animated:YES];
    }
}

- (void)keyboardWillHide:(NSNotification *)notification {
    CGPoint scrollPoint = CGPointMake(0.0, 0.0);
    [self.scrollView setContentOffset:scrollPoint animated:YES];
}

- (void) closeKeyboard {
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    self.activeTextField = textField;
    self.activeTextView = nil;
    return YES;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    self.activeTextView = textView;
    self.activeTextField = nil;
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.activeTextField resignFirstResponder];
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [self.activeTextView resignFirstResponder];
        return NO;
    }
    return YES;
}
- (IBAction)tappedToSave:(id)sender {
    [RMPHTTPConnection sendModifiedUserName:self.nameTextField.text
                                      Email:self.emailTextField.text
                                    Profile:self.profileTextView.text];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void)tappedIconImageView:(id)sender{
    if (self.iconImageView.image == nil) {
        return;
    }
    
    UIActionSheet *sheet =[[UIActionSheet alloc]
                           initWithTitle:@"Action Sheet"
                           delegate:self
                           cancelButtonTitle:@"Cancel"
                           destructiveButtonTitle:@"Delete photo"
                           otherButtonTitles:nil, nil];
    
    [sheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
    
    [sheet showInView:self.view];
}


@end
