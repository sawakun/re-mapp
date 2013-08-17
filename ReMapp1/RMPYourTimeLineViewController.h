//
//  RMPYourTimeLineViewController.h
//  ReMapp1
//
//  Created by nishiba on 2013/08/15.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RMPTimeLineViewController.h"

@interface RMPYourTimeLineViewController : RMPTimeLineViewController
@property (weak, nonatomic) IBOutlet UICollectionView *timeLineCollectionView;
- (IBAction)tappedToReturnToMenu:(id)sender;
@end
