//
//  RMPScrollViewInPlaceMapCell.m
//  ReMapp1
//
//  Created by nishiba on 2013/10/05.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "RMPScrollViewInPlaceMapCell.h"


@implementation RMPScrollViewInPlaceMapCell
NSString *const RMPScrollViewInPlaceMapCellDidMove = @"RMPScrollViewInPlaceMapCellDidMove";
static CGPoint _leftTopPosition;

- (void)setup
{
    //[self updatePosition];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updatePosition)
                                                 name:RMPScrollViewInPlaceMapCellDidMove
                                               object:nil];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

-(void)setLeftTopPosition:(CGPoint)leftTopPosition
{
    _leftTopPosition = leftTopPosition;
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:RMPScrollViewInPlaceMapCellDidMove object:self userInfo:nil];
    });
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self updatePosition];
}

- (void)updatePosition
{
    self.layer.position = [self centerPosition];
}

- (CGPoint)centerPosition
{
    CGFloat height = self.frame.size.height;
    CGFloat width = self.frame.size.width;
    return CGPointMake(_leftTopPosition.x + width * 0.5, _leftTopPosition.y + height * 0.5);
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
