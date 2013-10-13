//
//  BuzzFormViewController.m
//  ReMapp1
//
//  Created by nishiba on 2013/07/02.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "BuzzFormViewController.h"

@interface BuzzFormViewController ()

@end

@implementation BuzzFormViewController

- (BOOL)shouldAutorotate
{
    return NO;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    _textView.returnKeyType = UIReturnKeyDone;
    _textView.delegate = self;
    _textView.placeholder = @"What's happening?";
    
    //set user info
    RMPUser *user = [RMPUser sharedManager];
    
    self.textCountLabel.text = @"0";
    
    //set tap gesture
    self.imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapped = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedImageView:)];
    tapped.numberOfTapsRequired = 1;
    [self.imageView addGestureRecognizer:tapped];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_textView becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)keyboardWillShow:(NSNotification *)notification {
    NSDictionary *info = [notification userInfo];
    CGRect keyboardFrame = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    _toolbarVerticalSpaceConstraint.constant = - keyboardFrame.size.height;
}

- (void)keyboardWillHide:(NSNotification *)notification {
    _toolbarVerticalSpaceConstraint.constant = 0;
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    int maxInputLength = 200;
    NSMutableString *str = [textView.text mutableCopy];
    [str replaceCharactersInRange:range withString:text];
    
    //set the length of test
    self.textCountLabel.text = [@([str length]) stringValue];
    
    if ([str length] > maxInputLength) {
        return NO;
    }
    
    //when return key is tapped, werite buzz and return to the previous view
    if ([text isEqualToString:@"\n"]) {
        [self registBuzz];
        [self dismissViewControllerAnimated:YES completion:NULL];
        return NO;
    }
    return YES;
}

- (BOOL)registBuzz
{
    RMPUser *user = [RMPUser sharedManager];
    [RMPHTTPConnection sendNewBuzzWithUserSystemId:user.systemId
                                          BuzzText:self.textView.text
                                          Location:self.location
                                             Image:self.imageView.image];
    return TRUE;
}

- (IBAction)tappedCancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)tappedPhotos:(id)sender {
    [self useCameraRoll];
}


- (void) useCameraRoll
{
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypeSavedPhotosAlbum])
    {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.mediaTypes = [NSArray arrayWithObjects:(NSString *) kUTTypeImage, nil];
        imagePicker.allowsEditing = NO;
        [self presentViewController:imagePicker animated:YES completion:nil];
        //        newMedia = NO;
    }
}

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage * pickedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    _imageView.image = pickedImage;
    //[self.navigationController pushViewController:controller animated:YES];
}


-(void)tappedImageView:(id)sender{
    if (self.imageView.image == nil) {
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

#pragma mark - Related to run Camera
- (void)runCamera
{
    BOOL cameraIsAvailable = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
    if (!cameraIsAvailable) {
        return;
    }
    
    UIImagePickerController *imagePickerController =[[UIImagePickerController alloc] init];
    
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (IBAction)tappedCameraidsender:(id)sender {
    [self runCamera];
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == [actionSheet cancelButtonIndex]) {
    }else if (buttonIndex == [actionSheet destructiveButtonIndex]) {
        self.imageView.image = nil;
    }else{
        //[selectLabel setText:[actionSheet buttonTitleAtIndex:buttonIndex]];
    }
}
@end
