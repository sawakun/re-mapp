//
//  RMPDetailViewController.h
//  ReMapp1
//
//  Created by nishiba on 2013/09/15.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RMPPlace;

@interface RMPDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic) RMPPlace *place;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

- (void)setPlace:(RMPPlace *)place;
- (IBAction)tappedToHide:(id)sender;
@end
