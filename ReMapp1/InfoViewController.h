//
//  InfoViewController.h
//  ReMapp1
//
//  Created by nishiba on 2013/06/30.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import <UIKit/UIKit.h>

/** Notification that gets posted when the Info Cell moved. */
extern NSString *const InfoCellDidMove;


@class RMPBuzzData;
@interface InfoViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UIView *infoView;
@property (weak, nonatomic) IBOutlet UITableView *infoTableView;
@property (weak, nonatomic) RMPBuzzData *buzzData;
- (void)showNthCell:(NSNotification *)center;

@end
