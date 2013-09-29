//
//  RMPMenuViewController.h
//  ReMapp1
//
//  Created by nishiba on 2013/07/28.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RMPMenuViewController : UIViewController <UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *innerView;
- (IBAction)tappedLogout:(id)sender;

@end
