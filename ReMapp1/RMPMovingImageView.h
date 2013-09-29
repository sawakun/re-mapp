//
//  RMPMovingImageView.h
//  ReMapp1
//
//  Created by Masahiro Nishiba on 2013/09/29.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface RMPMovingImageView : UIImageView
@property CGPoint centerOffset;
-(void)moveToPosition:(CGPoint)position;
@end
