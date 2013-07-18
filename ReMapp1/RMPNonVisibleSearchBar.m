//
//  RMPNonVisibleSearchBar.m
//  ReMapp1
//
//  Created by Masahiro Nishiba on 2013/07/18.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "RMPNonVisibleSearchBar.h"

@implementation RMPNonVisibleSearchBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    self.opaque = NO;
    self.translucent = YES;
    self.backgroundColor = [UIColor clearColor];
    [[self.subviews objectAtIndex:0] removeFromSuperview];
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [[self.subviews objectAtIndex:0] removeFromSuperview];
}

@end
