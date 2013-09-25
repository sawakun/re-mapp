//
//  RMPPlayPlace.m
//  ReMapp1
//
//  Created by nishiba on 2013/09/15.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "RMPPlayPlace.h"

#import "RMPPlayCell.h"
#import "RMPPlayDetailCell.h"
#import "RMPAnnotation.h"

@implementation RMPPlayPlace
+ (NSString *)timeLineCellIdentifier
{
    return @"RMPPlayCell";
}

- (CGFloat)heightForTimeLineCell
{
    return [RMPPlayCell heightForPlace:self];
}

+ (NSString *)detailCellIdentifier
{
    return @"RMPPlayDetailCell";
}

- (NSString *)placeViewNibName
{
    return @"RMPFixedPlaceView";
}


- (CGFloat)heightForDetailCell
{
    return [RMPPlayDetailCell heightForPlace:self];
}


- (RMPAnnotation *)createAnnotaion
{
    return [[RMPPlayAnnotation alloc] init];
}


- (UIColor *)backgroundColor
{
    return [UIColor colorWithRed:(71 / 255.0) green:(193 / 255.0) blue:(0 / 255.0) alpha:1.0];
}

@end
