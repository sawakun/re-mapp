//
//  RMPAnnotation.m
//  ReMapp1
//
//  Created by nishiba on 2013/07/17.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "RMPAnnotation.h"


@implementation RMPAnnotation
@end


@implementation RMPBuzzAnnotation
- (id)init
{
    self = [super init];
    if (self) {
        self.identifier             = @"RMPBuzzAnnotation";
        self.pinImage               = [UIImage imageNamed:@"PIN_BUZZ.png"];
        self.selectedPinImage       = [UIImage imageNamed:@"PIN_BUZZ_SELECTED.png"];
        self.centerOffset           = CGPointMake(0.0f, -16.5f);
        self.additionalCenterOffset = CGPointMake(0.0f, -5.5f);
    }
    return self;
}
@end

@implementation RMPPlayAnnotation
- (id)init
{
    self = [super init];
    if (self) {
        self.identifier             = @"RMPPlayAnnotation";
        self.pinImage               = [UIImage imageNamed:@"PIN_PLAY.png"];
        self.selectedPinImage       = [UIImage imageNamed:@"PIN_PLAY_SELECTED.png"];
        self.centerOffset           = CGPointMake(0.0f, -16.5f);
        self.additionalCenterOffset = CGPointMake(0.0f, -5.5f);
    }
    return self;
}
@end

@implementation RMPShopAnnotation
- (id)init
{
    self = [super init];
    if (self) {
        self.identifier             = @"RMPShopAnnotation";
        self.pinImage               = [UIImage imageNamed:@"PIN_SHOP.png"];
        self.selectedPinImage       = [UIImage imageNamed:@"PIN_SHOP_SELECTED.png"];
        self.centerOffset           = CGPointMake(0.0f, -16.5f);
        self.additionalCenterOffset = CGPointMake(0.0f, -5.5f);
    }
    return self;
}
@end

@implementation RMPEatAnnotation
- (id)init
{
    self = [super init];
    if (self) {
        self.identifier             = @"RMPEatAnnotation";
        self.pinImage               = [UIImage imageNamed:@"PIN_EAT.png"];
        self.selectedPinImage       = [UIImage imageNamed:@"PIN_EAT_SELECTED.png"];
        self.centerOffset           = CGPointMake(0.0f, -16.5f);
        self.additionalCenterOffset = CGPointMake(0.0f, -5.5f);
    }
    return self;
}
@end


@implementation RMPWriteFormAnnotation
- (id)init
{
    self = [super init];
    if (self) {
        self.pinImage = [UIImage imageNamed:@"writeFormPin.png"];
        self.identifier = @"RMPWriteFormAnnotation";
        self.tapPointOffset = CGPointMake(0.0f, -55.0f);
    }
    return self;
}
@end

