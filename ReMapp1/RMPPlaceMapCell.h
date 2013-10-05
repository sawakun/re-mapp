//
//  RMPPlaceMapCell.h
//  ReMapp1
//
//  Created by nishiba on 2013/08/17.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


@class RMPPlace;
@class RMPRearrangedView;

@interface RMPScrollViewInPlaceMapCell : UIScrollView
-(void)setPosition:(CGPoint)position;
@end

@interface RMPViewInPlaceMapCell : UIView
-(void)setPosition:(CGPoint)position;
@end


@interface RMPPlaceMapCell : UICollectionViewCell <UIGestureRecognizerDelegate>
@property (weak, nonatomic) RMPScrollViewInPlaceMapCell *innerScrollView;
@property (weak, nonatomic) RMPViewInPlaceMapCell *actionButtonView;
- (void)setDataWithPlace:(RMPPlace *)place;
@end


@interface RMPPlaceMapCellFactory : NSObject
+ (RMPPlaceMapCell *)createCellWithCollectionView:(UICollectionView *)collectionView
                              cellForItemAtIndexPath:(NSIndexPath *)indexPath
                                               place:(RMPPlace *)place;
@end