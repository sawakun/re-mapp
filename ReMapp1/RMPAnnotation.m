//
//  RMPAnnotation.m
//  ReMapp1
//
//  Created by nishiba on 2013/07/17.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "RMPAnnotation.h"

@implementation RMPAnnotation
- (id)init
{
    self = [super init];
    if (self) {
        self.pinImage = [UIImage imageNamed:@"pin.png"];
        self.identifier = @"RMPAnnotation";
        self.centerOffset = CGPointMake(0.0f, 0.0f);
        self.index = 1;
    }
    return self;
}
@end

@implementation RMPBuzzAnnotation
- (id)init
{
    self = [super init];
    if (self) {
        self.pinImage = [UIImage imageNamed:@"PIN_BUZZ.png"];
        self.identifier = @"RMPBuzzAnnotation";
        self.centerOffset = CGPointMake(0.0f, -16.5f);
    }
    return self;
}
@end

@implementation RMPPlayAnnotation
- (id)init
{
    self = [super init];
    if (self) {
        self.pinImage = [UIImage imageNamed:@"PIN_PLAY.png"];
        self.identifier = @"RMPPlayAnnotation";
        self.centerOffset = CGPointMake(0.0f, -16.5f);
    }
    return self;
}
@end

@implementation RMPShopAnnotation
- (id)init
{
    self = [super init];
    if (self) {
        self.pinImage = [UIImage imageNamed:@"PIN_SHOP.png"];
        self.identifier = @"RMPShopAnnotation";
        self.centerOffset = CGPointMake(0.0f, -16.5f);
    }
    return self;
}
@end

@implementation RMPEatAnnotation
- (id)init
{
    self = [super init];
    if (self) {
        self.pinImage = [UIImage imageNamed:@"PIN_EAT.png"];
        self.identifier = @"RMPEatAnnotation";
        self.centerOffset = CGPointMake(0.0f, -16.5f);
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


@implementation RMPSelectedAnnotation
- (id)init
{
    self = [super init];
    if (self) {
        self.pinImage = [UIImage imageNamed:@"bigmarker.png"];
        self.identifier = @"RMPSelectedAnnotation";
        self.centerOffset = CGPointMake(0.0f, -15.0f);
    }
    return self;
}
@end