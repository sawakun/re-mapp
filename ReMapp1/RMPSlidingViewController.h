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

@interface RMPSlidingViewController : UIViewController
/** Returns the view controller that is presented above underViewController and will appear from bottom. */
@property (nonatomic) UIViewController *bottomViewController;

/** Returns the view controller that will appear when the top view controller slides to bottom. */
@property (nonatomic) UIViewController *underViewController;
/** Returns the height of the visible part of the bottomView. */
@property (nonatomic) CGFloat bottomViewHeightAtMiddlePosition;

/** Returns the number of points the underView is visible when the rightView is anchored to the left side. */
@property (nonatomic) CGFloat anchorRightPeekAmount;
/** Returns the number of points the underView is visible when the leftView is anchored to the right side. */
@property (nonatomic) CGFloat anchorLeftPeekAmount;
/** Returns the view controller that is presented above underViewController and will appear from left. */
@property (nonatomic) UIViewController *leftViewController;
/** Returns the view controller that is presented above underViewController and will appear from right. */
@property (nonatomic) UIViewController *rightViewController;

/** Returns horizontal panning gesture for moving the right view. */
@property (nonatomic, readonly) UIPanGestureRecognizer *rightPanGesture;
/** Returns horizontal panning gesture for moving the left view. */
@property (nonatomic, readonly) UIPanGestureRecognizer *leftPanGesture;

/** RMPSide of screen */
typedef enum {
    RMPTop,
    RMPBottom,
    RMPMiddle,
    RMPRight,
    RMPLeft
} RMPSide;

//** Slide the top view to RMPSide */
- (void)anchorBottomViewTo:(RMPSide)side;
//** Slide the right view to RMPSide */
- (void)anchorRightViewTo:(RMPSide)side;
//** Slide the left view to RMPSide */
- (void)anchorLeftViewTo:(RMPSide)side;


/** Returns if the top view is showed */
- (BOOL)isBottomViewShowing;
/** Returns if the right view is showed */
- (BOOL)isRightViewShowing;
/** Returns if the left view is showed */
- (BOOL)isLeftViewShowing;

@end


@interface UIViewController(RMPVerticalSlidingViewExtension)
- (RMPSlidingViewController *)rmp_verticalSlidingViewController;
@end
