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
        self.pinImage = [UIImage imageNamed:@"pin1.png"];
        self.identifier = @"RMPBuzzAnnotation";
        self.centerOffset = CGPointMake(0.0f, -15.0f);
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