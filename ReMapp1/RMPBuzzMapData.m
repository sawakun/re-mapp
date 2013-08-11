//
//  BuzzData.m
//  Model
//
//  Created by nishiba on 2013/06/30.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "RMPBuzzMapData.h"
#import "RMPPlace.h"
#import "CSVHandler.h"
#import "RMPMapView.h"
#import "RMPPlaceFactory.h"

NSString *const RMPBuzzMapDataReloaded = @"RMPBuzzMapDataReloaded";


@implementation RMPSquareLonLat
- (id)init
{
    self = [super init];
    if (self) {
        self.northEastLon = 0;
        self.northEastLat = 0;
        self.southWestLon = 0;
        self.southWestLat = 0;
    }
    
    return self;
}

- (id)initWithNorthEastLon:(CGFloat)nelon
              NorthEastLat:(CGFloat)nelat
              SouthWestLon:(CGFloat)swlon
              SouthWestLat:(CGFloat)swlat
{
    self = [super init];
    if (self) {
        self.northEastLon = nelon;
        self.northEastLat = nelat;
        self.southWestLon = swlon;
        self.southWestLat = swlat;
    }
    
    return self;
}

- (BOOL)isIn:(RMPSquareLonLat *)squareLonLat
{
    if (self.northEastLat > squareLonLat.northEastLat &&
        self.southWestLat < squareLonLat.southWestLat &&
        self.northEastLon > squareLonLat.northEastLon &&
        self.southWestLon < squareLonLat.southWestLon)
    {
        return YES;
    }
    return NO;
}

@end

@interface RMPBuzzMapData()
@end

@implementation RMPBuzzMapData
@synthesize buzzes = _currentViewBuzzData;


+(RMPBuzzMapData*)sharedManager
{
    static RMPBuzzMapData *sharedBuzzData;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedBuzzData = [[RMPBuzzMapData alloc] initSharedInstance];
    });
    return sharedBuzzData;
}

- (id)initSharedInstance
{
    self = [super init];
    if (self) {
        _currentViewBuzzData = [[NSMutableArray alloc] init];
        _buzzData = [[NSMutableArray alloc] init];
        _buzzDataLonLat = [[RMPSquareLonLat alloc] init];
        _urlRequestLonLat = [[RMPSquareLonLat alloc] init];
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



- (RMPBuzzPlace *)buzzAtIndex:(NSInteger)index
{
    if (index >= [_currentViewBuzzData count] || _currentViewBuzzData == nil) {
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
    dispatch_async(_queue, ^{
        [self reloadWithNorthEastLat:northEastLat NorthEastLot:northEastLot SouthWestLat:southWestLat SouthWestLot:southWestLot];
    });
}

- (void)reloadWithNorthEastLat:(CGFloat)northEastLat
                  NorthEastLot:(CGFloat)northEastLon
                  SouthWestLat:(CGFloat)southWestLat
                  SouthWestLot:(CGFloat)southWestLon
{
    RMPSquareLonLat *thisLonLat = [[RMPSquareLonLat alloc] initWithNorthEastLon:northEastLon
                                                               NorthEastLat:northEastLat
                                                               SouthWestLon:southWestLon
                                                               SouthWestLat:southWestLat];
    

    if (![thisLonLat isIn:_buzzDataLonLat] ||
        (thisLonLat.northEastLon- thisLonLat.southWestLon) != _widthCurrentView) {
        [NSURLConnection cancelPreviousPerformRequestsWithTarget:self];
        [self fetchBuzzDataWithSquareLonLat:thisLonLat];
        [self setCurrentBuzzDataWithSquareLonLat:thisLonLat];
        return;
    }
    
    if (![thisLonLat isIn:_urlRequestLonLat])
    {
        [self setCurrentBuzzDataWithSquareLonLat:thisLonLat];
        [self fetchBuzzDataWithSquareLonLat:thisLonLat];
        return;
    }

    [self setCurrentBuzzDataWithSquareLonLat:thisLonLat];
    return;
}



- (void)setCurrentBuzzDataWithSquareLonLat:(RMPSquareLonLat *)thisSquare
{
    
    NSInteger index = 0;
    [_currentViewBuzzData removeAllObjects];
    for (RMPPlace *buzz in _buzzData) {
        if (buzz.lat < thisSquare.northEastLat &&
            buzz.lat > thisSquare.southWestLat &&
            buzz.lot < thisSquare.northEastLon &&
            buzz.lot > thisSquare.southWestLon)
        {
            buzz.annotationIndex = index;
            [_currentViewBuzzData addObject:buzz];
            ++index;
        }
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:RMPBuzzMapDataReloaded object:self userInfo:nil];
    });
}

- (void)fetchBuzzDataWithSquareLonLat:(RMPSquareLonLat *)thisSquare
{
    // set new _buzzDataNorthEastLat...
    double widthLot = thisSquare.northEastLon - thisSquare.southWestLon;
    double heigthLat = thisSquare.northEastLat - thisSquare.southWestLat;
    _buzzDataLonLat.northEastLat = thisSquare.northEastLat + 2 * heigthLat;
    _buzzDataLonLat.northEastLon = thisSquare.northEastLon + 2 * widthLot;
    _buzzDataLonLat.southWestLat = thisSquare.southWestLat - 2 * heigthLat;
    _buzzDataLonLat.southWestLon = thisSquare.southWestLon - 2 * widthLot;
    _urlRequestLonLat.northEastLat = thisSquare.northEastLat + heigthLat;
    _urlRequestLonLat.northEastLon = thisSquare.northEastLon + widthLot;
    _urlRequestLonLat.southWestLat = thisSquare.southWestLat - heigthLat;
    _urlRequestLonLat.southWestLon = thisSquare.southWestLon - widthLot;
    _widthCurrentView = widthLot;
    
    
    //json
    NSString *urlStr = @"http://sky.geocities.jp/nishiba_m/buzz.json.js";
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30.0f];
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
    else
    {
        NSString *dataStr = [[NSString alloc] initWithData:data encoding:NSShiftJISStringEncoding];
        NSData *jsonData = [dataStr dataUsingEncoding:NSUTF8StringEncoding];
        NSArray *buzzArray = [NSJSONSerialization JSONObjectWithData:jsonData
                                                             options:NSJSONReadingAllowFragments
                                                               error:nil];
        
        // NSInteger index = 0;
        [_buzzData removeAllObjects];
        for (NSDictionary *buzzDictionary in buzzArray) {
            double lat = [buzzDictionary[@"lat"] doubleValue];
            double lot = [buzzDictionary[@"lot"] doubleValue];
            // This check must be done on the server.
            if (lat < _buzzDataLonLat.northEastLat &&
                lat > _buzzDataLonLat.southWestLat &&
                lot < _buzzDataLonLat.northEastLon &&
                lot > _buzzDataLonLat.southWestLon)
            {
                RMPPlace *place = [RMPPlaceFactory createPlace:buzzDictionary];
                [_buzzData addObject:place];
            }
        }
        return;
    }

}


- (NSInteger)count
{
    return [_currentViewBuzzData count];
}

@end
