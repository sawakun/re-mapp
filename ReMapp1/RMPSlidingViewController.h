//
//  RMPVerticalSlidingViewController.h
//  VerticalSlidingViewController
//
//  Created by Masahiro Nishiba on 2013/07/15.
//  Copyright (c) 2013年 Masahiro Nishiba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

/** Notification that gets posted when the bottom view moved */
extern NSString *const RMPSlidingViewBottomViewDidMove;
/** Notification that gets posted when the right view appear */
extern NSString *const RMPSlidingViewRightViewDidAppear;
/** Notification that gets posted when the left view appear */
extern NSString *const RMPSlidingViewLeftViewDidAppear;
/** Notification that gets posted when the right view disappear */
extern NSString *const RMPSlidingViewRightViewDidDisppear;
/** Notification that gets posted when the left view disappear */
extern NSString *const RMPSlidingViewLeftViewDidDisppear;
/** Notification that gets posted when the right view will appear */
extern NSString *const RMPSlidingViewRightViewWillAppear;
/** Notification that gets posted when the left view will appear */
extern NSString *const RMPSlidingViewLeftViewWillAppear;

/** Protocols **/
@protocol RMPSlidingLeftViewDelegate <NSObject>
- (void)leftViewDidMove:(CGFloat)horizontalCenter;
@end

@protocol RMPSlidingRightViewDelegate <NSObject>
- (void)rightViewDidMove:(CGFloat)horizontalCenter;
@end

@protocol RMPSlidingBottomViewDelegate <NSObject>
- (void)bottomViewDidMove:(CGFloat)verticalCenter;
@end

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
/** Returns horizontal panning gesture for moving the bottom view. */
@property (nonatomic, readonly) UIPanGestureRecognizer *bottomPanGesture;

@property(nonatomic, assign) id <RMPSlidingLeftViewDelegate> delegateLeft;
@property(nonatomic, assign) id <RMPSlidingRightViewDelegate> delegateRight;
@property(nonatomic, assign) id <RMPSlidingBottomViewDelegate> delegateBottom;


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


- (void)hideSubViews;

@end




@interface UIViewController(RMPVerticalSlidingViewExtension)
- (RMPSlidingViewController *)rmp_slidingViewController;
@end
