//
//  RMPPlaceTimeLineCollectionViewCell.h
//  ReMapp1
//
//  Created by nishiba on 2013/08/08.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RMPPlace;

@interface RMPPlaceCell : UICollectionViewCell
+ (CGFloat)heightForPlace:(RMPPlace *)place;
- (void)setDataWithPlace:(RMPPlace *)place;
@end

@interface RMPPlaceCellFactory : NSObject
+ (RMPPlaceCell *)createCellWithCollectionView:(UICollectionView *)collectionView
                                              cellForItemAtIndexPath:(NSIndexPath *)indexPath
                                                               place:(RMPPlace *)place;
@end