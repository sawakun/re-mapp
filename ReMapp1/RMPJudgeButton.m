//
//  RMPJudgeButton.m
//  ReMapp1
//
//  Created by nishiba on 2013/10/04.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "RMPJudgeButton.h"

@interface RMPJudgeButton()
@property UIImage *noJudgeImage;
@property UIImage *judgeImage;
@end

@implementation RMPJudgeButton

-(void)setup
{
    self.noJudgeImage = [self imageForState:UIControlStateNormal];
    self.judgeImage = [self imageForState:UIControlStateHighlighted];
    _isJudged = NO;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)changeJudgement
{
    if (self.isJudged) {
        [self setImage:self.noJudgeImage forState:UIControlStateNormal];
        [self setImage:self.judgeImage forState:UIControlStateHighlighted];
        _isJudged = NO;
    }
    else {
        [self setImage:self.judgeImage forState:UIControlStateNormal];
        [self setImage:self.noJudgeImage forState:UIControlStateHighlighted];
        _isJudged = YES;
    }
}

-(void)setIsJudged:(BOOL)isJudged
{
    _isJudged = isJudged;
    if (self.isJudged) {
        [self setImage:self.judgeImage forState:UIControlStateNormal];
        [self setImage:self.noJudgeImage forState:UIControlStateHighlighted];
    }
    else {
        [self setImage:self.noJudgeImage forState:UIControlStateNormal];
        [self setImage:self.judgeImage forState:UIControlStateHighlighted];
    }
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
