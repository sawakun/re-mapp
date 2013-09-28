//
//  RMPKeyboardMoveScrollView.m
//  ReMapp1
//
//  Created by nishiba on 2013/09/27.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "RMPKeyboardMoveScrollView.h"


@interface RMPKeyboardMoveScrollView ()
@property BOOL keyboardIsVisible;
@property CGFloat keyboardCeiling;
@property CGFloat duration;
@end

@implementation RMPKeyboardMoveScrollView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.keyboardIsVisible = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(adjustScrollOffset:) name:UITextFieldTextDidBeginEditingNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification*)notification
{
    self.keyboardIsVisible = YES;
    //get keyboard size and position
    CGRect keyboardFramEnd = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.keyboardCeiling = keyboardFramEnd.origin.y - 54.0f;
    // get text view size and postions
    UIView *firstResponder = [self findFirstResponder:self];
    CGFloat responderFloor = firstResponder.frame.origin.y + firstResponder.frame.size.height;
    
    // get duration of showing keyboard
    self.duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    CGFloat offset =  MAX(responderFloor - self.keyboardCeiling, 0.0f);
    [UIView animateWithDuration:self.duration animations:^{
        self.contentOffset = CGPointMake(0.0f, offset);
    } completion:nil];
    
}

- (void)keyboardWillHide:(NSNotification*)notification
{
    self.keyboardIsVisible = NO;
    // get duration of showing keyboard
    CGFloat duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    [UIView animateWithDuration:duration animations:^{
        self.contentOffset = CGPointMake(0.0f, 0.0f);
    } completion:nil];
}

- (void)adjustScrollOffset:(NSNotification*)notification
{
    if (!self.keyboardIsVisible) {
        return;
    }
    // get text view size and postions
    UIView *firstResponder = [self findFirstResponder:self];
    CGFloat responderFloor = firstResponder.frame.origin.y + firstResponder.frame.size.height;
    
    CGFloat offset =  MAX(responderFloor - self.keyboardCeiling, 0.0f);
    [UIView animateWithDuration:self.duration animations:^{
        self.contentOffset = CGPointMake(0.0f, offset);
    } completion:nil];
}


- (UIView*)findFirstResponder:(UIView*)view {
    for ( UIView *childView in view.subviews ) {
        if ( [childView respondsToSelector:@selector(isFirstResponder)] && [childView isFirstResponder] ) {
            return childView;
        }
        
        UIView *result = [self findFirstResponder:childView];
        if ( result ) {
            return result;
        }
    }
    return nil;
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
}



@end
