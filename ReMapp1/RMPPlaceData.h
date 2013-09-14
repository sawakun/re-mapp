//
//  RMPBuzzListData.h
//  ReMapp1
//
//  Created by nishiba on 2013/08/11.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import <Foundation/Foundation.h>

/** Notification that gets posted when the place data are reloaded. */
extern NSString *const RMPPlaceDataReloaded;

@class RMPPlace;

@interface RMPPlaceData : NSObject
@property (nonatomic, readonly) NSInteger count;
- (RMPPlace *)placeAtIndex:(NSInteger)index;
//- (void)reload;
@end


@interface RMPMutePlaceData : RMPPlaceData
- (BOOL)availableForPlace:(RMPPlace*)place;
@end

@interface RMPCheckPlaceData : RMPPlaceData
- (BOOL)availableForPlace:(RMPPlace*)place;
@end

@interface RMPYourTimePlaceData : RMPPlaceData
- (BOOL)availableForPlace:(RMPPlace*)place;
@end

