//
//  RMPShopPlace.m
//  ReMapp1
//
//  Created by nishiba on 2013/09/15.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "RMPShopPlace.h"
#import "RMPShopCell.h"
#import "RMPShopDetailCell.h"
#import "RMPAnnotation.h"

@implementation RMPShopPlace
+ (NSString *)timeLineCellIdentifier
{
    return @"RMPShopCell";
}

- (CGFloat)heightForTimeLineCell
{
    return [RMPShopCell heightForPlace:self];
}

+ (NSString *)detailCellIdentifier
{
    return @"RMPShopDetailCell";
}

- (NSString *)placeViewNibName
{
    return @"RMPShopView";
}


- (CGFloat)heightForDetailCell
{
    return [RMPShopDetailCell heightForPlace:self];
}


- (RMPAnnotation *)createAnnotaion
{
    return [[RMPShopAnnotation alloc] init];
}


- (UIColor *)backgroundColor
{
    return [UIColor colorWithRed:(0 / 255.0) green:(193 / 255.0) blue:(60 / 255.0) alpha:1.0];
}


@end
