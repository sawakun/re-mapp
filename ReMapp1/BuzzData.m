//
//  BuzzData.m
//  Model
//
//  Created by nishiba on 2013/06/30.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "BuzzData.h"
#import "Buzz.h"
#import "CSVHandler.h"

@implementation BuzzData
@synthesize buzzes = _buzzes;

- (id) init
{
    self = [super init];
    if (self) {
        // Custom initialization
        _buzzes = [[NSMutableArray alloc] init];
    }
    return self;
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

- (void) reloadWithNorthEastCordinate:(CLLocationCoordinate2D)northEastCordinate
                  SouthWestCoordinate:(CLLocationCoordinate2D)southWestCoordinate
{
    static NSString *fileName = @"BuzzData.csv";
    NSMutableArray *data = readCSVFile(fileName);
    
    
    NSInteger index = 0;
    [_buzzes removeAllObjects];
    for(NSArray *d in data)
    {
        float lat = [d[4] floatValue];
        float lot = [d[5] floatValue];
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
    return;
}


- (NSInteger)count
{
    return [_buzzes count];
}

@end
