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

- (id)init
{
    self = [super init];
    if( self )
    {
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
    
    for(NSArray *d in data)
    {
        Buzz* buzz = [[Buzz alloc] initWithArray:d];
        [_buzzes addObject:buzz];
    }
}


- (NSInteger)count
{
    return [_buzzes count];
}

@end
