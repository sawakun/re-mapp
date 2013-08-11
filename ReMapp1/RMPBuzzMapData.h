//
//  BuzzData.h
//  Model
//
//  Created by nishiba on 2013/06/30.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@class RMPBuzzPlace;

/** Notification that gets posted when the buzz date are reloaded. */
extern NSString *const RMPBuzzMapDataReloaded;


/*
 double northEastLot = [center.userInfo[@"northEastLot"] doubleValue];
 double southWestLat = [center.userInfo[@"southWestLat"] doubleValue];
 double southWestLot = [center.userInfo[@"southWestLot"] doubleValue];

 */
// keep lon & lat for rectangle area
@interface RMPSquareLonLat : NSObject
@property (nonatomic) CGFloat northEastLon;
@property (nonatomic) CGFloat northEastLat;
@property (nonatomic) CGFloat southWestLon;
@property (nonatomic) CGFloat southWestLat;
- (id)initWithNorthEastLon:(CGFloat)nelon
              NorthEastLat:(CGFloat)nelat
              SouthWestLon:(CGFloat)swlon
              SouthWestLat:(CGFloat)swlat;
- (BOOL)isIn:(RMPSquareLonLat *)squareLonLat;
@end

@interface RMPBuzzMapData : NSObject
{
@private
    NSMutableArray *_currentViewBuzzData;
    NSMutableArray *_buzzData;
    RMPSquareLonLat *_buzzDataLonLat;
    RMPSquareLonLat *_urlRequestLonLat;
    double _widthCurrentView;
    dispatch_queue_t _queue;
}

// return the number of buzzes
@property (nonatomic, readonly) NSInteger count;
@property (atomic, readonly) NSMutableArray *buzzes;

+(RMPBuzzMapData*)sharedManager;

- (void)reloadWithNorthEastLat:(CGFloat)northEastLat
                  NorthEastLot:(CGFloat)northEastLon
                  SouthWestLat:(CGFloat)southWestLat
                  SouthWestLot:(CGFloat)southWestLon;
- (RMPBuzzPlace *)buzzAtIndex:(NSInteger)index;
@end
