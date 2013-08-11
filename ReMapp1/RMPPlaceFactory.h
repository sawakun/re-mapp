//
//  RMPPlaceFactory.h
//  ReMapp1
//
//  Created by nishiba on 2013/08/02.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RMPPlace;


@interface RMPPlaceFactory : NSObject
+ (RMPPlace *)createPlace:(NSDictionary *)buzzDictionary;
@end
