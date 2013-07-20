//
//  ClearColorToolBar.m
//  Buzz1.0
//
//  Created by nishiba on 2013/06/22.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "RMPNonVisibleToolBar.h"

@implementation RMPNonVisibleToolBar


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    self.opaque = NO;
    self.translucent = YES;
    self.backgroundColor = [UIColor clearColor];
    return self;
}

- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
 

@end
