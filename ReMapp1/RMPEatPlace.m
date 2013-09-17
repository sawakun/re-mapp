//
//  RMPEatPlace.m
//  ReMapp1
//
//  Created by nishiba on 2013/09/15.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "RMPEatPlace.h"

#import "RMPEatCell.h"
#import "RMPEatDetailCell.h"
#import "RMPAnnotation.h"

@implementation RMPEatPlace
+ (NSString *)timeLineCellIdentifier
{
    return @"RMPEatCell";
}

- (CGFloat)heightForTimeLineCell
{
    return [RMPEatCell heightForPlace:self];
}

+ (NSString *)detailCellIdentifier
{
    return @"RMPEatDetailCell";
}


- (NSString *)placeViewNibName
{
    return @"RMPEatView";
}


- (CGFloat)heightForDetailCell
{
    return [RMPEatDetailCell heightForPlace:self];
}

- (RMPAnnotation *)createAnnotaion
{
    return [[RMPEatAnnotation alloc] init];
}

- (UIColor *)backgroundColor
{
    return [UIColor colorWithRed:(0 / 255.0) green:(193 / 255.0) blue:(136 / 255.0) alpha:1.0];
}


@end
