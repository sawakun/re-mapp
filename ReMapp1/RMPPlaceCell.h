//
//  RMPPlaceTimeLineCollectionViewCell.h
//  ReMapp1
//
//  Created by nishiba on 2013/08/08.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RMPHeightToFitLabel.h"
@class RMPPlace;


@interface RMPPlaceCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet RMPHeightToFitLabel *buzzBodyLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

+ (CGFloat)heightForPlace:(RMPPlace *)place;
- (void)setDataWithPlace:(RMPPlace *)place;
@end

@interface RMPPlaceCellFactory : NSObject
+ (RMPPlaceCell *)createCellWithCollectionView:(UICollectionView *)collectionView
                                              cellForItemAtIndexPath:(NSIndexPath *)indexPath
                                                               place:(RMPPlace *)place;
@end