//
//  RMPBuzzListData.m
//  ReMapp1
//
//  Created by nishiba on 2013/08/11.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "RMPBuzzListData.h"
#import "RMPPlace.h"

NSString *const RMPBuzzListDataReloaded = @"RMPBuzzListDataReloaded";

@interface RMPBuzzListData()
@property (nonatomic) NSMutableArray *buzzes;
@end


@implementation RMPBuzzListData

- (id)init
{
    self = [super init];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)setUp
{
    self.buzzes = [[NSMutableArray alloc] init];
}

- (NSInteger)count
{
    return [self.buzzes count];
}


- (void)reloadMuteList
{
    //json
    NSString *urlStr = @"http://sky.geocities.jp/nishiba_m/buzz.json.js";
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url
                                                cachePolicy:NSURLRequestReloadIgnoringCacheData
                                            timeoutInterval:30.0f];
    NSURLResponse *response;
    NSError *error;
    NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest
                                         returningResponse:&response
                                                     error:&error];
    if (error != nil) {
        return;
    }
    else if ([data length] == 0) {
        return;
    }
    
    NSString *dataStr = [[NSString alloc] initWithData:data encoding:NSShiftJISStringEncoding];
    NSData *jsonData = [dataStr dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *buzzArray = [NSJSONSerialization JSONObjectWithData:jsonData
                                                         options:NSJSONReadingAllowFragments
                                                           error:nil];
    
    // NSInteger index = 0;
    [self.buzzes removeAllObjects];
    for (NSDictionary *buzzDictionary in buzzArray) {
        // This check must be done on the server.
        BOOL mute = [buzzDictionary[@"mute"] doubleValue];
        if (mute)
        {
            RMPPlace *place = [RMPPlaceFactory createPlace:buzzDictionary];
            [self.buzzes addObject:place];
        }
    }
    return;
}



@end
