//
//  Buzz.m
//  Model
//
//  Created by nishiba on 2013/06/30.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "Buzz.h"
#import "RMPAnnotation.h"

@interface Buzz()
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
@property (nonatomic) RMPBuzzAnnotation* annotation;
@end

@implementation Buzz

- (id)init
{
    self = [super init];
    if( self )
    {
    }
    
    return self;
}

- (id)initWithBuzz:(NSDictionary *)buzz Index:(NSInteger)index
{
    self = [self init];
    if (self && buzz)
    {
        self.buzzId  = [[buzz objectForKey:@"id"] copy];
        self.userId  = [[buzz objectForKey:@"userId"] copy];
        self.text    = [[buzz objectForKey:@"text"] copy];
        self.imageURL  = [[buzz objectForKey:@"img"] copy];
        self.date    = [[buzz objectForKey:@"date"] copy];
        self.lat     = [[buzz objectForKey:@"lat"] floatValue];
        self.lot     = [[buzz objectForKey:@"lot"] floatValue];
        self.annotation = [[RMPBuzzAnnotation alloc] init];
        self.annotation.coordinate = CLLocationCoordinate2DMake(self.lat, self.lot);
        self.annotation.index = index;
    }
    
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
        self.annotation = [[RMPBuzzAnnotation alloc] init];
        self.annotation.coordinate = CLLocationCoordinate2DMake(self.lat, self.lot);
        self.iconImage = nil;
        self.image = nil;
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

@end
