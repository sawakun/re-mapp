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
    self.width = 0;
    self.text = nil;
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    [self setNumberOfLines:0];
    CGFloat thisWidth = self.width > 0 ? self.width : self.frame.size.width;
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, thisWidth, 0);
    [self sizeToFit];
}

-(void) layoutSubviews
{
    [super layoutSubviews];
    CGFloat thisWidth = self.width > 0 ? self.width : self.frame.size.width;
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, thisWidth, 0);
    [self setNumberOfLines:0];
    [self sizeToFit];
}


@end
