//
//  InfoViewController.h
//  ReMapp1
//
//  Created by nishiba on 2013/06/30.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BuzzData;
@interface InfoViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UIView *infoView;
@property (weak, nonatomic) IBOutlet UITableView *infoTableView;
@property (weak, nonatomic) BuzzData *buzzData;
- (void)showNthCell:(NSInteger)index;
- (IBAction)swipeUp:(id)sender;
- (IBAction)swipeDown:(id)sender;

@end
