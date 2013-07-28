//
//  RMPImageView.m
//  ReMapp1
//
//  Created by Masahiro Nishiba on 2013/07/27.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "RMPLazyImageView.h"

@implementation RMPLazyImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.image = nil;
        self.imageURL = nil;
    }
    return self;
}

-(void)loadImageWithURL:(NSURL *)imageURL
{
    if (self.image == nil || self.imageURL != imageURL) {
        self.imageURL = imageURL;
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(queue, ^{
            NSData *imageData = [NSData dataWithContentsOfURL:self.imageURL];
            self.image = [UIImage imageWithData:imageData];
        });
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
