//
//  RMPImageView.h
//  ReMapp1
//
//  Created by Masahiro Nishiba on 2013/07/27.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RMPLazyImageView : UIImageView
@property (nonatomic) UIImage *image;
@property (nonatomic) NSURL *imageURL;
-(void)loadImageWithURL:(NSURL *)imageURL;
@end
