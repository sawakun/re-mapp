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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    _textView.returnKeyType = UIReturnKeyDone;
    _textView.delegate = self;
    _textView.placeholder = @"What's happening?";
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
@end
