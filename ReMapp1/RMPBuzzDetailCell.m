//
//  RMPBuzzTimeLineDetailCell.m
//  ReMapp1
//
//  Created by nishiba on 2013/08/10.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "RMPBuzzDetailCell.h"
#import "RMPPlace.h"
#import "RMPHeightToFitLabel.h"
#import "UIImageView+WebCache.h"
#import "RMPRearrangedView.h"

@implementation RMPBuzzDetailCell


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
    self.bodyLabel.width = 245;
    
    [self.iconImageView setImageWithURL:[NSURL URLWithString:buzz.iconURL]
                       placeholderImage:[UIImage imageNamed:@"NO_IMAGE.png"]];
    
<<<<<<< HEAD:ReMapp1/RMPBuzzTimeLineDetailCell.m
    self.bodyImageView = nil;
    if (![buzz.iconImage isEqual:@""]) {
        [self.bodyImageView setImageWithURL:[NSURL URLWithString:buzz.imageURL]
                           placeholderImage:[UIImage imageNamed:@"NO_IMAGE.png"]];
    }
    [self.likeAndMuteButtonView setOriginY:190];
=======
    self.bodyImageView.image = nil;
    if (![buzz.imageURL isEqual:@""]) {
        [self.bodyImageView setImageWithURL:[NSURL URLWithString:buzz.imageURL]
                           placeholderImage:[UIImage imageNamed:@"NO_IMAGE.png"]];
    }
>>>>>>> origin/new/TimeLine:ReMapp1/RMPBuzzDetailCell.m
}


@end
