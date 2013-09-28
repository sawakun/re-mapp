//
//  RMPRegisterViewController.h
//  ReMapp1
//
//  Created by nishiba on 2013/09/28.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RMPPickImageViewController.h"

@interface RMPRegisterViewController : RMPPickImageViewController
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
- (IBAction)tappedRegister:(id)sender;

@end
