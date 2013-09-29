//
//  RMPLoginViewController.h
//  ReMapp1
//
//  Created by nishiba on 2013/09/25.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RMPKeyboardMoveScrollView;

@interface RMPLoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet RMPKeyboardMoveScrollView *scrollView;
- (IBAction)tappedLogin:(id)sender;

@end
