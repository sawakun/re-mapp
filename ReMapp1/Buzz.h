//
//  Buzz.h
//  Model
//
//  Created by nishiba on 2013/06/30.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RMPBuzzAnnotation;


@interface Buzz : NSObject

@property (nonatomic, readonly) NSString *buzzId;
@property (nonatomic, readonly) NSString *userId;
@property (nonatomic, readonly) NSString *userName;
@property (nonatomic, readonly) NSString *iconURL;
@property (nonatomic) UIImage *iconImage;
@property (nonatomic, readonly) NSString *text;
@property (nonatomic, readonly) NSString *imageURL;
@property (nonatomic, readonly) UIImage *image;
@property (nonatomic, readonly) NSString *date;
@property (nonatomic, readonly) float lot;
@property (nonatomic, readonly) float lat;
@property (nonatomic, readonly) RMPBuzzAnnotation* annotation;
@property (nonatomic) NSInteger annotationIndex;



- (id)initWithBuzz:(NSDictionary *)buzz Index:(NSInteger)index;
- (id)initWithDictionary:(NSDictionary *)buzz;
@end
