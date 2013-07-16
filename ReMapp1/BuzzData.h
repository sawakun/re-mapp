//
//  BuzzData.h
//  Model
//
//  Created by nishiba on 2013/06/30.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@class Buzz;

@interface BuzzData : NSObject
{
@private
    NSMutableArray *_buzzes;
}
// return the number of buzzes
@property (nonatomic, readonly) NSInteger count;
@property (nonatomic, readonly) NSMutableArray *buzzes;

+(BuzzData*)sharedManager;

- (void) reloadWithNorthEastCordinate:(CLLocationCoordinate2D)northEastCordinate
                  SouthWestCoordinate:(CLLocationCoordinate2D)southWestCoordinate;
- (Buzz *)buzzAtIndex:(NSInteger)index;
- (void)reload;
@end
