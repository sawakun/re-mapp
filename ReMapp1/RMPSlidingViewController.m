//
//  RMPVerticalSlidingViewController.m
//  VerticalSlidingViewController
//
//  Created by Masahiro Nishiba on 2013/07/15.
//  Copyright (c) 2013年 Masahiro Nishiba. All rights reserved.
//

#import "RMPSlidingViewController.h"

NSString *const RMPSlidingViewBottomViewDidMove = @"RMPSlidingViewBottomViewDidMove";
NSString *const RMPSlidingViewRightViewDidAppear = @"RMPSlidingViewRightViewDidAppear";
NSString *const RMPSlidingViewLeftViewDidAppear = @"RMPSlidingViewLeftViewDidAppear";
NSString *const RMPSlidingViewRightViewDidDisppear = @"RMPSlidingViewRightViewDidDisppear";
NSString *const RMPSlidingViewLeftViewDidDisppear = @"RMPSlidingViewLeftViewDidDisppear";
NSString *const RMPSlidingViewRightViewWillAppear = @"RMPSlidingViewRightViewWillAppear";
NSString *const RMPSlidingViewLeftViewWillAppear = @"RMPSlidingViewLeftViewWillAppear";


@interface RMPSlidingViewController ()
@property (nonatomic) CGFloat initialTouchPositionX;
@property (nonatomic) CGFloat initialTouchPositionY;
@property (nonatomic) CGFloat initialCenterX;
@property (nonatomic) CGFloat initialCenterY;
@property (nonatomic) CGFloat middleCenterY;
@property (nonatomic) UIPanGestureRecognizer *bottomInnerPanGesture;
@property (nonatomic) UIPanGestureRecognizer *rightInnerPanGesture;
@property (nonatomic) UIPanGestureRecognizer *leftInnerPanGesture;
@property (nonatomic) UIPanGestureRecognizer *rightPanGesture;
@property (nonatomic) UIPanGestureRecognizer *leftPanGesture;
@end

@implementation RMPSlidingViewController


- (void)setBottomViewController:(UIViewController *)bottomViewController
{
    [_bottomViewController removeFromParentViewController];
    [_bottomViewController willMoveToParentViewController:nil];
    [_bottomViewController removeFromParentViewController];
    
    _bottomViewController = bottomViewController;
    
    [self addChildViewController:_bottomViewController];
    [_bottomViewController didMoveToParentViewController:self];
    [_bottomViewController.view setAutoresizesSubviews:self.autoResizeToFillScreen];
    [_bottomViewController.view setFrame:self.view.bounds];
    [_bottomViewController.view addGestureRecognizer:self.bottomInnerPanGesture];
    [self.view addSubview:_bottomViewController.view];
}

- (void)setRightViewController:(UIViewController *)rightViewController
{
    [_rightViewController removeFromParentViewController];
    [_rightViewController willMoveToParentViewController:nil];
    [_rightViewController removeFromParentViewController];
    
    _rightViewController = rightViewController;
    
    [self addChildViewController:_rightViewController];
    [_rightViewController didMoveToParentViewController:self];
    [_rightViewController.view setAutoresizesSubviews:self.autoResizeToFillScreen];
    [_rightViewController.view setFrame:self.view.bounds];
    [_rightViewController.view addGestureRecognizer:self.rightInnerPanGesture];
    [self.view addSubview:_rightViewController.view];
}

- (void)setLeftViewController:(UIViewController *)leftViewController
{
    [_leftViewController removeFromParentViewController];
    [_leftViewController willMoveToParentViewController:nil];
    [_leftViewController removeFromParentViewController];
    
    _leftViewController = leftViewController;
    
    [self addChildViewController:_leftViewController];
    [_leftViewController didMoveToParentViewController:self];
    [_leftViewController.view setAutoresizesSubviews:self.autoResizeToFillScreen];
    [_leftViewController.view setFrame:self.view.bounds];
    [_leftViewController.view addGestureRecognizer:self.leftInnerPanGesture];
    [self.view addSubview:_leftViewController.view];
}

- (void)setUnderViewController:(UIViewController *)underViewController
{
    [_underViewController.view removeFromSuperview];
    [_underViewController willMoveToParentViewController:nil];
    [_underViewController removeFromParentViewController];
    
    _underViewController = underViewController;
    
    [self addChildViewController:self.underViewController];
    [self.underViewController didMoveToParentViewController:self];
    [self updateUnderViewLayout];
}

- (BOOL)isBottomViewShowing
{
    return (self.bottomView.layer.position.y < self.view.frame.size.height + self.bottomView.frame.size.height * 0.5);
}

- (BOOL)isRightViewShowing
{
    return (self.rightView.layer.position.x < self.view.frame.size.width + self.rightView.frame.size.width * 0.5);
}

- (BOOL)isLeftViewShowing
{
    return (self.leftView.layer.position.x > - self.leftView.frame.size.width * 0.5);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.bottomInnerPanGesture = [[UIPanGestureRecognizer alloc]
                             initWithTarget:self
                             action:@selector(updateBottomViewVerticalCenterWithRecognize:)];
    self.rightInnerPanGesture = [[UIPanGestureRecognizer alloc]
                            initWithTarget:self
                            action:@selector(updateRightViewHorizontalCenterWithRecognize:)];
    self.leftInnerPanGesture = [[UIPanGestureRecognizer alloc]
                           initWithTarget:self
                           action:@selector(updateLeftViewHorizontalCenterWithRecognize:)];
    
    self.rightPanGesture = [[UIPanGestureRecognizer alloc]
                            initWithTarget:self
                            action:@selector(updateRightViewHorizontalCenterWithRecognize:)];

    self.leftPanGesture = [[UIPanGestureRecognizer alloc]
                                initWithTarget:self
                                action:@selector(updateLeftViewHorizontalCenterWithRecognize:)];
    
    self.bottomViewHeightAtMiddlePosition = 0.0f;
    self.anchorRightPeekAmount = 0.0f;
    self.anchorLeftPeekAmount = 0.0f;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)updateBottomViewVerticalCenterWithRecognize:(UIPanGestureRecognizer *)recognizer
{
    CGPoint currentTouchPoint = [recognizer locationInView:self.view];
    CGFloat currentTouchPositionY = currentTouchPoint.y;
    CGFloat panAmount = self.initialTouchPositionY - currentTouchPositionY;
    CGFloat newVerticalCenterPosition = self.initialCenterY - panAmount;
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.initialTouchPositionY = currentTouchPositionY;
        self.initialCenterY = self.bottomView.center.y;
        [self anchorLeftViewTo:RMPLeft];
        [self anchorRightViewTo:RMPRight];
    }
    else if (recognizer.state == UIGestureRecognizerStateChanged) {
        [self moveBottomViewControllerWhileSlidingWithVerticalCenter:newVerticalCenterPosition];
        [self sendNotificationForBottomViewDidMove];
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded ||
             recognizer.state == UIGestureRecognizerStateCancelled) {
        CGPoint currentVelocityPoint = [recognizer velocityInView:self.view];
        CGFloat currentVelocityY = currentVelocityPoint.y;
        [self moveBottomViewControllerEndSlidingWithVerticalCenter:newVerticalCenterPosition VelocityY:currentVelocityY];
        
        [self sendNotificationForBottomViewDidMove];
    }
}

- (void)updateRightViewHorizontalCenterWithRecognize:(UIPanGestureRecognizer *)recognizer
{
    CGPoint currentTouchPoint = [recognizer locationInView:self.view];
    CGFloat currentTouchPositionX = currentTouchPoint.x;
    CGFloat panAmount = self.initialTouchPositionX - currentTouchPositionX;
    CGFloat newHorizontalCenterPosition = self.initialCenterX - panAmount;
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.initialTouchPositionX = currentTouchPositionX;
        self.initialCenterX = self.rightView.center.x;
        [self anchorBottomViewTo:RMPBottom];
        [self anchorLeftViewTo:RMPLeft];
        if (![self isRightViewShowing]) {
            //post notification
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:RMPSlidingViewRightViewWillAppear object:self userInfo:nil];
            });
        }
    }
    else if (recognizer.state == UIGestureRecognizerStateChanged) {
        [self moveRightViewControllerWhileSlidingWithHorizontalCenter:newHorizontalCenterPosition];
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded ||
             recognizer.state == UIGestureRecognizerStateCancelled) {
        CGPoint currentVelocityPoint = [recognizer velocityInView:self.view];
        CGFloat currentVelocityX = currentVelocityPoint.x;
        [self moveRightViewControllerEndSlidingWithHorizontalCenter:newHorizontalCenterPosition
                                                          VelocityX:currentVelocityX];
    }
}

- (void)updateLeftViewHorizontalCenterWithRecognize:(UIPanGestureRecognizer *)recognizer
{
    CGPoint currentTouchPoint = [recognizer locationInView:self.view];
    CGFloat currentTouchPositionX = currentTouchPoint.x;
    CGFloat panAmount = self.initialTouchPositionX - currentTouchPositionX;
    CGFloat newHorizontalCenterPosition = self.initialCenterX - panAmount;
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.initialTouchPositionX = currentTouchPositionX;
        self.initialCenterX = self.leftView.center.x;
        if (![self isLeftViewShowing]) {
            //post notification
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:RMPSlidingViewLeftViewWillAppear object:self userInfo:nil];
            });
        }
    }
    else if (recognizer.state == UIGestureRecognizerStateChanged) {
        [self moveLeftViewControllerWhileSlidingWithHorizontalCenter:newHorizontalCenterPosition];
        [self anchorBottomViewTo:RMPBottom];
        [self anchorRightViewTo:RMPRight];
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded ||
             recognizer.state == UIGestureRecognizerStateCancelled) {
        CGPoint currentVelocityPoint = [recognizer velocityInView:self.view];
        CGFloat currentVelocityX = currentVelocityPoint.x;
        [self moveLeftViewControllerEndSlidingWithHorizontalCenter:newHorizontalCenterPosition
                                                         VelocityX:currentVelocityX];        
    }
}




- (void)moveBottomViewControllerWhileSlidingWithVerticalCenter:(CGFloat)newVerticalCenterPosition
{
    if (newVerticalCenterPosition >= [self screenVerticalCenter]) {
        [self bottomViewVerticalCenterWillChange:newVerticalCenterPosition];
        [self updateBottomViewVerticalCenter:newVerticalCenterPosition];
        [self bottomViewVerticalCenterDidChange:newVerticalCenterPosition];
    }
}

- (void)moveRightViewControllerWhileSlidingWithHorizontalCenter:(CGFloat)newHorizontalCenterPosition
{
    if (newHorizontalCenterPosition >= [self screenHorizontalCenter]) {
        [self rightViewHorizontalCenterWillChange:newHorizontalCenterPosition];
        [self updateRightViewHorizontalCenter:newHorizontalCenterPosition];
        [self rightViewHorizontalCenterDidChange:newHorizontalCenterPosition];
    }
}


- (void)moveLeftViewControllerWhileSlidingWithHorizontalCenter:(CGFloat)newHorizontalCenterPosition
{
    if (newHorizontalCenterPosition <= [self screenHorizontalCenter]) {
        [self rightViewHorizontalCenterWillChange:newHorizontalCenterPosition];
        [self updateLeftViewHorizontalCenter:newHorizontalCenterPosition];
        [self rightViewHorizontalCenterDidChange:newHorizontalCenterPosition];
    }
}

- (void)moveBottomViewControllerEndSlidingWithVerticalCenter:(CGFloat)newVerticalCenterPosition VelocityY:(CGFloat)currentVelocityY
{
    CGFloat centerAtMiddle = [self verticalCenterAtMiddlePosition];
    if (currentVelocityY > 100) {
        if (newVerticalCenterPosition < centerAtMiddle) {
            [self anchorBottomViewTo:RMPMiddle];
        }
        else {
            [self anchorBottomViewTo:RMPBottom];
        }
    }
    else if (currentVelocityY < -100 &&
             self.initialTouchPositionY > [self screenVerticalCenter]) {
        if (newVerticalCenterPosition > centerAtMiddle) {
            [self anchorBottomViewTo:RMPMiddle];
        }
        else {
            [self anchorBottomViewTo:RMPTop];
        }
    }
}

- (void)moveRightViewControllerEndSlidingWithHorizontalCenter:(CGFloat)newHorizontalCenterPosition VelocityX:(CGFloat)currentVelocityX
{
    if (currentVelocityX > 0) {
        [self anchorRightViewTo:RMPRight];
    }
    else if (currentVelocityX < -0) {
        [self anchorRightViewTo:RMPLeft];
    }
}

- (void)moveLeftViewControllerEndSlidingWithHorizontalCenter:(CGFloat)newHorizontalCenterPosition VelocityX:(CGFloat)currentVelocityX
{
    if (currentVelocityX > 0) {
        [self anchorLeftViewTo:RMPRight];
    }
    else if (currentVelocityX < -0) {
        [self anchorLeftViewTo:RMPLeft];
    }
}


- (CGFloat)verticalCenterAtMiddlePosition
{
    return self.view.frame.size.height
    + self.bottomView.frame.size.height * 0.5
    - self.bottomViewHeightAtMiddlePosition;
}


- (void)anchorBottomViewTo:(RMPSide)side
{
    CGPoint newCenter = self.bottomView.center;
    if (RMPTop == side) {
        newCenter.y = [self screenVerticalCenter];
    }
    else if (RMPMiddle == side) {
        newCenter.y = [self verticalCenterAtMiddlePosition];
        if (self.isRightViewShowing) {
            [self anchorRightViewTo:RMPRight];
        }
        if (self.isLeftViewShowing) {
            [self anchorLeftViewTo:RMPLeft];
        }
    }
    else if (RMPBottom == side) {
        newCenter.y = self.view.frame.size.height + self.bottomView.frame.size.height * 0.5 + 5.0;
    }
    
    [UIView animateWithDuration:0.25f animations:^{
        [self bottomViewVerticalCenterWillChange:newCenter.y];
        [self updateBottomViewVerticalCenter:newCenter.y];
        [self bottomViewVerticalCenterDidChange:newCenter.y];
    } completion:nil];
}

- (void)anchorRightViewTo:(RMPSide)side
{
    CGPoint newCenter = self.rightView.center;
    NSString *notificationName;
    if (RMPLeft == side) {
        newCenter.x = [self screenHorizontalCenter] + self.anchorRightPeekAmount;
        notificationName = RMPSlidingViewRightViewDidAppear;
    }
    else if (RMPRight == side) {
        newCenter.x = self.view.frame.size.width + self.rightView.frame.size.width * 0.5 + 5.0;
        notificationName = RMPSlidingViewRightViewDidDisppear;
    }
    
    [UIView animateWithDuration:0.25f animations:^{
        [self rightViewHorizontalCenterWillChange:newCenter.x];
        [self updateRightViewHorizontalCenter:newCenter.x];
        [self rightViewHorizontalCenterDidChange:newCenter.x];
    } completion:^(BOOL finished){
        if (finished) {
            //post notification
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:self userInfo:nil];
            });
        }
    }];
    
}

- (void)anchorLeftViewTo:(RMPSide)side
{
    CGPoint newCenter = self.leftView.center;
    NSString *notificationName;
    if (RMPRight == side) {
        newCenter.x = [self screenHorizontalCenter] - self.anchorLeftPeekAmount;
        notificationName = RMPSlidingViewLeftViewDidAppear;
    }
    else if (RMPLeft == side) {
        newCenter.x = - self.leftView.frame.size.width * 0.5 - 5.0;
        notificationName = RMPSlidingViewLeftViewDidDisppear;
    }
    
    [UIView animateWithDuration:0.25f animations:^{
        [self leftViewHorizontalCenterWillChange:newCenter.x];
        [self updateLeftViewHorizontalCenter:newCenter.x];
        [self leftViewHorizontalCenterDidChange:newCenter.x];
    } completion:^(BOOL finished){
        if (finished) {
            //post notification
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:self userInfo:nil];
            });
        }
    }];
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

- (UIView *)bottomView
{
    return self.bottomViewController.view;
}

- (UIView *)rightView
{
    return self.rightViewController.view;
}

- (UIView *)leftView
{
    return self.leftViewController.view;
}

- (UIView *)underView
{
    return self.underViewController.view;
}



- (void)updateBottomViewVerticalCenter:(CGFloat)newVerticalCenter
{
    CGPoint centrer = self.bottomView.center;
    centrer.y = newVerticalCenter;
    self.bottomView.layer.position = centrer;
}

- (void)updateRightViewHorizontalCenter:(CGFloat)newHorizonCenter
{
    CGPoint centrer = self.rightView.center;
    centrer.x = newHorizonCenter;
    self.rightView.layer.position = centrer;
}

- (void)updateLeftViewHorizontalCenter:(CGFloat)newHorizonCenter
{
    CGPoint centrer = self.leftView.center;
    centrer.x = newHorizonCenter;
    self.leftView.layer.position = centrer;
}


- (void)bottomViewVerticalCenterWillChange:(CGFloat)newVerticalCenter
{
    CGPoint center = self.bottomView.center;
    if (center.y == [self screenVerticalCenter] &&
        newVerticalCenter != [self screenVerticalCenter]) {
        [self underViewWillAppear];
    }
}

- (void)rightViewHorizontalCenterWillChange:(CGFloat)newHorizontalCenter
{
    CGPoint center = self.rightView.center;
    if (center.x == [self screenHorizontalCenter] &&
        newHorizontalCenter != [self screenHorizontalCenter]) {
        [self underViewWillAppear];
    }
}

- (void)leftViewHorizontalCenterWillChange:(CGFloat)newHorizontalCenter
{
    CGPoint center = self.leftView.center;
    if (center.x == [self screenHorizontalCenter] &&
        newHorizontalCenter != [self screenHorizontalCenter]) {
        [self underViewWillAppear];
    }
}

- (CGFloat)screenVerticalCenter
{
    return (self.view.bounds.size.height * 0.5);
}

- (CGFloat)screenHorizontalCenter
{
    return (self.view.bounds.size.width * 0.5);
}


- (void)bottomViewVerticalCenterDidChange:(CGFloat)newVerticalCenter
{
}

- (void)rightViewHorizontalCenterDidChange:(CGFloat)newHorizontalCenter
{
}

- (void)leftViewHorizontalCenterDidChange:(CGFloat)newHorizontalCenter
{
}

- (void)underViewWillAppear
{
    [self.underView removeFromSuperview];
    [self updateUnderViewLayout];
    [self.view insertSubview:self.underView belowSubview:self.bottomView];
}


-(void)updateUnderViewLayout
{
    [self.underView setAutoresizingMask:self.autoResizeToFillScreen];
    [self.underView setFrame:self.view.bounds];
}


- (void)sendNotificationForBottomViewDidMove
{
    //post notification
    NSDictionary *userInfo = @{@"frame.origin.y":[NSNumber numberWithFloat:self.bottomView.frame.origin.y]};
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:RMPSlidingViewBottomViewDidMove object:self userInfo:userInfo];
    });
}


- (void)hideSubViews
{
    [self underViewWillAppear];
    [self hideBottomView];
    [self hideRightView];
    [self hideLeftView];
}

- (void)hideBottomView
{
    CGPoint newCenter = self.bottomView.center;
    newCenter.y = self.view.frame.size.height + self.bottomView.frame.size.height * 0.5 + 5.0;
    [self updateBottomViewVerticalCenter:newCenter.y];
}

- (void)hideRightView
{
    CGPoint newCenter = self.rightView.center;
    newCenter.x = self.view.frame.size.width + self.rightView.frame.size.width * 0.5 + 5.0;
    [self updateRightViewHorizontalCenter:newCenter.x];
}

- (void)hideLeftView
{
    CGPoint newCenter = self.leftView.center;
    newCenter.x = - self.leftView.frame.size.width * 0.5 - 5.0;
    [self updateLeftViewHorizontalCenter:newCenter.x];
}

@end


@implementation UIViewController(RMPVerticalSlidingViewExtension)
- (RMPSlidingViewController *) rmp_verticalSlidingViewController
{
    UIViewController *viewController = self.parentViewController;
    while (!(viewController == nil || [viewController isKindOfClass:[RMPSlidingViewController class]])) {
        viewController = viewController.parentViewController;
    }
    
    return (RMPSlidingViewController *)viewController;
}
@end
