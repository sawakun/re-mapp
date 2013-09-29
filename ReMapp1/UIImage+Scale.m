//
//  UIImage+_Scale.m
//  ReMapp1
//
//  Created by nishiba on 2013/09/28.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "UIImage+Scale.h"

@implementation UIImage (Scale)
+ (UIImage *)imageWithImage:(UIImage *)image scale:(CGFloat)scale;
{
    CGSize newSize = CGSizeMake(image.size.width*scale, image.size.height*scale);
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
@end
