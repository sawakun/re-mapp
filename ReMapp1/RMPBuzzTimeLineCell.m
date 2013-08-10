//
//  RMPBuzzTimeLineCollectionViewCell.m
//  ReMapp1
//
//  Created by nishiba on 2013/08/08.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "RMPBuzzTimeLineCell.h"
#import "RMPPlace.h"
#import "UIImageView+WebCache.h"
#import "RMPHeightToFitLabel.h"

@implementation RMPBuzzTimeLineCell

+ (CGFloat)heightForPlace:(RMPPlace *)place
{
    if (![place isKindOfClass:[RMPBuzzPlace class]])
    {
        return 0.0;
    }
    
    RMPBuzzPlace *buzz = (RMPBuzzPlace *)place;
   
    CGSize maximumLabelSize = CGSizeMake(245,9999);
    
    UIFont *cellFont = [UIFont systemFontOfSize:14];
    CGSize expectedLabelSize = [buzz.text sizeWithFont:cellFont
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
    self.bodyLabel.text = buzz.text;
    self.dateLabel.text = buzz.date;
    
    [self.iconImageView setImageWithURL:[NSURL URLWithString:buzz.iconURL]
                       placeholderImage:[UIImage imageNamed:@"NO_IMAGE.png"]];
    
}

@end
