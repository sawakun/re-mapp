//
//  RMPBuzzView.m
//  ReMapp1
//
//  Created by nishiba on 2013/09/15.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "RMPBuzzView.h"
#import "RMPBuzzPlace.h"
#import "UIImageView+WebCache.h"
#import "RMPJudgeButton.h"
#import "RMPHTTPConnection.h"

@interface RMPBuzzView()
@property (nonatomic) NSInteger buzzId;
@end


@implementation RMPBuzzView

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
    
    if (![place isKindOfClass:[RMPBuzzPlace class]]) {
        return;
    }
    
    RMPBuzzPlace *buzz = (RMPBuzzPlace *)place;
    self.buzzBodyLabel.text = buzz.buzzBody;
    
    self.buzzId = buzz.buzzId;
    self.likeButton.isJudged = buzz.like;
    self.muteButton.isJudged = buzz.mute;
    self.likeNumber.text = [@(buzz.likes) stringValue];
    self.muteNumber.text = [@(buzz.mutes) stringValue];

    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY/MM/dd hh:mm:ss"];
    self.timeLabel.text = [formatter stringFromDate:buzz.time];
    
    if (![buzz.buzzImgUrl isEqual:@""]) {
        [self.buzzImageView setImageWithURL:[NSURL URLWithString:buzz.buzzImgUrl]
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
