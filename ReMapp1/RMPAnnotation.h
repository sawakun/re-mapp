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
@property (nonatomic) UIImage *selectedPinImage;
@property (nonatomic) CGPoint centerOffset;
@property (nonatomic) CGPoint selectedCenterOffset;
@property (nonatomic) CGPoint additionalCenterOffset;
@property (nonatomic) NSString *identifier;
@property (nonatomic) NSInteger index;
@end



@interface RMPBuzzAnnotation : RMPAnnotation
@end

@interface RMPPlayAnnotation : RMPAnnotation
@end

@interface RMPShopAnnotation : RMPAnnotation
@end

@interface RMPEatAnnotation : RMPAnnotation
@end


@interface RMPWriteFormAnnotation : RMPAnnotation
@property (nonatomic) CGPoint tapPointOffset;
@end

