//
//  RMPBuzzMapCell.h
//  ReMapp1
//
//  Created by nishiba on 2013/08/17.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "RMPPlaceMapCell.h"
@class RMPHeightToFitLabel;
@class RMPRearrangedView;

@interface RMPBuzzMapCell : RMPPlaceMapCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet RMPHeightToFitLabel *bodyLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bodyImageView;
@property (weak, nonatomic) IBOutlet RMPRearrangedView *actionButtonView;
@property (weak, nonatomic) IBOutlet UIScrollView *innerScrollView;

@end
