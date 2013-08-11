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
#import "RMPBuzzCell.h"
#import "RMPPlayCell.h"
#import "RMPEatCell.h"
#import "RMPShopCell.h"

#import "RMPPlaceDetailCell.h"
#import "RMPBuzzDetailCell.h"
#import "RMPPlayDetailCell.h"
#import "RMPEatDetailCell.h"
#import "RMPShopDetailCell.h"

@interface RMPPlace()
@property (nonatomic) NSString *buzzId;
@property (nonatomic) NSString *userId;
@property (nonatomic) NSString *userName;
@property (nonatomic) NSString *iconURL;
@property (nonatomic) NSString *text;
@property (nonatomic) NSString *imageURL;
@property (nonatomic) NSString *date;
@property (nonatomic) float lat;
@property (nonatomic) float lot;
@property (nonatomic) BOOL like;
@property (nonatomic) BOOL mute;
@property (nonatomic) NSString *type;
@property (nonatomic) RMPBuzzAnnotation* annotation;
@end

@implementation RMPPlace
+ (NSString *)timeLineCellIdentifier
{
    return @"RMPPlaceCell";
}

- (CGFloat)heightForTimeLineCell
{
    return [RMPPlaceCell heightForPlace:self];
}




+ (NSString *)detailCellIdentifier
{
    return @"RMPPlaceDetailCell";
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
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}


@end


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

- (CGFloat)heightForDetailCell
{
    return [RMPBuzzDetailCell heightForPlace:self];
}



- (id)initWithDictionary:(NSDictionary *)buzzDictionary
{
    self = [self init];
    if (self && buzzDictionary)
    {
        self.buzzId   = buzzDictionary[@"buzz_id"];
        self.userId   = buzzDictionary[@"user_id"];
        self.userName = buzzDictionary[@"user_name"];
        self.iconURL  = buzzDictionary[@"user_img_url"];
        self.text     = buzzDictionary[@"buzz_body"];
        self.imageURL = buzzDictionary[@"buzz_img_url"];
        self.lat      = [buzzDictionary[@"lat"] floatValue];
        self.lot      = [buzzDictionary[@"lot"] floatValue];
        self.date     = buzzDictionary[@"time"];
        self.like      = [buzzDictionary[@"like"] boolValue];
        self.mute      = [buzzDictionary[@"mute"] boolValue];
        self.type      = buzzDictionary[@"type"];
        self.annotation = [[RMPBuzzAnnotation alloc] init];
        self.annotation.coordinate = CLLocationCoordinate2DMake(self.lat, self.lot);
        self.iconImage = nil;
        self.image = nil;
    }
    
    return self;
}


@end


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

- (CGFloat)heightForDetailCell
{
    return [RMPPlayDetailCell heightForPlace:self];
}



- (id)initWithDictionary:(NSDictionary *)buzzDictionary
{
    self = [self init];
    if (self && buzzDictionary)
    {
        self.buzzId   = buzzDictionary[@"buzz_id"];
        self.userId   = buzzDictionary[@"user_id"];
        self.userName = buzzDictionary[@"user_name"];
        self.iconURL  = buzzDictionary[@"user_img_url"];
        self.text     = buzzDictionary[@"buzz_body"];
        self.imageURL = buzzDictionary[@"buzz_img_url"];
        self.lat      = [buzzDictionary[@"lat"] floatValue];
        self.lot      = [buzzDictionary[@"lot"] floatValue];
        self.date     = buzzDictionary[@"time"];
        self.like      = [buzzDictionary[@"like"] boolValue];
        self.mute      = [buzzDictionary[@"mute"] boolValue];
        self.type      = buzzDictionary[@"type"];
        self.annotation = [[RMPPlayAnnotation alloc] init];
        self.annotation.coordinate = CLLocationCoordinate2DMake(self.lat, self.lot);
        self.iconImage = nil;
        self.image = nil;
    }
    
    return self;
}


@end

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

- (CGFloat)heightForDetailCell
{
    return [RMPEatDetailCell heightForPlace:self];
}



- (id)initWithDictionary:(NSDictionary *)buzzDictionary
{
    self = [self init];
    if (self && buzzDictionary)
    {
        self.buzzId   = buzzDictionary[@"buzz_id"];
        self.userId   = buzzDictionary[@"user_id"];
        self.userName = buzzDictionary[@"user_name"];
        self.iconURL  = buzzDictionary[@"user_img_url"];
        self.text     = buzzDictionary[@"buzz_body"];
        self.imageURL = buzzDictionary[@"buzz_img_url"];
        self.lat      = [buzzDictionary[@"lat"] floatValue];
        self.lot      = [buzzDictionary[@"lot"] floatValue];
        self.date     = buzzDictionary[@"time"];
        self.like      = [buzzDictionary[@"like"] boolValue];
        self.mute      = [buzzDictionary[@"mute"] boolValue];
        self.type      = buzzDictionary[@"type"];
        self.annotation = [[RMPEatAnnotation alloc] init];
        self.annotation.coordinate = CLLocationCoordinate2DMake(self.lat, self.lot);
        self.iconImage = nil;
        self.image = nil;
    }
    
    return self;
}


@end


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

- (CGFloat)heightForDetailCell
{
    return [RMPShopDetailCell heightForPlace:self];
}



- (id)initWithDictionary:(NSDictionary *)buzzDictionary
{
    self = [self init];
    if (self && buzzDictionary)
    {
        self.buzzId   = buzzDictionary[@"buzz_id"];
        self.userId   = buzzDictionary[@"user_id"];
        self.userName = buzzDictionary[@"user_name"];
        self.iconURL  = buzzDictionary[@"user_img_url"];
        self.text     = buzzDictionary[@"buzz_body"];
        self.imageURL = buzzDictionary[@"buzz_img_url"];
        self.lat      = [buzzDictionary[@"lat"] floatValue];
        self.lot      = [buzzDictionary[@"lot"] floatValue];
        self.date     = buzzDictionary[@"time"];
        self.like      = [buzzDictionary[@"like"] boolValue];
        self.mute      = [buzzDictionary[@"mute"] boolValue];
        self.type      = buzzDictionary[@"type"];
        self.annotation = [[RMPShopAnnotation alloc] init];
        self.annotation.coordinate = CLLocationCoordinate2DMake(self.lat, self.lot);
        self.iconImage = nil;
        self.image = nil;
    }
    
    return self;
}


@end


