//
//  RMPPlaceCollectionViewCell.h
//  ReMapp1
//
//  Created by nishiba on 2013/08/05.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RMPPlace;

@interface RMPPlaceCollectionViewCell : UICollectionViewCell

@end



@interface RMPPlaceCollectionViewCellFactory : NSObject
+ (RMPPlaceCollectionViewCell *)createCellWithCollectionView:(UICollectionView *)collectionView
                                      cellForItemAtIndexPath:(NSIndexPath *)indexPath
                                                       place:(RMPPlace *)place;
@end