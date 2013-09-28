//
//  UIImage+_Trim.h
//  ReMapp1
//
//  Created by nishiba on 2013/09/28.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Trim)
-(UIImage*)trimWithRect:(CGRect)rect;
+(UIImage*)trim:(UIImage*)image rect:(CGRect)rect;
@end
