//
//  RMPBuzzView.m
//  ReMapp1
//
//  Created by nishiba on 2013/09/15.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "RMPFixedPlaceView.h"
#import "RMPFixedPlace.h"
#import "UIImageView+WebCache.h"
#import "UILabel+VerticalAlign.h"
#import "RMPJudgeButton.h"
#import "RMPHTTPConnection.h"

@interface RMPFixedPlaceView()
@property (nonatomic) NSInteger buzzId;
@end

@implementation RMPFixedPlaceView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setPlace:(RMPPlace*)place
{
    if (![place isKindOfClass:[RMPFixedPlace class]]) {
        return;
    }
    
    RMPFixedPlace *fixedPlace = (RMPFixedPlace *)place;
    self.buzzBodyLabel.text = fixedPlace.buzzBody;
    self.userNameLabel.text = fixedPlace.userName;
    self.addressLabel.text = fixedPlace.address;
    self.phoneNumberLabel.text = fixedPlace.phoneNumber;
    self.siteURLLabel.text = fixedPlace.siteURL;
    self.buzzId = fixedPlace.buzzId;
    self.likeButton.isJudged = fixedPlace.like;
    self.muteButton.isJudged = fixedPlace.mute;
    self.likeNumber.text = [@(fixedPlace.likes) stringValue];
    self.muteNumber.text = [@(fixedPlace.mutes) stringValue];
    
    if (![fixedPlace.buzzImgUrl isEqual:@""]) {
        [self.buzzImageView setImageWithURL:[NSURL URLWithString:fixedPlace.buzzImgUrl]
                           placeholderImage:[UIImage imageNamed:@"NO_IMAGE.png"]];
    }
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    // set initial values
    [self.buzzBodyLabel alignTop];
    [self.userNameLabel alignTop];
    [self.addressLabel alignTop];
    [self.phoneNumberLabel alignTop];
    [self.siteURLLabel alignTop];
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
