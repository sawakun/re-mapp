//
//  RMPBuzzTimeLineDetailCell.m
//  ReMapp1
//
//  Created by nishiba on 2013/08/10.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "RMPBuzzDetailCell.h"
#import "RMPPlaceAll.h"
#import "RMPHeightToFitLabel.h"
#import "UIImageView+WebCache.h"

@implementation RMPBuzzDetailCell


+ (CGFloat)heightForPlace:(RMPPlace *)place
{
    if ([place.buzzImgUrl isEqualToString:@""]) {
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
    self.bodyLabel.text = buzz.buzzBody;

    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY/MM/dd hh:mm:ss"];
    self.dateLabel.text = [formatter stringFromDate:buzz.time];

    self.bodyLabel.width = 245;
    [self.innerScrollView setContentOffset:CGPointMake(0, 0)];
    
    
    [self.iconImageView setImageWithURL:[NSURL URLWithString:buzz.userImgURL]
                       placeholderImage:[UIImage imageNamed:@"NO_IMAGE.png"]];
    
    self.bodyImageView.image = nil;
    if (![buzz.buzzImgUrl isEqual:@""]) {
        [self.bodyImageView setImageWithURL:[NSURL URLWithString:buzz.buzzImgUrl]
                           placeholderImage:[UIImage imageNamed:@"NO_IMAGE.png"]];
    }
}


@end
