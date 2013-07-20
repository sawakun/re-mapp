//
//  RMPVerticalSlidingViewController.h
//  VerticalSlidingViewController
//
//  Created by Masahiro Nishiba on 2013/07/15.
//  Copyright (c) 2013年 Masahiro Nishiba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

/** Notification that gets posted when the top view moved */
extern NSString *const RMPVerticalSlidingViewTopDidMove;

@interface RMPVerticalSlidingViewController : UIViewController
/** Returns the view controller that is presented above underViewController and will appear from bottom. */
@property (nonatomic) UIViewController *bottomViewController;
/** Returns the view controller that will appear when the top view controller slides to bottom. */
@property (nonatomic) UIViewController *underViewController;
/** Returns the height of the visible part of the bottomView. */
@property (nonatomic) CGFloat bottomViewHeightAtMiddlePosition;
/** Returns if the top view is showed */
@property (nonatomic, readonly, getter=isTopViewShowing) BOOL topViewShowing;

/** RMPSide of screen */
typedef enum {
    RMPTop,
    RMPBottom,
    RMPMiddle
} RMPSide;
//** Slide the top view to RMPSide */
- (void)anchorTopViewTo:(RMPSide)side;

@end


@interface UIViewController(RMPVerticalSlidingViewExtension)
- (RMPVerticalSlidingViewController *) rmp_verticalSlidingViewController;
@end
