//
//  RMPUIImageEffect.h
//  ReMapp1
//
//  Created by nishiba on 2013/09/29.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RMPImageEffect : NSObject
+ (UIImage *) imageWithView:(UIView *)view;
+ (UIImage *) monochromeImageWithImage:(UIImage *)originalImage;

@end
