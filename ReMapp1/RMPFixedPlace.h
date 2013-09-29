//
//  RMPFixedPlace.h
//  ReMapp1
//
//  Created by nishiba on 2013/09/18.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "RMPPlace.h"

@interface RMPFixedPlace : RMPPlace
@property (nonatomic, readonly) NSString *address;
@property (nonatomic, readonly) NSString *phoneNumber;
@property (nonatomic, readonly) NSString *siteURL;
@end
