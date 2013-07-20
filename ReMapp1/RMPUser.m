//
//  RMPUser.m
//  ReMapp1
//
//  Created by nishiba on 2013/07/18.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "RMPUser.h"

@interface RMPUser()
@property (nonatomic) NSString* systemId;
@property (nonatomic) NSString* name;
@property (nonatomic) UIImage* icon;
@property (nonatomic) NSString* profile;
@end

@implementation RMPUser
+ (RMPUser*)sharedManager
{
    static RMPUser *sharedRMPUser;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedRMPUser = [[RMPUser alloc] initSharedInstance];
    });
    return sharedRMPUser;
}

- (id)initSharedInstance
{
    self = [super init];
    if (self) {
        self.systemId = @"asdfghjkl";
        self.name = @"nishiba";
        
        NSURL *imageURL = [NSURL URLWithString:@"https://fbcdn-profile-a.akamaihd.net/hprofile-ak-prn1/161869_715062914_374717427_q.jpg"];
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        self.icon = [UIImage imageWithData:imageData];
        
        self.profile = @"I'm a banker.";
    }
    return self;
}

- (id)init
{
    [self doesNotRecognizeSelector:_cmd];
    return self;
}
@end
