//
//  RMPAnnotation.h
//  ReMapp1
//
//  Created by nishiba on 2013/07/17.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface RMPAnnotationData : MKPointAnnotation
@property (nonatomic) UIImage *pinImage;
@property (nonatomic) NSString *identifier;
@property (nonatomic) CGPoint centerOffset;
@property (nonatomic) NSInteger index;
@end

@class RMPSelectedAnnotation;
@interface RMPAnnotation : RMPAnnotationData
- (RMPSelectedAnnotation *)createSelectedAnnotation;
@end

@interface RMPSelectedAnnotation : RMPAnnotationData
- (RMPAnnotation *)createAnnotation;
@end


@interface RMPBuzzAnnotation : RMPAnnotation
@end

@interface RMPPlayAnnotation : RMPAnnotation
@end

@interface RMPShopAnnotation : RMPAnnotation
@end

@interface RMPEatAnnotation : RMPAnnotation
@end

@interface RMPSelectedBuzzAnnotation : RMPSelectedAnnotation
@end

@interface RMPSelectedPlayAnnotation : RMPSelectedAnnotation
@end

@interface RMPSelectedShopAnnotation : RMPSelectedAnnotation
@end

@interface RMPSelectedEatAnnotation : RMPSelectedAnnotation
@end

@interface RMPWriteFormAnnotation : RMPAnnotation
@property (nonatomic) CGPoint tapPointOffset;
@end

