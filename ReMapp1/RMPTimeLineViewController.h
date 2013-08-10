//
//  RMPTimeLineViewController.h
//  ReMapp1
//
//  Created by nishiba on 2013/08/08.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RMPTimeLineCollectionView;
@interface RMPTimeLineViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *timeLineCollectionView;

@end
