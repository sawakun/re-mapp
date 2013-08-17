//
//  RMPCheckListViewController.h
//  ReMapp1
//
//  Created by nishiba on 2013/07/28.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RMPTimeLineViewController.h"

@interface RMPCheckListViewController : RMPTimeLineViewController
- (IBAction)tappedToReturnToMenu:(id)sender;
@property (weak, nonatomic) IBOutlet UICollectionView *timeLineCollectionView;
@end
