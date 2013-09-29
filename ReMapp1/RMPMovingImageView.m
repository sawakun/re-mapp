//
//  RMPMovingImageView.m
//  ReMapp1
//
//  Created by Masahiro Nishiba on 2013/09/29.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "RMPMovingImageView.h"

@implementation RMPMovingImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)moveToPosition:(CGPoint)position
{
    position.x += self.centerOffset.x;
    position.y += self.centerOffset.y;
    self.layer.position = position;
}


@end
