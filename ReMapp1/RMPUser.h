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
@property (nonatomic, readonly) NSString* systemId;
@property (nonatomic, readonly) NSString* name;
@property (nonatomic, readonly) UIImage* icon;
@property (nonatomic, readonly) NSString* profile;
@end
