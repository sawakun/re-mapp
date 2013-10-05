//
//  RMPBuzzView.h
//  ReMapp1
//
//  Created by nishiba on 2013/09/15.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "RMPPlaceView.h"
@class RMPJudgeButton;

@interface RMPBuzzView : RMPPlaceView
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *buzzImageView;
@property (weak, nonatomic) IBOutlet UILabel *buzzBodyLabel;
@property (weak, nonatomic) IBOutlet RMPJudgeButton *likeButton;
@property (weak, nonatomic) IBOutlet RMPJudgeButton *muteButton;
@property (weak, nonatomic) IBOutlet UILabel *likeNumber;
@property (weak, nonatomic) IBOutlet UILabel *muteNumber;
- (IBAction)likeButtonDidTapped:(id)sender;
- (IBAction)muteButtonDidTapped:(id)sender;

@end
