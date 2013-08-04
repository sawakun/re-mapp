//
//  RMPPlaceCollectionView.h
//  ReMapp1
//
//  Created by nishiba on 2013/08/04.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import <UIKit/UIKit.h>

/** Notification that gets posted when Cell moved. */
extern NSString *const RMPPlaceCollectionViewCellDidMove;

@interface RMPPlaceCollectionView : UICollectionView <UICollectionViewDataSource, UICollectionViewDelegate>

@end
