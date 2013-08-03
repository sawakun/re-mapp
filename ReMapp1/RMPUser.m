//
//  RMPUser.m
//  ReMapp1
//
//  Created by nishiba on 2013/07/18.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "RMPUser.h"

@interface RMPUser()
@property (nonatomic) NSInteger systemId;
@property (nonatomic) UIImage* iconImage;
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
        self.systemId = 124;
        self.name = @"nishiba";
        self.email = @"nishiba.m@gmail.com";
        
        NSURL *imageURL = [NSURL URLWithString:@"https://fbcdn-profile-a.akamaihd.net/hprofile-ak-prn1/161869_715062914_374717427_q.jpg"];
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        self.iconImage = [UIImage imageWithData:imageData];
        
        self.profile = @"A user profile is a visual display of personal data associated with a specific user, or a customized desktop environment. A profile refers therefore to the explicit digital representation of a person's identity. A user profile can also be considered as the computer representation of a user model.";
    }
    return self;
}

- (id)init
{
    [self doesNotRecognizeSelector:_cmd];
    return self;
}
@end
