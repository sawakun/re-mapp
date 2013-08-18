//
//  RMPPlaceMapCell.m
//  ReMapp1
//
//  Created by nishiba on 2013/08/17.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "RMPPlaceMapCell.h"
#import "RMPPlace.h"
#import "RMPRearrangedView.h"
#import "constants.h"

@interface RMPPlaceMapCell()
@property CGFloat initialTouchPositionY;
@property CGFloat initialCenterY;
@property CGFloat initialParentCenterY;
@property CGFloat initialParentCenterX;
@property CGFloat initialOffsetY;
@property BOOL isVerticalDirection;
@property UIView *collectionView;
@property UIView *mapView;
@property CGPoint hidePosition;
@property CGPoint fullScreenPosition;
@property CGFloat minActionButtonCenterY;
@end

@implementation RMPPlaceMapCell
static NSString *notificationName = @"moveCollectionViewWithNewPosition";
static CGFloat previousActionButtonPosition;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
    }
    return self;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (void)sliding:(UIPanGestureRecognizer *)recognizer
{
    CGPoint currentTouchPoint = [recognizer locationInView:self.mapView];
    CGFloat currentTouchPositionY = currentTouchPoint.y;
    CGFloat panAmount = self.initialTouchPositionY - currentTouchPositionY;
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        // check slide direction.
        CGPoint currentVelocityPoint = [recognizer velocityInView:self.superview.superview];
        if (fabsf(currentVelocityPoint.x) > fabsf(currentVelocityPoint.y)) {
            self.isVerticalDirection = NO;
            [self moveActionButton];
            return;
        }
        // set inital values
        self.isVerticalDirection = YES;
        self.initialTouchPositionY = currentTouchPositionY;
        self.initialCenterY = self.collectionView.layer.position.y;
        self.initialOffsetY = self.innerScrollView.contentOffset.y;
        self.initialParentCenterY = self.collectionView.layer.position.y;
        self.initialParentCenterX = self.collectionView.layer.position.x;
        return;
    }
    
    if (!self.isVerticalDirection)
    {
        return;
    }
    
    if (recognizer.state == UIGestureRecognizerStateChanged) {
        CGRect frame = self.collectionView.frame;
        BOOL isUp = (panAmount > 0);
        // move up the parent view
        if (frame.origin.y > 0 && isUp) {
            CGFloat newCenterY = fmaxf(self.initialCenterY - panAmount, frame.size.height * 0.5);
            [self moveCollectionViewWithNewPosition:CGPointMake(self.initialParentCenterX, newCenterY)];
            self.initialParentCenterY = self.collectionView.layer.position.y;
            return;
        }
        
        CGFloat currentMoveAmount = self.initialCenterY - self.initialParentCenterY;
        CGFloat offset = panAmount-currentMoveAmount + self.initialOffsetY;
        CGFloat maxOffset = self.innerScrollView.contentSize.height - self.collectionView.frame.size.height;
    
        if (offset >= maxOffset) {
            // update initial values
            self.isVerticalDirection = YES;
            self.initialTouchPositionY = currentTouchPositionY;
            self.initialCenterY = self.collectionView.layer.position.y;
            self.initialOffsetY = self.innerScrollView.contentOffset.y;
            self.initialParentCenterY = self.collectionView.layer.position.y;
            self.initialParentCenterX = self.collectionView.layer.position.x;
            return;
        }
        
        // scroll
        if (offset >= 0)
        {
            [self.innerScrollView flashScrollIndicators];
            [self.innerScrollView setContentOffset:CGPointMake(0, offset)];
            [self moveActionButton];
            // update initial values
            self.isVerticalDirection = YES;
            self.initialTouchPositionY = currentTouchPositionY;
            self.initialCenterY = self.collectionView.layer.position.y;
            self.initialOffsetY = self.innerScrollView.contentOffset.y;
            self.initialParentCenterY = self.collectionView.layer.position.y;
            self.initialParentCenterX = self.collectionView.layer.position.x;
            return;
        }
        
        // move down the parent view
        CGFloat newCenterY = self.initialCenterY - offset;
        [self moveCollectionViewWithNewPosition:CGPointMake(self.initialParentCenterX, newCenterY)];
        [self.innerScrollView setContentOffset:CGPointMake(0, 0)];
        return;
    }
    
    if (recognizer.state == UIGestureRecognizerStateEnded ||
        recognizer.state == UIGestureRecognizerStateCancelled)
    {
        CGPoint currentVelocityPoint = [recognizer velocityInView:self.superview.superview];
        if (currentVelocityPoint.y > 100) {
            // hide collection view
            [UIView animateWithDuration:0.25f animations:^{
                [self moveCollectionViewWithNewPosition:self.hidePosition];
            } completion:nil];
        }
        else if (currentVelocityPoint.y < -100) {
            // set collection view as full screen
            [UIView animateWithDuration:0.25f animations:^{
                [self moveCollectionViewWithNewPosition:self.fullScreenPosition];
            } completion:nil];
        }
        //post notification
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:self userInfo:nil];
        });
        return;
    }
    return;
}

- (void)moveCollectionViewWithNewPosition:(CGPoint)position
{
    self.collectionView.layer.position = position;
    [self moveActionButton];
}

- (void)moveActionButton
{
    CGFloat positionY = self.mapView.frame.size.height - self.collectionView.frame.origin.y - self.actionButtonView.frame.size.height * 0.5;
    positionY = fmaxf(self.minActionButtonCenterY, positionY);
    previousActionButtonPosition = positionY;
    self.actionButtonView.layer.position = CGPointMake(self.collectionView.layer.position.x, positionY);
}


- (void)moveActionButtonWithNotification:(NSNotification *)center
{
    [self moveActionButton];
}

- (void)setDataWithPlace:(RMPPlace *)place
{
    // set data to screen
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    // set initial values
    self.minActionButtonCenterY = FIRST_MAP_CELL_HEIGHT + self.actionButtonView.frame.size.height * 0.5;
    // set pangesture
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(sliding:)];
    [self.innerScrollView.panGestureRecognizer requireGestureRecognizerToFail:panGesture];
    [panGesture setDelegate:self];
    [self.innerScrollView addGestureRecognizer:panGesture];
    [self.innerScrollView setContentOffset:CGPointMake(0, 0)];
    // set superviews
    self.collectionView = self.superview.superview;
    self.mapView = self.collectionView.superview;
    // set positions
    self.hidePosition = CGPointMake(self.collectionView.layer.position.x,
                                    self.collectionView.frame.size.height * 1.5);
    self.fullScreenPosition = CGPointMake(self.collectionView.layer.position.x,
                                          self.collectionView.frame.size.height * 0.5);
    // regist notification
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moveActionButtonWithNotification:)
                                                 name:notificationName
                                               object:nil];
    // set other values
    [self moveActionButton];
    [self.actionButtonView setCenterY:previousActionButtonPosition];
}




@end


@implementation RMPPlaceMapCellFactory

+ (RMPPlaceMapCell *)createCellWithCollectionView:(UICollectionView *)collectionView
                              cellForItemAtIndexPath:(NSIndexPath *)indexPath
                                               place:(RMPPlace *)place
{
    /*
    RMPPlaceMapCell *cell = (RMPPlaceMapCell *)[collectionView dequeueReusableCellWithReuseIdentifier:[[place class] detailCellIdentifier]
                                                                                         forIndexPath:indexPath];
    */
    RMPPlaceMapCell *cell = (RMPPlaceMapCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"RMPBuzzMapCell"
                                                                                         forIndexPath:indexPath];
    
    [cell setDataWithPlace:place];
    return cell;
}

@end
