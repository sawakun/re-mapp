//
//  RMPBuzzMapCell.h
//  ReMapp1
//
//  Created by nishiba on 2013/08/17.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "RMPPlaceMapCell.h"
@class RMPHeightToFitLabel;
@class RMPJudgeButton;

@interface RMPBuzzMapCell : RMPPlaceMapCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet RMPHeightToFitLabel *bodyLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bodyImageView;
@property (weak, nonatomic) IBOutlet RMPViewInPlaceMapCell *actionButtonView;
@property (weak, nonatomic) IBOutlet RMPScrollViewInPlaceMapCell *innerScrollView;
@property (weak, nonatomic) IBOutlet RMPJudgeButton *likeButton;
@property (weak, nonatomic) IBOutlet RMPJudgeButton *muteButton;
@property (weak, nonatomic) IBOutlet UILabel *likeNumber;
@property (weak, nonatomic) IBOutlet UILabel *muteNumber;
- (IBAction)likeButtonDidTapped:(id)sender;
- (IBAction)muteButtonDidTapped:(id)sender;

@end
