//
//  RMPTimeLineViewController.h
//  ReMapp1
//
//  Created by nishiba on 2013/08/08.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RMPTimeLineCollectionView, RMPPlaceData;

@interface RMPTimeLineViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>
{
@protected
    RMPPlaceData *_placeData;
}

@property (weak, nonatomic) IBOutlet UICollectionView *timeLineCollectionView;
- (void)reload;
@end
