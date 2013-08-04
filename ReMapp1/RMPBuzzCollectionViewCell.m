//
//  RMPBuzzCollectionViewCell.m
//  ReMapp1
//
//  Created by nishiba on 2013/08/04.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "RMPBuzzCollectionViewCell.h"
#import "RMPPlaceViewController.h"

@implementation RMPBuzzCollectionViewCell

#pragma mark - initialization

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setUp];
    }
    return self;
}

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
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(frameDidMove:)
                                                 name:RMPPlaceViewControllerFrameDidMove
                                               object:nil];
}


- (void)frameDidMove:(NSNotification *)center
{
    CGFloat originY = [center.userInfo[@"frame.origin.y"] floatValue];
    NSLog(@"%f", self.likeAndMuteButtonVerticalConstraint.constant);
    if (originY >= 320) {
        self.likeAndMuteButtonVerticalConstraint.constant = 0;
    }
    else
    {
        self.likeAndMuteButtonVerticalConstraint.constant = -originY;
    }
}

@end
