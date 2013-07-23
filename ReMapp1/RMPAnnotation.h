//
//  RMPAnnotation.h
//  ReMapp1
//
//  Created by nishiba on 2013/07/17.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface RMPAnnotation : MKPointAnnotation
@property (nonatomic) UIImage *pinImage;
@property (nonatomic) NSString *identifier;
@property (nonatomic) CGPoint centerOffset;
@property (nonatomic) NSInteger index;
@end

@interface RMPBuzzAnnotation : RMPAnnotation
@property (nonatomic) UIImage *pinImage;
@property (nonatomic) NSString *identifier;
@property (nonatomic) CGPoint centerOffset;
@property (nonatomic) NSInteger index;
@end

@interface RMPPlayAnnotation : RMPAnnotation
@property (nonatomic) UIImage *pinImage;
@property (nonatomic) NSString *identifier;
@property (nonatomic) CGPoint centerOffset;
@property (nonatomic) NSInteger index;
@end

@interface RMPWriteFormAnnotation : RMPAnnotation
@property (nonatomic) UIImage *pinImage;
@property (nonatomic) NSString *identifier;
@property (nonatomic) CGPoint centerOffset;
@property (nonatomic) NSInteger index;
@property (nonatomic) CGPoint tapPointOffset;
@end

@interface RMPSelectedAnnotation : RMPAnnotation
@property (nonatomic) UIImage *pinImage;
@property (nonatomic) NSString *identifier;
@property (nonatomic) CGPoint centerOffset;
@property (nonatomic) NSInteger index;
@end
