//
//  RMPFixedPlace.m
//  ReMapp1
//
//  Created by nishiba on 2013/09/18.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "RMPFixedPlace.h"

@interface RMPFixedPlace()
@property (nonatomic) NSString *address;
@property (nonatomic) NSString *phoneNumber;
@property (nonatomic) NSString *siteURL;
@end

@implementation RMPFixedPlace

- (id)initWithDictionary:(NSDictionary *)buzzDictionary
{
    self = [super initWithDictionary:buzzDictionary];
    if (self && buzzDictionary) {
        self.address        = buzzDictionary[@"address"];
        self.phoneNumber    = buzzDictionary[@"phone_number"];
        self.siteURL        = buzzDictionary[@"site_url"];
    }
    
    return self;
}

@end
