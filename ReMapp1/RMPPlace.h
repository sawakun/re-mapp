//
//  Buzz.h
//  Model
//
//  Created by nishiba on 2013/06/30.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RMPPlaceFactory.h"

@class RMPAnnotation;

@interface RMPPlace : NSObject
@property (nonatomic, readonly) NSInteger buzzId;
@property (nonatomic, readonly) NSInteger userId;
@property (nonatomic, readonly) NSString *userName;
@property (nonatomic, readonly) NSString *userImgURL;
@property (nonatomic, readonly) NSString *buzzBody;
@property (nonatomic, readonly) NSString *buzzImgUrl;
@property (nonatomic, readonly) NSDate *time;
@property (nonatomic, readonly) float lon;
@property (nonatomic, readonly) float lat;
@property (nonatomic, readonly) NSString *buzzType;
@property (nonatomic, readonly, getter = isLiked) BOOL like;
@property (nonatomic, readonly, getter = isMuted) BOOL mute;
@property (nonatomic, readonly) RMPAnnotation* annotation;
@property (nonatomic) NSInteger annotationIndex;
@property (nonatomic, readonly) UIColor *bgColor;
@property (nonatomic) UIImage *buzzImg;
@property (nonatomic) UIImage *userImg;

- (id)initWithDictionary:(NSDictionary *)buzzDictionary;

// For TimeLine
- (CGFloat)heightForTimeLineCell;
+ (NSString *)timeLineCellIdentifier;

// For TimeLineDetail
- (CGFloat)heightForDetailCell;
+ (NSString *)detailCellIdentifier;

- (RMPAnnotation *)createAnnotaion;
- (UIColor *)backgroundColor;

- (NSString *)placeViewNibName;
// For PlaceView
//+ (NSString *)placeViewCellIdentifier;
@end


