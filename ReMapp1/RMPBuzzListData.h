//
//  RMPBuzzListData.h
//  ReMapp1
//
//  Created by nishiba on 2013/08/11.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import <Foundation/Foundation.h>

/** Notification that gets posted when the buzz date are reloaded. */
extern NSString *const RMPBuzzListDataReloaded;

@interface RMPBuzzListData : NSObject
@property (nonatomic, readonly) NSInteger count;
@property (atomic, readonly) NSMutableArray *buzzes;
@end


