//
//  RMPBuzzTimeLineCollectionViewCell.m
//  ReMapp1
//
//  Created by nishiba on 2013/08/08.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "RMPBuzzCell.h"
#import "RMPPlaceAll.h"
#import "UIImageView+WebCache.h"
#import "RMPHeightToFitLabel.h"

@implementation RMPBuzzCell

+ (CGFloat)heightForPlace:(RMPPlace *)place
{
    if (![place isKindOfClass:[RMPBuzzPlace class]])
    {
        return 0.0;
    }
    
    RMPBuzzPlace *buzz = (RMPBuzzPlace *)place;
   
    CGSize maximumLabelSize = CGSizeMake(245,9999);
    
    UIFont *cellFont = [UIFont systemFontOfSize:14];
    CGSize expectedLabelSize = [buzz.buzzBody sizeWithFont:cellFont
                                     constrainedToSize:maximumLabelSize
                                         lineBreakMode:NSLineBreakByWordWrapping];
    
    //adjust the label the the new height.
    return expectedLabelSize.height + 55.0f;
}


- (void)setDataWithPlace:(RMPPlace *)place
{
    if (![place isKindOfClass:[RMPBuzzPlace class]])
    {
        return;
    }
    
    RMPBuzzPlace *buzz = (RMPBuzzPlace *)place;
    self.nameLabel.text = buzz.userName;
    self.bodyLabel.text = buzz.buzzBody;
    
    // NSDateFormatter を用意します。
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY/MM/dd hh:mm:ss"];
    self.dateLabel.text = [formatter stringFromDate:buzz.time];
    
    [self.iconImageView setImageWithURL:[NSURL URLWithString:buzz.userImgURL]
                       placeholderImage:[UIImage imageNamed:@"NO_IMAGE.png"]];
    
}

@end
