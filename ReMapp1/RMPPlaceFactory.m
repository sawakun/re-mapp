//
//  RMPPlaceFactory.m
//  ReMapp1
//
//  Created by nishiba on 2013/08/02.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "RMPPlaceFactory.h"
#import "RMPAnnotation.h"
#import "RMPPlaceAll.h"


@implementation RMPPlaceFactory
+(RMPPlace*)createPlace:(NSDictionary *)buzzDictionary
{
    NSString *thisType = buzzDictionary[@"buzz_type"];
    if ([thisType isEqualToString:@"buzz"]) {
        return [[RMPBuzzPlace alloc] initWithDictionary:buzzDictionary];
    }
    else if ([thisType isEqualToString:@"play"]) {
        return [[RMPPlayPlace alloc] initWithDictionary:buzzDictionary];
    }
    else if ([thisType isEqualToString:@"shop"]) {
        return [[RMPShopPlace alloc] initWithDictionary:buzzDictionary];
    }
    else if ([thisType isEqualToString:@"eat"]) {
        return [[RMPEatPlace alloc] initWithDictionary:buzzDictionary];
    }
    return nil;
}
@end
