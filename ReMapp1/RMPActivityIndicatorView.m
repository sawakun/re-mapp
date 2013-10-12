//
//  RMPActivityIndicatorView.m
//  ReMapp1
//
//  Created by nishiba on 2013/10/06.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "RMPActivityIndicatorView.h"
#import <QuartzCore/QuartzCore.h>

@implementation RMPActivityIndicatorView

+ (id)createWithOwner:(id)owner
{
    RMPActivityIndicatorView *view = [[[NSBundle mainBundle] loadNibNamed:@"RMPActivityIndicatorView" owner:owner options:nil] objectAtIndex:0];
    [view.layer setCornerRadius:10.0];
    [view setClipsToBounds:YES];
    [view.activityIndicatorView setHidesWhenStopped:YES];
    view.hidden = YES;
    return view;
}

- (void)startAnimating
{
    self.hidden = NO;
    [self.activityIndicatorView startAnimating];
}

- (void)stopAnimating
{
    self.hidden = YES;
    [self.activityIndicatorView stopAnimating];
}

- (void)moveCenterInView:(UIView*)view
{
    CGPoint center;
    center.x = view.frame.size.width * 0.5;
    center.y = view.frame.size.height * 0.5;
    self.layer.position = center;
}

-(void)doTask:(bool(^)(void))task competion:(void(^)(bool))comletion
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self startAnimating];
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        bool result = task();
        dispatch_async(dispatch_get_main_queue(), ^{
            [self stopAnimating];
            comletion(result);
        });
    });
}

@end

