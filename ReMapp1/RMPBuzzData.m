//
//  BuzzData.m
//  Model
//
//  Created by nishiba on 2013/06/30.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "RMPBuzzData.h"
#import "Buzz.h"
#import "CSVHandler.h"

NSString *const RMPBuzzDataReloaded = @"RMPBuzzDataReloaded";


@implementation RMPBuzzData
@synthesize buzzes = _buzzes;


+(RMPBuzzData*)sharedManager
{
    static RMPBuzzData *sharedBuzzData;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedBuzzData = [[RMPBuzzData alloc] initSharedInstance];
    });
    return sharedBuzzData;
}

- (id)initSharedInstance
{
    self = [super init];
    if (self) {
        _buzzes = [[NSMutableArray alloc] init];
    }
    return self;
}

- (id) init
{
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}



- (Buzz *)buzzAtIndex:(NSInteger)index
{
    return [_buzzes objectAtIndex:index];
}

- (void)reload
{
    _buzzes = [[NSMutableArray alloc] init];
    static NSString *fileName = @"BuzzData.csv";
    NSMutableArray *data = readCSVFile(fileName);
    
    NSInteger index = 0;
    for(NSArray *d in data)
    {
        Buzz* buzz = [[Buzz alloc] initWithArray:d Index:index];
        [_buzzes addObject:buzz];
        ++index;
    }
}



/*
 - (void) reloadWithNorthEastCordinate:(CLLocationCoordinate2D)northEastCordinate
 SouthWestCoordinate:(CLLocationCoordinate2D)southWestCoordinate
 {
  
 static NSString *fileName = @"BuzzData.csv";
 NSMutableArray *data = readCSVFile(fileName);
 
 
 NSInteger index = 0;
 [_buzzes removeAllObjects];
 for(NSArray *d in data)
 {
 float lat = [d[6] floatValue];
 float lot = [d[7] floatValue];
 if (lat < northEastCordinate.latitude &&
 lat > southWestCoordinate.latitude &&
 lot < northEastCordinate.longitude &&
 lot > southWestCoordinate.longitude)
 {
 Buzz* buzz = [[Buzz alloc] initWithArray:d Index:index];
 [_buzzes addObject:buzz];
 ++index;
 }
 //if (index > 1000) {
 //    goto next;
 //}
 }
 next:
 
 dispatch_async(dispatch_get_main_queue(), ^{
 [[NSNotificationCenter defaultCenter] postNotificationName:RMPBuzzDataReloaded object:self userInfo:nil];
 });
 
 return;
 }
 */
- (void) reloadWithNorthEastCordinate:(CLLocationCoordinate2D)northEastCordinate
                  SouthWestCoordinate:(CLLocationCoordinate2D)southWestCoordinate
{
    
    //test json
    NSString *urlStr = @"http://sky.geocities.jp/nishiba_m/buzz.json.js";
    NSURL *url = [NSURL URLWithString:urlStr];
    NSString *jsonStr = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *buzzArray = [NSJSONSerialization JSONObjectWithData:jsonData
                                                     options:NSJSONReadingAllowFragments
                                                       error:nil];
    NSLog(@"reload!!");
    
    NSInteger index = 0;
    [_buzzes removeAllObjects];
    for (NSDictionary *buzzDictionary in buzzArray) {
        float lat = [buzzDictionary[@"lat"] floatValue];
        float lot = [buzzDictionary[@"lot"] floatValue];
        if (lat < northEastCordinate.latitude &&
            lat > southWestCoordinate.latitude &&
            lot < northEastCordinate.longitude &&
            lot > southWestCoordinate.longitude)
        {
            Buzz* buzz = [[Buzz alloc] initWithDictionary:buzzDictionary Index:index];
            [_buzzes addObject:buzz];
            ++index;
        }
    }
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:RMPBuzzDataReloaded object:self userInfo:nil];
    });

    return;
}


- (NSInteger)count
{
    return [_buzzes count];
}

@end
