//
//  RMPPlaceData_protected.h
//  ReMapp1
//
//  Created by nishiba on 2013/08/16.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "RMPPlaceData.h"

@interface RMPPlaceData(protected)
@property (nonatomic, readonly) NSMutableArray *places;
- (void)fetchNewDataWithConditions:(NSDictionary *)conditions;
- (BOOL)availableForPlace:(RMPPlace*)place;
@end
