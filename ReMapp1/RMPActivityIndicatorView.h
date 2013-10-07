//
//  RMPActivityIndicatorView.h
//  ReMapp1
//
//  Created by nishiba on 2013/10/06.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RMPActivityIndicatorView : UIView
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;
+ (id)createWithOwner:(id)owner;
- (void)startAnimating;
- (void)stopAnimating;
- (void)moveCenterInView:(UIView*)view;
@end
