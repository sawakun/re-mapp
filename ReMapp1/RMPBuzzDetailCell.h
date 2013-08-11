//
//  RMPBuzzTimeLineDetailCell.h
//  ReMapp1
//
//  Created by nishiba on 2013/08/10.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RMPPlaceDetailCell.h"
@class RMPHeightToFitLabel;
@class RMPRearrangedView;

<<<<<<< HEAD:ReMapp1/RMPBuzzTimeLineDetailCell.h
@interface RMPBuzzTimeLineDetailCell : RMPPlaceTimeLineDetailCell
=======
@interface RMPBuzzDetailCell : RMPPlaceDetailCell
>>>>>>> origin/new/TimeLine:ReMapp1/RMPBuzzDetailCell.h
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet RMPHeightToFitLabel *bodyLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bodyImageView;
@property (weak, nonatomic) IBOutlet RMPRearrangedView *likeAndMuteButtonView;
@end
