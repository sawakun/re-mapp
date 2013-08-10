//
//  RMPTimeLineDetailViewController.h
//  ReMapp1
//
//  Created by nishiba on 2013/08/09.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RMPPlace;

@interface RMPTimeLineDetailViewController : UIViewController  <UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic) RMPPlace *place;
@property (weak, nonatomic) IBOutlet UICollectionView *timeLineDetailCollectionView;
- (IBAction)tappedToHide:(id)sender;

@end
