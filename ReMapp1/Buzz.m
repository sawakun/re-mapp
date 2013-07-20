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
@property (nonatomic) UIImage *iconImage;
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

- (id)initWithArray:(NSArray *)buzz Index:(NSInteger)index
{
    self = [self init];
    if (self && buzz)
    {
        self.buzzId   = buzz[0];
        self.userId   = buzz[1];
        self.userName = buzz[2];
        self.iconURL  = buzz[3];
        self.text     = buzz[4];
        self.imageURL = buzz[5];
        self.lat      = [buzz[6] floatValue];
        self.lot      = [buzz[7] floatValue];
        self.date     = buzz[8];
        self.annotation = [[RMPBuzzAnnotation alloc] init];
        self.annotation.coordinate = CLLocationCoordinate2DMake(self.lat, self.lot);
        self.annotation.index = index;
        
        NSData *iconData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.iconURL]];
        self.iconImage = [UIImage imageWithData:iconData];
        
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.imageURL]];
        self.image = [UIImage imageWithData:imageData];
    }
    
    return self;
}

@end
