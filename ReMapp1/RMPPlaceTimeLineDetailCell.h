//
//  RMPPlaceTimeLineDetailCell.h
//  ReMapp1
//
//  Created by nishiba on 2013/08/10.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RMPPlace;

@interface RMPPlaceTimeLineDetailCell : UICollectionViewCell
- (void)setDataWithPlace:(RMPPlace *)place;
+ (CGFloat)heightForPlace:(RMPPlace *)place;
@end


@interface RMPPlaceTimeLineDetailCellFactory : NSObject
+ (RMPPlaceTimeLineDetailCell *)createCellWithCollectionView:(UICollectionView *)collectionView
                                      cellForItemAtIndexPath:(NSIndexPath *)indexPath
                                                       place:(RMPPlace *)place;
@end
