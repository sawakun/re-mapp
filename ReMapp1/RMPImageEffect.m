//
//  RMPUIImageEffect.m
//  ReMapp1
//
//  Created by nishiba on 2013/09/29.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "RMPImageEffect.h"

@implementation RMPImageEffect

+ (UIImage *) imageWithView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}

+ (UIImage *) monochromeImageWithImage:(UIImage *)originalImage
{
    // trandform UIImage to CIImage
    CIImage *filteredImage = [[CIImage alloc] initWithCGImage:originalImage.CGImage];
    
    // make CIFilter for monochrome
    CIFilter *filter = [CIFilter filterWithName:@"CIMinimumComponent"];
    [filter setValue:filteredImage forKey:@"inputImage"];
    
    // get fileted image
    filteredImage = filter.outputImage;
    
    // transform CIImage to UIImage
    CIContext *ciContext = [CIContext contextWithOptions:nil];
    CGImageRef imageRef = [ciContext createCGImage:filteredImage fromRect:[filteredImage extent]];
    UIImage *outputImage  = [UIImage imageWithCGImage:imageRef scale:1.0f orientation:UIImageOrientationUp];
    CGImageRelease(imageRef);
    
    return outputImage;
}
@end
