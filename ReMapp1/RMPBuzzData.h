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
extern NSString *const RMPBuzzDataReloaded;


@interface RMPBuzzData : NSObject
{
@private
    NSMutableArray *_currentViewBuzzData;
    NSMutableArray *_buzzData;
    double _buzzDataNorthEastLat;
    double _buzzDataNorthEastLot;
    double _buzzDataSouthWestLat;
    double _buzzDataSouthWestLot;
    double _urlRequestNorthEastLat;
    double _urlRequestNorthEastLot;
    double _urlRequestSouthWestLat;
    double _urlRequestSouthWestLot;
    double _widthCurrentView;
    dispatch_queue_t _queue;
}

// return the number of buzzes
@property (nonatomic, readonly) NSInteger count;
@property (atomic, readonly) NSMutableArray *buzzes;

+(RMPBuzzData*)sharedManager;

- (void)reloadWithNorthEastLat:(double)northEastLat
                  NorthEastLot:(double)northEastLot
                  SouthWestLat:(double)southWestLat
                  SouthWestLot:(double)southWestLot;
- (RMPBuzzPlace *)buzzAtIndex:(NSInteger)index;
@end
