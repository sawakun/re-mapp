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
#import "RMPMapView.h"

NSString *const RMPBuzzDataReloaded = @"RMPBuzzDataReloaded";


@implementation RMPBuzzData
@synthesize buzzes = _currentViewBuzzData;


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
        _currentViewBuzzData = [[NSMutableArray alloc] init];
        _buzzData = [[NSMutableArray alloc] init];
        _buzzDataNorthEastLat = 0.0f;
        _buzzDataNorthEastLot = 0.0f;
        _buzzDataSouthWestLat = 0.0f;
        _buzzDataSouthWestLot = 0.0f;
        _urlRequestNorthEastLat = 0.0f;
        _urlRequestNorthEastLot = 0.0f;
        _urlRequestSouthWestLat = 0.0f;
        _urlRequestSouthWestLot = 0.0f;
        _widthCurrentView = 0.0;
        _queue = dispatch_queue_create("com.re-mapp", DISPATCH_QUEUE_SERIAL);
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(reload:)
                                                     name:RMPMapViewRegionDidChangeAnimated
                                                   object:nil];
        
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
    if (index >= [_currentViewBuzzData count]) {
        return nil;
    }
    return [_currentViewBuzzData objectAtIndex:index];
}


- (void)reload:(NSNotification *)center
{
    double northEastLat = [center.userInfo[@"northEastLat"] doubleValue];
    double northEastLot = [center.userInfo[@"northEastLot"] doubleValue];
    double southWestLat = [center.userInfo[@"southWestLat"] doubleValue];
    double southWestLot = [center.userInfo[@"southWestLot"] doubleValue];
    //dispatch_queue_t queue = dispatch_queue_create("com.re-mapp", NULL);
    dispatch_async(_queue, ^{
        [self reloadWithNorthEastLat:northEastLat NorthEastLot:northEastLot SouthWestLat:southWestLat SouthWestLot:southWestLot];
    });
}

- (void)reloadWithNorthEastLat:(double)northEastLat
                  NorthEastLot:(double)northEastLot
                  SouthWestLat:(double)southWestLat
                  SouthWestLot:(double)southWestLot
{
    
    if ([self isOutOrRangeBuzzDataWithNorthEastLat:northEastLat
                                      NorthEastLot:northEastLot
                                      SouthWestLat:southWestLat
                                      SouthWestLot:southWestLot] ||
        (northEastLot- southWestLot) != _widthCurrentView) {


        
        NSLog(@"Case 1");
        [NSURLConnection cancelPreviousPerformRequestsWithTarget:self];
        NSLog(@"%f, %f", northEastLat, southWestLat);
        [self fetchBuzzDataWithNorthEastLat:northEastLat
                               NorthEastLot:northEastLot
                               SouthWestLat:southWestLat
                               SouthWestLot:southWestLot];
        
        [self setCurrentBuzzDataWithNorthEastLat:northEastLat
                                    NorthEastLot:northEastLot
                                    SouthWestLat:southWestLat
                                    SouthWestLot:southWestLot];
        return;
    }
    
    if ([self isOutOrRangeNoURLRequestWithNorthEastLat:northEastLat
                                          NorthEastLot:northEastLot
                                          SouthWestLat:southWestLat
                                          SouthWestLot:southWestLot])
    {
        NSLog(@"Case 2");
        [self setCurrentBuzzDataWithNorthEastLat:northEastLat
                                    NorthEastLot:northEastLot
                                    SouthWestLat:southWestLat
                                    SouthWestLot:southWestLot];
        
        [self fetchBuzzDataWithNorthEastLat:northEastLat
                               NorthEastLot:northEastLot
                               SouthWestLat:southWestLat
                               SouthWestLot:southWestLot];
        return;
    }

    
    NSLog(@"Case 3");
    [self setCurrentBuzzDataWithNorthEastLat:northEastLat
                                NorthEastLot:northEastLot
                                SouthWestLat:southWestLat
                                SouthWestLot:southWestLot];
    
    return;
}

- (BOOL)isOutOrRangeBuzzDataWithNorthEastLat:(double)northEastLat
                                NorthEastLot:(double)northEastLot
                                SouthWestLat:(double)southWestLat
                                SouthWestLot:(double)southWestLot
{
    if (_buzzDataNorthEastLat > northEastLat &&
        _buzzDataSouthWestLat < southWestLat &&
        _buzzDataNorthEastLot > northEastLot &&
        _buzzDataSouthWestLot < southWestLot)
    {
        return NO;
    }
    return YES;
}

- (BOOL)isOutOrRangeNoURLRequestWithNorthEastLat:(double)northEastLat
                                    NorthEastLot:(double)northEastLot
                                    SouthWestLat:(double)southWestLat
                                    SouthWestLot:(double)southWestLot
{
    if (_urlRequestNorthEastLat > northEastLat &&
        _urlRequestSouthWestLat < southWestLat &&
        _urlRequestNorthEastLot > northEastLot &&
        _urlRequestSouthWestLot < southWestLot)
    {
        return NO;
    }
    return YES;
}


- (void)setCurrentBuzzDataWithNorthEastLat:(double)northEastLat
                              NorthEastLot:(double)northEastLot
                              SouthWestLat:(double)southWestLat
                              SouthWestLot:(double)southWestLot
{
    
    NSInteger index = 0;
    NSLog(@"Send notification.");
    [_currentViewBuzzData removeAllObjects];
    for (Buzz *buzz in _buzzData) {
        if (buzz.lat < northEastLat &&
            buzz.lat > southWestLat &&
            buzz.lot < northEastLot &&
            buzz.lot > southWestLot)
        {
            buzz.annotationIndex = index;
            [_currentViewBuzzData addObject:buzz];
            ++index;
        }
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:RMPBuzzDataReloaded object:self userInfo:nil];
    });
}

- (void)fetchBuzzDataWithNorthEastLat:(double)northEastLat
                         NorthEastLot:(double)northEastLot
                         SouthWestLat:(double)southWestLat
                         SouthWestLot:(double)southWestLot
{
    // set new _buzzDataNorthEastLat...
    double widthLot = northEastLot - southWestLot;
    double heigthLat = northEastLat - southWestLat;
    _buzzDataNorthEastLat = northEastLat + 2 * heigthLat;
    _buzzDataNorthEastLot = northEastLot + 2 * widthLot;
    _buzzDataSouthWestLat = southWestLat - 2 * heigthLat;
    _buzzDataSouthWestLot = southWestLot - 2 * widthLot;
    _urlRequestNorthEastLat = northEastLat + heigthLat;
    _urlRequestNorthEastLot = northEastLot + widthLot;
    _urlRequestSouthWestLat = southWestLat - heigthLat;
    _urlRequestSouthWestLot = southWestLot - widthLot;
    _widthCurrentView = widthLot;
    
    
    //json
    NSString *urlStr = @"http://sky.geocities.jp/nishiba_m/buzz.json.js";
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10.0f];
    NSURLResponse *response;
    NSError *error;
    NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest
                                        returningResponse:&response
                                                    error:&error];    
    if (error != nil) {
//        NSLog(@"Error happend = %@", error);
        NSLog(@"Error happend.");
        return;
    }
    else if ([data length] == 0) {
        NSLog(@"Nothing was downloaded.");
        return;
    }
    else
    {
        NSLog(@"fetch data.");
        NSString *dataStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSData *jsonData = [dataStr dataUsingEncoding:NSUTF8StringEncoding];
        NSLog(@"set array.");
        NSArray *buzzArray = [NSJSONSerialization JSONObjectWithData:jsonData
                                                             options:NSJSONReadingAllowFragments
                                                               error:nil];
        
        // NSInteger index = 0;
        NSLog(@"remove data.");
        [_buzzData removeAllObjects];
        for (NSDictionary *buzzDictionary in buzzArray) {
            double lat = [buzzDictionary[@"lat"] doubleValue];
            double lot = [buzzDictionary[@"lot"] doubleValue];
            // This check must be done on the server.
            if (lat < _buzzDataNorthEastLat &&
                lat > _buzzDataSouthWestLat &&
                lot < _buzzDataNorthEastLot &&
                lot > _buzzDataSouthWestLot)
            {
                Buzz* buzz = [[Buzz alloc] initWithDictionary:buzzDictionary];
                [_buzzData addObject:buzz];
            }
        }
        NSLog(@"Sorted Buzz Data.");
        return;
    }

    
    /*
     NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:urlRequest
                                       queue:queue
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data,
                                               NSError *error)
     {
         if (error != nil) {
             NSLog(@"Error happend = %@", error);
         }
         else if ([data length] == 0) {
             NSLog(@"Nothing was downloaded.");
         }
         else
         {
             NSString *dataStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
             NSData *jsonData = [dataStr dataUsingEncoding:NSUTF8StringEncoding];
             NSArray *buzzArray = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                  options:NSJSONReadingAllowFragments
                                                                    error:nil];
//             NSInteger index = 0;
             [_currentViewBuzzData removeAllObjects];
             for (NSDictionary *buzzDictionary in buzzArray) {
                 double lat = [buzzDictionary[@"lat"] doubleValue];
                 double lot = [buzzDictionary[@"lot"] doubleValue];
                 // This check must be done on the server.
                 if (lat < _buzzDataNorthEastLat &&
                     lat > _buzzDataSouthWestLat &&
                     lot < _buzzDataNorthEastLot &&
                     lot > _buzzDataSouthWestLot)
                 {
//                     Buzz* buzz = [[Buzz alloc] initWithDictionary:buzzDictionary Index:index];
                     Buzz* buzz = [[Buzz alloc] initWithDictionary:buzzDictionary Index:0];
                     [_buzzData addObject:buzz];
//                     ++index;
                 }
             }
         }
         NSLog(@"fetch data.");
     }];
     */
    
}


- (NSInteger)count
{
    return [_currentViewBuzzData count];
}

@end
