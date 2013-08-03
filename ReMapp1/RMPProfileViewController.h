//
//  RMPProfileViewController.h
//  ReMapp1
//
//  Created by nishiba on 2013/07/28.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RMPProfileViewController : UIViewController <UIScrollViewDelegate,UITextFieldDelegate, UITextViewDelegate, UIActionSheetDelegate>
- (IBAction)tappedToReturnToMenu:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextView *profileTextView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
- (IBAction)tappedToSave:(id)sender;

@end
