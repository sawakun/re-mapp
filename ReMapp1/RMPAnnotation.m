//
//  RMPAnnotation.m
//  ReMapp1
//
//  Created by nishiba on 2013/07/17.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "RMPAnnotation.h"

@implementation RMPAnnotationData : MKPointAnnotation
@end

@implementation RMPAnnotation
- (RMPSelectedAnnotation *)createSelectedAnnotation
{
    return nil;
}
@end

@implementation RMPSelectedAnnotation
- (RMPAnnotation *)createAnnotation
{
    return nil;
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
- (RMPSelectedAnnotation *)createSelectedAnnotation
{
    RMPSelectedAnnotation *selectedAnnotation = (RMPSelectedAnnotation*)[[RMPSelectedBuzzAnnotation alloc] init];
    selectedAnnotation.coordinate = self.coordinate;
    selectedAnnotation.index = self.index;
    return selectedAnnotation;
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
- (RMPSelectedAnnotation *)createSelectedAnnotation
{
    RMPSelectedAnnotation *selectedAnnotation = (RMPSelectedAnnotation*)[[RMPSelectedPlayAnnotation alloc] init];
    selectedAnnotation.coordinate = self.coordinate;
    selectedAnnotation.index = self.index;
    return selectedAnnotation;
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
- (RMPSelectedAnnotation *)createSelectedAnnotation
{
    RMPSelectedAnnotation *selectedAnnotation = (RMPSelectedAnnotation*)[[RMPSelectedShopAnnotation alloc] init];
    selectedAnnotation.coordinate = self.coordinate;
    selectedAnnotation.index = self.index;
    return selectedAnnotation;
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
- (RMPSelectedAnnotation *)createSelectedAnnotation
{
    RMPSelectedAnnotation *selectedAnnotation = (RMPSelectedAnnotation*)[[RMPSelectedEatAnnotation alloc] init];
    selectedAnnotation.coordinate = self.coordinate;
    selectedAnnotation.index = self.index;
    return selectedAnnotation;
}
@end

@implementation RMPSelectedBuzzAnnotation
- (id)init
{
    self = [super init];
    if (self) {
        self.pinImage = [UIImage imageNamed:@"PIN_BUZZ_SELECTED.png"];
        self.identifier = @"RMPSelectedBuzzAnnotation";
        self.centerOffset = CGPointMake(0.0f, -22.0f);
    }
    return self;
}

- (RMPAnnotation *)createAnnotation
{
    RMPAnnotation *annotation = (RMPAnnotation*)[[RMPBuzzAnnotation alloc] init];
    annotation.coordinate = self.coordinate;
    annotation.index = self.index;
    return annotation;
}
@end

@implementation RMPSelectedPlayAnnotation
- (id)init
{
    self = [super init];
    if (self) {
        self.pinImage = [UIImage imageNamed:@"PIN_PLAY_SELECTED.png"];
        self.identifier = @"RMPSelectedPlayAnnotation";
        self.centerOffset = CGPointMake(0.0f, -22.0f);
    }
    return self;
}

- (RMPAnnotation *)createAnnotation
{
    RMPAnnotation *annotation = (RMPAnnotation*)[[RMPPlayAnnotation alloc] init];
    annotation.coordinate = self.coordinate;
    annotation.index = self.index;
    return annotation;
}
@end

@implementation RMPSelectedShopAnnotation
- (id)init
{
    self = [super init];
    if (self) {
        self.pinImage = [UIImage imageNamed:@"PIN_SHOP_SELECTED.png"];
        self.identifier = @"RMPSelectedShopAnnotation";
        self.centerOffset = CGPointMake(0.0f, -22.0f);
    }
    return self;
}
- (RMPAnnotation *)createAnnotation
{
    RMPAnnotation *annotation = (RMPAnnotation*)[[RMPShopAnnotation alloc] init];
    annotation.coordinate = self.coordinate;
    annotation.index = self.index;
    return annotation;
}
@end

@implementation RMPSelectedEatAnnotation
- (id)init
{
    self = [super init];
    if (self) {
        self.pinImage = [UIImage imageNamed:@"PIN_EAT_SELECTED.png"];
        self.identifier = @"RMPSelectedEatAnnotation";
        self.centerOffset = CGPointMake(0.0f, -22.0f);
    }
    return self;
}
- (RMPAnnotation *)createAnnotation
{
    RMPAnnotation *annotation = (RMPAnnotation*)[[RMPEatAnnotation alloc] init];
    annotation.coordinate = self.coordinate;
    annotation.index = self.index;
    return annotation;
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

