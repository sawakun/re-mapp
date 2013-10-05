//
//  RMPFixedPlaceMapCell.h
//  ReMapp1
//
//  Created by nishiba on 2013/10/04.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "RMPPlaceMapCell.h"
#import "RMPJudgeButton.h"


@interface RMPFixedPlaceMapCell : RMPPlaceMapCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *bodyLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bodyImageView;
@property (weak, nonatomic) IBOutlet RMPViewInPlaceMapCell *actionButtonView;
@property (weak, nonatomic) IBOutlet RMPScrollViewInPlaceMapCell *innerScrollView;
@property (weak, nonatomic) IBOutlet RMPJudgeButton *likeButton;
@property (weak, nonatomic) IBOutlet RMPJudgeButton *muteButton;
@property (weak, nonatomic) IBOutlet UILabel *likeNumber;
@property (weak, nonatomic) IBOutlet UILabel *muteNumber;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *siteURLLabel;
- (IBAction)likeButtonDidTapped:(id)sender;
- (IBAction)muteButtonDidTapped:(id)sender;

@end
