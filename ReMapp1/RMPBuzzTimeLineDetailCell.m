//
//  RMPBuzzTimeLineDetailCell.m
//  ReMapp1
//
//  Created by nishiba on 2013/08/10.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "RMPBuzzTimeLineDetailCell.h"
#import "RMPPlace.h"
#import "RMPHeightToFitLabel.h"
#import "UIImageView+WebCache.h"
#import "RMPRearrangedView.h"

@implementation RMPBuzzTimeLineDetailCell


+ (CGFloat)heightForPlace:(RMPPlace *)place
{
    if ([place.imageURL isEqualToString:@""]) {
        return 237;
    }
    return 620.0f;
}


- (void)setDataWithPlace:(RMPPlace *)place
{
    if (![place isKindOfClass:[RMPBuzzPlace class]]) {
        return;
    }

    RMPBuzzPlace *buzz = (RMPBuzzPlace *)place;
    self.nameLabel.text = buzz.userName;
    self.bodyLabel.text = buzz.text;
    self.dateLabel.text = buzz.date;
    
    [self.iconImageView setImageWithURL:[NSURL URLWithString:buzz.iconURL]
                       placeholderImage:[UIImage imageNamed:@"NO_IMAGE.png"]];
    
    self.bodyImageView = nil;
    if (![buzz.iconImage isEqual:@""]) {
        [self.bodyImageView setImageWithURL:[NSURL URLWithString:buzz.imageURL]
                           placeholderImage:[UIImage imageNamed:@"NO_IMAGE.png"]];
    }
    [self.likeAndMuteButtonView setOriginY:190];
}


@end
