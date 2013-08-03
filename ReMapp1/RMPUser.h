//
//  RMPUser.h
//  ReMapp1
//
//  Created by nishiba on 2013/07/18.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RMPUser : NSObject
+ (RMPUser*)sharedManager;
@property (nonatomic, readonly) NSInteger systemId;
@property (nonatomic) NSString *name;
@property (nonatomic, readonly) UIImage *iconImage;
@property (nonatomic) NSString *email;
@property (nonatomic) NSString *profile;
@end
