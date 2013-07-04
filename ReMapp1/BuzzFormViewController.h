//
//  BuzzFormViewController.h
//  ReMapp1
//
//  Created by nishiba on 2013/07/02.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "UIPlaceHolderTextView.h"

@interface BuzzFormViewController : UIViewController <UINavigationControllerDelegate, UITextViewDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIPlaceHolderTextView *textView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toolbarVerticalSpaceConstraint;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (assign, nonatomic) CLLocationCoordinate2D location;
- (IBAction)tappedCancel:(id)sender;
- (IBAction)tappedPhotos:(id)sender;

@end
