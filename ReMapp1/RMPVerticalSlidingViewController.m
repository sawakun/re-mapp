//
//  RMPVerticalSlidingViewController.m
//  VerticalSlidingViewController
//
//  Created by Masahiro Nishiba on 2013/07/15.
//  Copyright (c) 2013年 Masahiro Nishiba. All rights reserved.
//

#import "RMPVerticalSlidingViewController.h"

NSString *const RMPVerticalSlidingViewTopDidMove = @"RMPVerticalSlidingViewTopDidMove";

@interface RMPVerticalSlidingViewController ()
@property (nonatomic) CGFloat initialTouchPositionY;
@property (nonatomic) CGFloat initialVerticalCenter;
@property (nonatomic) CGFloat middleVerticalCenter;
@property (nonatomic) UIPanGestureRecognizer *panGesture;

/** Returns if the top view is showed */
@property (nonatomic) BOOL topViewShowing;

- (NSUInteger)autoResizeToFillScreen;
- (UIView *)topView;
- (UIView *)underView;
- (void)updateTopViewVerticalCenterWithRecognize:(UIPanGestureRecognizer *)recognizer;
- (void)updateTopViewVerticalCenter:(CGFloat)newVerticalCenter;
- (void)topViewVerticalCenterWillChange:(CGFloat)newVerticalCenter;
- (void)topViewVerticalCenterDidChange:(CGFloat)newVerticalCenter;
- (void)underViewWillAppear;
- (void)updateUnderViewLayout;

@end

@implementation RMPVerticalSlidingViewController

- (void)setBottomViewController:(UIViewController *)bottomViewController
{
    CGRect bottomViewFram = _bottomViewController ? bottomViewController.view.frame : self.view.bounds;
    
    [_bottomViewController.view removeFromSuperview];
    [_bottomViewController willMoveToParentViewController:nil];
    [_bottomViewController removeFromParentViewController];
    
    _bottomViewController = bottomViewController;
    
    [self addChildViewController:_bottomViewController];
    [_bottomViewController didMoveToParentViewController:self];
    [_bottomViewController.view setAutoresizesSubviews:self.autoResizeToFillScreen];
    [_bottomViewController.view setFrame:bottomViewFram];
    [_bottomViewController.view addGestureRecognizer:self.panGesture];
    [self.view addSubview:_bottomViewController.view];
}

- (void)setUnderViewController:(UIViewController *)underViewController
{
    [_underViewController.view removeFromSuperview];
    [_underViewController willMoveToParentViewController:nil];
    [_underViewController removeFromParentViewController];
    
    _underViewController = underViewController;
    
    if (_underViewController) {
        [self addChildViewController:self.underViewController];
        [self.underViewController didMoveToParentViewController:self];
        [self updateUnderViewLayout];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(updateTopViewVerticalCenterWithRecognize:)];
    self.bottomViewHeightAtMiddlePosition = 0.0f;
    self.topViewShowing = YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)updateTopViewVerticalCenterWithRecognize:(UIPanGestureRecognizer *)recognizer
{
    CGPoint currentTouchPoint = [recognizer locationInView:self.view];
    CGFloat currentTouchPositionY = currentTouchPoint.y;
    CGFloat panAmount = self.initialTouchPositionY - currentTouchPositionY;
    CGFloat newVerticalCenterPosition = self.initialVerticalCenter - panAmount;
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.initialTouchPositionY = currentTouchPositionY;
        self.initialVerticalCenter = self.topView.center.y;
    }
    else if (recognizer.state == UIGestureRecognizerStateChanged) {
        [self moveTopViewControllerWhileSlidingWithVerticalCenter:newVerticalCenterPosition];
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded ||
             recognizer.state == UIGestureRecognizerStateCancelled) {
        CGPoint currentVelocityPoint = [recognizer velocityInView:self.view];
        CGFloat currentVelocityY = currentVelocityPoint.y;
        [self moveTopViewControllerEndSlidingWithVerticalCenter:newVerticalCenterPosition VelocityY:currentVelocityY];
        
        //post notification
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:RMPVerticalSlidingViewTopDidMove object:self userInfo:nil];
        });
    }
}

- (void)moveTopViewControllerWhileSlidingWithVerticalCenter:(CGFloat)newVerticalCenterPosition
{
    if (newVerticalCenterPosition >= [self screenVerticalCenter]) {
        [self topViewVerticalCenterWillChange:newVerticalCenterPosition];
        [self updateTopViewVerticalCenter:newVerticalCenterPosition];
        [self topViewVerticalCenterDidChange:newVerticalCenterPosition];
        self.topViewShowing = YES;
    }
}

- (void)moveTopViewControllerEndSlidingWithVerticalCenter:(CGFloat)newVerticalCenterPosition VelocityY:(CGFloat)currentVelocityY
{
    CGFloat centerAtMiddle = [self verticalCenterAtMiddlePosition];
    if (currentVelocityY > 100) {
        if (newVerticalCenterPosition < centerAtMiddle) {
            [self anchorTopViewTo:RMPMiddle];
        }
        else {
            [self anchorTopViewTo:RMPBottom];
        }
    }
    else if (currentVelocityY < -100 &&
             self.initialTouchPositionY > [self screenVerticalCenter]) {
        if (newVerticalCenterPosition > centerAtMiddle) {
            [self anchorTopViewTo:RMPMiddle];
        }
        else {
            [self anchorTopViewTo:RMPTop];
        }
    }
}

- (CGFloat)verticalCenterAtMiddlePosition
{
    return self.view.frame.size.height + self.topView.frame.size.height * 0.5 - self.bottomViewHeightAtMiddlePosition;
}


- (void)anchorTopViewTo:(RMPSide)side
{
    CGPoint newCenter = self.topView.center;
    if (RMPTop == side) {
        newCenter.y = [self screenVerticalCenter];
        self.topViewShowing = YES;
    }
    else if (RMPMiddle == side) {
        newCenter.y = [self verticalCenterAtMiddlePosition];
        self.topViewShowing = YES;
    }
    else if (RMPBottom == side) {
        newCenter.y = self.view.frame.size.height + self.topView.frame.size.height * 0.5;
        self.topViewShowing = NO;
    }
    
    [UIView animateWithDuration:0.25f animations:^{
        [self topViewVerticalCenterWillChange:newCenter.y];
        [self updateTopViewVerticalCenter:newCenter.y];
        [self topViewVerticalCenterDidChange:newCenter.y];
    } completion:nil];
}


- (NSUInteger)autoResizeToFillScreen
{
    return (UIViewAutoresizingFlexibleWidth |
            UIViewAutoresizingFlexibleHeight |
            UIViewAutoresizingFlexibleTopMargin |
            UIViewAutoresizingFlexibleBottomMargin |
            UIViewAutoresizingFlexibleLeftMargin |
            UIViewAutoresizingFlexibleRightMargin);
}

- (UIView *)topView
{
    return self.bottomViewController.view;
}

- (UIView *)underView
{
    return self.underViewController.view;
}

- (void)updateTopViewVerticalCenter:(CGFloat)newVerticalCenter
{
    CGPoint centrer = self.topView.center;
    centrer.y = newVerticalCenter;
    self.topView.layer.position = centrer;
}

- (void)topViewVerticalCenterWillChange:(CGFloat)newVerticalCenter
{
    CGPoint center = self.topView.center;
    if (center.y == [self screenVerticalCenter] &&
        newVerticalCenter != [self screenVerticalCenter]) {
        [self underViewWillAppear];
    }
}

- (CGFloat)screenVerticalCenter
{
    return (self.view.bounds.size.height * 0.5);
}

- (void)topViewVerticalCenterDidChange:(CGFloat)newVerticalCenter
{
}

- (void)underViewWillAppear
{
    [self.underView removeFromSuperview];
    [self updateUnderViewLayout];
    [self.view insertSubview:self.underView belowSubview:self.topView];
}


-(void)updateUnderViewLayout
{
    [self.underView setAutoresizingMask:self.autoResizeToFillScreen];
    [self.underView setFrame:self.view.bounds];
}

@end


@implementation UIViewController(RMPVerticalSlidingViewExtension)
- (RMPVerticalSlidingViewController *) rmp_verticalSlidingViewController
{
    UIViewController *viewController = self.parentViewController;
    while (!(viewController == nil || [viewController isKindOfClass:[RMPVerticalSlidingViewController class]])) {
        viewController = viewController.parentViewController;
    }
    
    return (RMPVerticalSlidingViewController *)viewController;
}
@end
