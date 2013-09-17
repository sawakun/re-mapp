//
//  RMPTimeLineViewController.h
//  ReMapp1
//
//  Created by nishiba on 2013/08/08.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RMPTimeLineViewController.h"

@class RMPTimeLineCollectionView;
@interface RMPMapTimeLineViewController : RMPTimeLineViewController
@property (weak, nonatomic) IBOutlet UICollectionView *timeLineCollectionView;
@property (weak, nonatomic) IBOutlet UIButton *timeButton;
@property (weak, nonatomic) IBOutlet UIButton *buzzButton;
@property (weak, nonatomic) IBOutlet UIButton *eatButton;
@property (weak, nonatomic) IBOutlet UIButton *shopButton;
@property (weak, nonatomic) IBOutlet UIButton *playButton;

@end
