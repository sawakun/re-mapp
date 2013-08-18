//
//  RMPRearrangedView.m
//  ReMapp1
//
//  Created by nishiba on 2013/08/11.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "RMPRearrangedView.h"

@implementation RMPRearrangedView
static CGFloat centerY;

- (void)setCenterY:(CGFloat)newCenterY
{
    centerY = newCenterY;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.layer.position = CGPointMake(self.layer.position.x, centerY);
}
@end
