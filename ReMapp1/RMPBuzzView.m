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
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY/MM/dd hh:mm:ss"];
    self.timeLabel.text = [formatter stringFromDate:buzz.time];
    
    if (![buzz.buzzImgUrl isEqual:@""]) {
        [self.buzzImageView setImageWithURL:[NSURL URLWithString:buzz.buzzImgUrl]
                           placeholderImage:[UIImage imageNamed:@"NO_IMAGE.png"]];
    }
}


@end
