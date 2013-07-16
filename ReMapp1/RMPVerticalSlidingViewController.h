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
/** Returns the view controller that is presented above another view controller. */
@property (nonatomic) UIViewController *topViewController;
/** Returns the view controller that will appear when the top view controller slides to bottom. */
@property (nonatomic) UIViewController *underViewController;
/** Returns the height of the visible part of the top view. */
@property (nonatomic) CGFloat topViewHeightAtMiddlePosition;
/** Returns if the top view is showed */
@property (nonatomic, readonly, getter=isTopViewShowing) BOOL topViewShowing;
/** Returns vertiacal panning gesture for moving the top view. */
- (UIPanGestureRecognizer *)panGesture;

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
