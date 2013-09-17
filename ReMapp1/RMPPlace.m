//
//  Buzz.m
//  Model
//
//  Created by nishiba on 2013/06/30.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "RMPPlace.h"
#import "RMPAnnotation.h"

#import "RMPPlaceCell.h"
#import "RMPPlaceDetailCell.h"


@interface RMPPlace()
@property (nonatomic) float lat;
@property (nonatomic) float lon;
@property (nonatomic) NSInteger buzzId;
@property (nonatomic) NSInteger userId;
@property (nonatomic) NSString *userName;
@property (nonatomic) NSString *userImgURL;
@property (nonatomic) NSString *buzzBody;
@property (nonatomic) NSString *buzzImgUrl;
@property (nonatomic) NSDate *time;
@property (nonatomic) BOOL like;
@property (nonatomic) BOOL mute;
@property (nonatomic) NSString *buzzType;
@property (nonatomic) RMPBuzzAnnotation* annotation;
@property (nonatomic) UIColor *bgColor;
@end

@implementation RMPPlace
+ (NSString *)timeLineCellIdentifier
{
    return @"RMPPlaceCell";
}

+ (NSString *)detailCellIdentifier
{
    return @"RMPPlaceDetailCell";
}

- (NSString *)placeViewNibName
{
    return @"RMPPlaceView";
}


- (RMPAnnotation *)createAnnotaion
{
    return [[RMPAnnotation alloc] init];
}

- (CGFloat)heightForTimeLineCell
{
    return [RMPPlaceCell heightForPlace:self];
}

- (UIColor *)backgroundColor
{
    return nil;
}

- (CGFloat)heightForDetailCell
{
    return [RMPPlaceDetailCell heightForPlace:self];
}

- (void)setAnnotationIndex:(NSInteger)index
{
    self.annotation.index = index;
}

- (NSInteger)getAnnotationIndex
{
    return self.annotation.index;
}

- (id)initWithDictionary:(NSDictionary *)buzzDictionary
{
    self = [super init];
    if (self && buzzDictionary)
    {
        self.buzzId         = [buzzDictionary[@"buzz_id"] integerValue];
        self.userId         = [buzzDictionary[@"user_id"] integerValue];
        self.userName       = buzzDictionary[@"user_name"];
        self.userImgURL     = buzzDictionary[@"user_img_url"];
        self.buzzBody       = buzzDictionary[@"buzz_body"];
        self.buzzImgUrl     = buzzDictionary[@"buzz_img_url"];
        self.lat            = [buzzDictionary[@"lat"] floatValue];
        self.lon            = [buzzDictionary[@"lon"] floatValue];
        self.time           = [NSDate dateWithTimeIntervalSince1970:[buzzDictionary[@"time"] doubleValue] / 1000];
        self.like           = [buzzDictionary[@"like"] boolValue];
        self.mute           = [buzzDictionary[@"mute"] boolValue];
        self.buzzType       = buzzDictionary[@"buzz_type"];
        self.annotation     = [self createAnnotaion];
        self.annotation.coordinate = CLLocationCoordinate2DMake(self.lat, self.lon);
        self.bgColor        = [self backgroundColor];
        self.userImg = nil;
        self.buzzImg = nil;
    }
    
    return self;
}


@end
