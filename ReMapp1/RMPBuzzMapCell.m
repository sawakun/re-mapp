//
//  RMPBuzzMapCell.m
//  ReMapp1
//
//  Created by nishiba on 2013/08/17.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "RMPBuzzMapCell.h"
#import "RMPPlaceAll.h"
#import "RMPHeightToFitLabel.h"
#import "UIImageView+WebCache.h"
#import "RMPJudgeButton.h"
#import "RMPHTTPConnection.h"
#import "RMPViewInPlaceMapCell.h"
#import "RMPScrollViewInPlaceMapCell.h"

@interface RMPBuzzMapCell()
@property (nonatomic) NSInteger buzzId;
@end

@implementation RMPBuzzMapCell

- (void)setDataWithPlace:(RMPPlace *)place
{
    [super setDataWithPlace:place];
    if (![place isKindOfClass:[RMPBuzzPlace class]]) {
    //    return;
    }
    
    RMPBuzzPlace *buzz = (RMPBuzzPlace *)place;
    self.buzzId = buzz.buzzId;
    [self setBackgroundColor:buzz.backgroundColor];
    self.nameLabel.text = buzz.userName;
    self.bodyLabel.text = buzz.buzzBody;

    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY/MM/dd hh:mm:ss"];
    self.dateLabel.text = [formatter stringFromDate:buzz.time];

    self.bodyLabel.width = 245;
    [self.innerScrollView setContentOffset:CGPointMake(0, 0)];
    
    self.likeNumber.text = [@(buzz.likes) stringValue];
    self.muteNumber.text = [@(buzz.mutes) stringValue];
    self.likeButton.isJudged = buzz.like;
    self.muteButton.isJudged = buzz.mute;
    
    [self.iconImageView setImageWithURL:[NSURL URLWithString:buzz.userImgURL]
                       placeholderImage:[UIImage imageNamed:@"NO_IMAGE.png"]];
    
    self.bodyImageView.image = nil;
    if (![buzz.buzzImgUrl isEqual:@""]) {
        [self.bodyImageView setImageWithURL:[NSURL URLWithString:buzz.buzzImgUrl]
                           placeholderImage:[UIImage imageNamed:@"NO_IMAGE.png"]];
    }
}

- (IBAction)likeButtonDidTapped:(id)sender {
    [self.likeButton changeJudgement];
    [RMPHTTPConnection judgeBuzz:self.buzzId State:self.likeButton.isJudged Kind:LIKE];
}

- (IBAction)muteButtonDidTapped:(id)sender {
    [self.muteButton changeJudgement];
    [RMPHTTPConnection judgeBuzz:self.buzzId State:self.likeButton.isJudged Kind:MUTE];
}
@end
