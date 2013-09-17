//
//  BuzzData.m
//  Model
//
//  Created by nishiba on 2013/06/30.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "RMPMapPlaceData.h"
#import "RMPPlace.h"
#import "RMPMapView.h"
#import "RMPPlaceFactory.h"
#import "RMPPlaceData+protected.h"

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
    if (self.northEastLat < squareLonLat.northEastLat &&
        self.southWestLat > squareLonLat.southWestLat &&
        self.northEastLon < squareLonLat.northEastLon &&
        self.southWestLon > squareLonLat.southWestLon) {
        return YES;
    }
    return NO;
}

@end

@interface RMPMapPlaceData()
@end

@implementation RMPMapPlaceData


+(RMPMapPlaceData*)sharedManager
{
    static RMPMapPlaceData *sharedBuzzData;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedBuzzData = [[RMPMapPlaceData alloc] initSharedInstance];
    });
    return sharedBuzzData;
}

- (id)initSharedInstance
{
    self = [super init];
    if (self) {
        _currentViewBuzzData = [[NSMutableArray alloc] init];
        _buzzDataLonLat = [[RMPSquareLonLat alloc] init];
        _urlRequestLonLat = [[RMPSquareLonLat alloc] init];
        _widthCurrentView = 0.0;
        _queue = dispatch_queue_create("com.re-mapp", DISPATCH_QUEUE_SERIAL);
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(reloadWithNotification:)
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



- (void)reloadWithNotification:(NSNotification *)center
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
        (thisLonLat.northEastLon - thisLonLat.southWestLon) != _widthCurrentView)
    {
        
        NSLog(@"Case 1");
        [NSURLConnection cancelPreviousPerformRequestsWithTarget:self];
        [self fetchBuzzDataWithSquareLonLat:thisLonLat completionHandler:^(){
            [self setCurrentBuzzDataWithSquareLonLat:thisLonLat];
        }];
        return;
    }

    if (![thisLonLat isIn:_urlRequestLonLat])
    {
        NSLog(@"Case 2");
        [self setCurrentBuzzDataWithSquareLonLat:thisLonLat];
        [self fetchBuzzDataWithSquareLonLat:thisLonLat completionHandler:nil];
        return;
    }
    
    NSLog(@"Case 3");
    [self setCurrentBuzzDataWithSquareLonLat:thisLonLat];
    return;
}



- (void)setCurrentBuzzDataWithSquareLonLat:(RMPSquareLonLat *)thisSquare
{
    
    NSInteger index = 0;
    [_currentViewBuzzData removeAllObjects];
    for (RMPPlace *place in self.places) {
        if (place.lat < thisSquare.northEastLat &&
            place.lat > thisSquare.southWestLat &&
            place.lon < thisSquare.northEastLon &&
            place.lon > thisSquare.southWestLon)
        {
            place.annotationIndex = index;
            [_currentViewBuzzData addObject:place];
            ++index;
        }
    }

    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:RMPBuzzMapDataReloaded object:self userInfo:nil];
    });
}

- (void)fetchBuzzDataWithSquareLonLat:(RMPSquareLonLat *)thisSquare completionHandler:(void (^)())handler
{
    double heigthLat = thisSquare.northEastLat - thisSquare.southWestLat;
    double widthLot = thisSquare.northEastLon - thisSquare.southWestLon;
    
    // set current map data
    CGFloat lat = 0.5 * (thisSquare.northEastLat + thisSquare.southWestLat);
    CGFloat lon = 0.5 * (thisSquare.northEastLon + thisSquare.southWestLon);
    CGFloat rad = 3.0 * (heigthLat / 2.0);
    NSDictionary *placeConditions = @{ @"lat":@(lat), @"lon":@(lon), @"rad":@(rad)};
    
    [self fetchPlaceDataWithConditions:placeConditions completionHandler:^(){
        // set new _buzzDataNorthEastLat
        _buzzDataLonLat.northEastLat = thisSquare.northEastLat + 2 * heigthLat;
        _buzzDataLonLat.northEastLon = thisSquare.northEastLon + 2 * widthLot;
        _buzzDataLonLat.southWestLat = thisSquare.southWestLat - 2 * heigthLat;
        _buzzDataLonLat.southWestLon = thisSquare.southWestLon - 2 * widthLot;
        _urlRequestLonLat.northEastLat = thisSquare.northEastLat + heigthLat;
        _urlRequestLonLat.northEastLon = thisSquare.northEastLon + widthLot;
        _urlRequestLonLat.southWestLat = thisSquare.southWestLat - heigthLat;
        _urlRequestLonLat.southWestLon = thisSquare.southWestLon - widthLot;
        _widthCurrentView = widthLot;
        if (handler) handler();
    }];
}

- (NSInteger)count
{
    return [_currentViewBuzzData count];
}

- (RMPPlace *)placeAtIndex:(NSInteger)index
{
    if (index >= [_currentViewBuzzData count] || _currentViewBuzzData == nil) {
        return nil;
    }
    return [_currentViewBuzzData objectAtIndex:index];
}

- (NSMutableArray*)annotations
{
    NSMutableArray *thisAnnotations = [NSMutableArray array];
    for (RMPPlace *place in _currentViewBuzzData)
    {
        [thisAnnotations addObject:place.annotation];
    }
    return thisAnnotations;
}

@end
