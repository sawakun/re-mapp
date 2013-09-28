//
//  UIImage+_Trim.m
//  ReMapp1
//
//  Created by nishiba on 2013/09/28.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "UIImage+Trim.h"

@implementation UIImage (Trim)
- (UIImage*)trimWithRect:(CGRect)rect
{
    CGImageRef imageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
    UIImage *trimmedImage = [UIImage imageWithCGImage:imageRef];
    CFRelease(imageRef);
    return trimmedImage;
}

+(UIImage*)trim:(UIImage*)image rect:(CGRect)rect
{
    CGImageRef imageRef = CGImageCreateWithImageInRect(image.CGImage, rect);
    UIImage *trimmedImage = [UIImage imageWithCGImage:imageRef];
    CFRelease(imageRef);
    return trimmedImage;
}
@end
