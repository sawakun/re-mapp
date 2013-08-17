//
//  BuzzData.h
//  Model
//
//  Created by nishiba on 2013/06/30.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "RMPPlaceData.h"

@class RMPBuzzPlace;

/** Notification that gets posted when the buzz date are reloaded. */
extern NSString *const RMPBuzzMapDataReloaded;



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

@interface RMPMapPlaceData : RMPPlaceData
{
@private
    NSMutableArray *_currentViewBuzzData;
    RMPSquareLonLat *_buzzDataLonLat;
    RMPSquareLonLat *_urlRequestLonLat;
    double _widthCurrentView;
    dispatch_queue_t _queue;
}

@property (nonatomic, readonly) NSMutableArray *annotations;
+(RMPMapPlaceData*)sharedManager;

@end
