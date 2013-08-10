//
//  RMPHeightToFitLabel.m
//  ReMapp1
//
//  Created by nishiba on 2013/08/09.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "RMPHeightToFitLabel.h"

@implementation RMPHeightToFitLabel


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)setUp
{
    self.text = nil;
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    [self setNumberOfLines:0];
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, 0);
    [self sizeToFit];
}

-(void) layoutSubviews
{
    [super layoutSubviews];
    [self setNumberOfLines:0];
    [self sizeToFit];
}


@end
