//
//  RMPPlaceTimeLineCollectionViewCell.h
//  ReMapp1
//
//  Created by nishiba on 2013/08/08.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RMPPlace;

@interface RMPPlaceTimeLineCell : UICollectionViewCell
+ (CGFloat)heightForPlace:(RMPPlace *)place;
- (void)setDataWithPlace:(RMPPlace *)place;
@end

@interface RMPPlaceTimeLineCellFactory : NSObject
+ (RMPPlaceTimeLineCell *)createCellWithCollectionView:(UICollectionView *)collectionView
                                              cellForItemAtIndexPath:(NSIndexPath *)indexPath
                                                               place:(RMPPlace *)place;
@end