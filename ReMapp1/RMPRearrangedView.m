//
//  RMPRearrangedView.m
//  ReMapp1
//
//  Created by nishiba on 2013/08/11.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "RMPRearrangedView.h"

@implementation RMPRearrangedView
CGFloat originY;

- (void)setOriginY:(CGFloat)aOriginY
{
    originY = aOriginY;
}
/*
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.layer.position = CGPointMake(self.frame.origin.x + 0.5 * self.frame.size.width,
                                      originY + 0.5 * self.frame.size.height);
}
*/
@end
