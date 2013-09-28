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
        self.pinImage               = [UIImage imageNamed:@"pin_a1.png"];
        self.selectedPinImage       = [UIImage imageNamed:@"pin_a2.png"];
        self.centerOffset           = CGPointMake(0.0f, -15.5f);
        self.selectedCenterOffset   = CGPointMake(0.0f, -21.0f);
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
        self.pinImage               = [UIImage imageNamed:@"pin_b1.png"];
        self.selectedPinImage       = [UIImage imageNamed:@"pin_b2.png"];
        self.centerOffset           = CGPointMake(0.0f, -15.5f);
        self.selectedCenterOffset   = CGPointMake(0.0f, -21.0f);
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
        self.pinImage               = [UIImage imageNamed:@"pin_c1.png"];
        self.selectedPinImage       = [UIImage imageNamed:@"pin_c2.png"];
        self.centerOffset           = CGPointMake(0.0f, -15.5f);
        self.selectedCenterOffset   = CGPointMake(0.0f, -21.0f);
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
        self.pinImage               = [UIImage imageNamed:@"pin_d1.png"];
        self.selectedPinImage       = [UIImage imageNamed:@"pin_d2.png"];
        self.centerOffset           = CGPointMake(0.0f, -15.5f);
        self.selectedCenterOffset   = CGPointMake(0.0f, -21.0f);
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

