//
//  Buzz.m
//  Model
//
//  Created by nishiba on 2013/06/30.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "RMPPlace.h"
#import "RMPAnnotation.h"

@interface RMPPlace()
@property (nonatomic) NSString *buzzId;
@property (nonatomic) NSString *userId;
@property (nonatomic) NSString *userName;
@property (nonatomic) NSString *iconURL;
@property (nonatomic) NSString *text;
@property (nonatomic) NSString *imageURL;
@property (nonatomic) UIImage *image;
@property (nonatomic) NSString *date;
@property (nonatomic) float lat;
@property (nonatomic) float lot;
@property (nonatomic) BOOL like;
@property (nonatomic) BOOL mute;
@property (nonatomic) NSString *type;
@property (nonatomic) RMPBuzzAnnotation* annotation;
@end

@implementation RMPPlace
- (id)init
{
    self = [super init];
    if( self )
    {
    }
    
    return self;
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

- (id)init
{
    self = [super init];
    if( self )
    {}
    return self;
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

- (id)init
{
    self = [super init];
    if( self )
    {}
    return self;
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

- (id)init
{
    self = [super init];
    if( self )
    {}
    return self;
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

- (id)init
{
    self = [super init];
    if( self )
    {}
    return self;
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


