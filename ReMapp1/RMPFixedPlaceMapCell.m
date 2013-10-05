//
//  RMPFixedPlaceMapCell.m
//  ReMapp1
//
//  Created by nishiba on 2013/10/04.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "RMPFixedPlaceMapCell.h"
#import "RMPPlaceAll.h"
#import "UIImageView+WebCache.h"
#import "RMPJudgeButton.h"
#import "RMPHTTPConnection.h"

@interface RMPFixedPlaceMapCell()
@property (nonatomic) NSInteger buzzId;
@end

@implementation RMPFixedPlaceMapCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setDataWithPlace:(RMPPlace *)place
{
    [super setDataWithPlace:place];
    if (![place isKindOfClass:[RMPFixedPlace class]]) {
        return;
    }
    
    RMPFixedPlace *buzz = (RMPFixedPlace *)place;
    self.buzzId = buzz.buzzId;
    [self setBackgroundColor:buzz.backgroundColor];
    self.nameLabel.text = buzz.userName;
    self.bodyLabel.text = buzz.buzzBody;
        
    [self.innerScrollView setContentOffset:CGPointMake(0, 0)];
    
    self.likeNumber.text = [@(buzz.likes) stringValue];
    self.muteNumber.text = [@(buzz.mutes) stringValue];
    self.likeButton.isJudged = buzz.like;
    self.muteButton.isJudged = buzz.mute;
    self.addressLabel.text = buzz.address;
    self.phoneNumberLabel.text = buzz.phoneNumber;
    self.siteURLLabel.text = buzz.siteURL;
    
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
