//
//  RMPBuzzPlace.m
//  ReMapp1
//
//  Created by nishiba on 2013/09/15.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "RMPBuzzPlace.h"
#import "RMPBuzzCell.h"
#import "RMPBuzzDetailCell.h"
#import "RMPAnnotation.h"


@implementation RMPBuzzPlace
+ (NSString *)timeLineCellIdentifier
{
    return @"RMPBuzzCell";
}

- (CGFloat)heightForTimeLineCell
{
    return [RMPBuzzCell heightForPlace:self];
}

+ (NSString *)detailCellIdentifier
{
    return @"RMPBuzzDetailCell";
}

+ (NSString *)mapCellIdentifier
{
    return @"RMPBuzzMapCell";
}


- (NSString *)placeViewNibName
{
    return @"RMPBuzzView";
}


- (CGFloat)heightForDetailCell
{
    return [RMPBuzzDetailCell heightForPlace:self];
}

- (RMPAnnotation *)createAnnotaion
{
    return [[RMPBuzzAnnotation alloc] init];
}


- (UIColor *)backgroundColor
{
    return [UIColor colorWithRed:(0 / 255.0) green:(174 / 255.0) blue:(193 / 255.0) alpha:1.0];
}

@end

