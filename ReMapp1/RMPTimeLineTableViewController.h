//
//  RMPTimeLineViewController.h
//  ReMapp1
//
//  Created by nishiba on 2013/07/20.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RMPTimeLineViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *timeLineTableView;
- (IBAction)tappedToReturnToMap:(id)sender;

@end
