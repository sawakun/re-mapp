//
//  Buzz.m
//  Model
//
//  Created by nishiba on 2013/06/30.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "Buzz.h"

@implementation Buzz

@synthesize userId = _userId;
@synthesize text = _text;
@synthesize img = _img;
@synthesize date = _date;
@synthesize lot = _lot;
@synthesize lat = _lat;

- (id)init
{
    self = [super init];
    if( self )
    {
    }
    
    return self;
}

- (id)initWithBuzz:(NSDictionary *)buzz
{
    self = [self init];
    if (self && buzz)
    {
        _id      = [[buzz objectForKey:@"id"] copy];
        _userId  = [[buzz objectForKey:@"userId"] copy];
        _text    = [[buzz objectForKey:@"text"] copy];
        _img     = [[buzz objectForKey:@"img"] copy];
        _date    = [[buzz objectForKey:@"date"] copy];
        _lot     = [[buzz objectForKey:@"lot"] floatValue];
        _lat     = [[buzz objectForKey:@"lat"] floatValue];
    }
    
    return self;
}

- (id)initWithArray:(NSArray *)buzz
{
    self = [self init];
    if (self && buzz)
    {
        _id      = buzz[0];
        _userId  = buzz[1];
        _text    = buzz[2];
        _img     = buzz[3];
        _lot     = [buzz[4] floatValue];
        _lat     = [buzz[5] floatValue];
        _date    = buzz[6];
    }
    
    return self;
}

@end
