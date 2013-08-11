//
//  RMPBuzzTimeLineDetailCell.h
//  ReMapp1
//
//  Created by nishiba on 2013/08/10.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RMPPlaceTimeLineDetailCell.h"
@class RMPHeightToFitLabel;
@class RMPRearrangedView;

@interface RMPBuzzTimeLineDetailCell : RMPPlaceTimeLineDetailCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet RMPHeightToFitLabel *bodyLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bodyImageView;
@property (weak, nonatomic) IBOutlet RMPRearrangedView *likeAndMuteButtonView;
@end
