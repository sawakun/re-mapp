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
@property (nonatomic, readonly) NSString *buzzId;
@property (nonatomic, readonly) NSInteger userId;
@property (nonatomic, readonly) NSString *userName;
@property (nonatomic, readonly) NSString *iconURL;
@property (nonatomic) UIImage *iconImage;
@property (nonatomic, readonly) NSString *text;
@property (nonatomic, readonly) NSString *imageURL;
@property (nonatomic) UIImage *image;
@property (nonatomic, readonly) NSDate *date;
@property (nonatomic, readonly) float lot;
@property (nonatomic, readonly) float lat;
@property (nonatomic, readonly) NSString *buzz_type;
@property (nonatomic, readonly, getter = isLiked) BOOL like;
@property (nonatomic, readonly, getter = isMuted) BOOL mute;
@property (nonatomic, readonly) RMPAnnotation* annotation;
@property (nonatomic) NSInteger annotationIndex;

- (id)initWithDictionary:(NSDictionary *)buzzDictionary;

// For TimeLine
- (CGFloat)heightForTimeLineCell;
+ (NSString *)timeLineCellIdentifier;

// For TimeLineDetail
- (CGFloat)heightForDetailCell;
+ (NSString *)detailCellIdentifier;

// For PlaceView
//+ (NSString *)placeViewCellIdentifier;
@end



@interface RMPBuzzPlace : RMPPlace
@end

@interface RMPPlayPlace : RMPPlace
@end

@interface RMPShopPlace : RMPPlace
@end

@interface RMPEatPlace : RMPPlace
@end

