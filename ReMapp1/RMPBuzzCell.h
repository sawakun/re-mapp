//
//  RMPBuzzTimeLineCollectionViewCell.h
//  ReMapp1
//
//  Created by nishiba on 2013/08/08.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "RMPPlaceCell.h"


@class RMPBuzzPlace;
@class RMPHeightToFitLabel;

@interface RMPBuzzCell : RMPPlaceCell
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet RMPHeightToFitLabel *buzzBodyLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end
