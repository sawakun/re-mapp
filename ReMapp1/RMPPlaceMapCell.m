//
//  RMPPlaceMapCell.m
//  ReMapp1
//
//  Created by nishiba on 2013/08/17.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "RMPPlaceMapCell.h"
#import "RMPPlace.h"
#import "constants.h"
#import "RMPViewInPlaceMapCell.h"
#import "RMPScrollViewInPlaceMapCell.h"

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

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

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
            //[self setActionButtonViewPosition];
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
        CGFloat maxOffset = self.innerScrollView.frame.size.height - self.collectionView.frame.size.height;
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
            //[self setActionButtonViewPosition];
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
        return;
    }
    return;
}

- (void)moveCollectionViewWithNewPosition:(CGPoint)position
{
    self.collectionView.layer.position = position;
    [self setActionButtonViewPosition];
    [self setInnerScrollViewPosition];
}

- (void)setActionButtonViewPosition
{
    CGFloat mapViewHeight = self.mapView.frame.size.height;
    CGFloat collectionViewY = self.collectionView.frame.origin.y;
    CGFloat originY = mapViewHeight - collectionViewY - self.actionButtonView.frame.size.height;
    originY = fmaxf(self.minActionButtonCenterY, originY);
    CGFloat originX = (self.collectionView.frame.size.width - self.innerScrollView.frame.size.width) * 0.5;
    CGPoint position = CGPointMake(originX, originY);
    [self.actionButtonView setLeftTopPosition:position];
}

- (void)setInnerScrollViewPosition;
{
    CGFloat originY = -20.0 / self.collectionView.frame.size.height * self.collectionView.frame.origin.y + 20.0;
    originY = MAX(originY, 5);
    CGFloat originX = (self.collectionView.frame.size.width - self.innerScrollView.frame.size.width) * 0.5;
    CGPoint position = CGPointMake(originX, originY);
    [self.innerScrollView setLeftTopPosition:position];
}

- (void)setDataWithPlace:(RMPPlace *)place
{
    // set data to screen
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    // set superviews
    self.collectionView = self.superview.superview;
    self.mapView = self.collectionView.superview;
    // set initial values
    self.minActionButtonCenterY = FIRST_MAP_CELL_HEIGHT;
    // set pangesture
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(sliding:)];
    [self.innerScrollView.panGestureRecognizer requireGestureRecognizerToFail:panGesture];
    [panGesture setDelegate:self];
    [self.innerScrollView addGestureRecognizer:panGesture];
    [self.innerScrollView setContentOffset:CGPointMake(0, 0)];
    // set positions
    self.hidePosition = CGPointMake(self.collectionView.layer.position.x,
                                    self.collectionView.frame.size.height * 1.5);
    self.fullScreenPosition = CGPointMake(self.collectionView.layer.position.x,
                                          self.collectionView.frame.size.height * 0.5);

    [self setInnerScrollViewPosition];
    [self setActionButtonViewPosition];

}


@end



@implementation RMPPlaceMapCellFactory

+ (RMPPlaceMapCell *)createCellWithCollectionView:(UICollectionView *)collectionView
                              cellForItemAtIndexPath:(NSIndexPath *)indexPath
                                               place:(RMPPlace *)place
{
    RMPPlaceMapCell *cell = (RMPPlaceMapCell *)[collectionView dequeueReusableCellWithReuseIdentifier:[[place class] mapCellIdentifier]
                                                                                         forIndexPath:indexPath];
    
    [cell setDataWithPlace:place];
    return cell;
}

@end
