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
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet RMPHeightToFitLabel *bodyLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end
