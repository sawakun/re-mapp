//
//  RMPInitialViewController.m
//  ReMapp1
//
//  Created by nishiba on 2013/07/18.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "RMPInitialViewController.h"

@interface RMPInitialViewController ()

@end

@implementation RMPInitialViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

    UIStoryboard *storyboard;
    
    storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
    self.topViewController = [storyboard instantiateViewControllerWithIdentifier:@"RMPInitialVerticalSlidingViewController"];
    self.underLeftViewController = [storyboard instantiateViewControllerWithIdentifier:@"Menu"];
    self.underRightViewController = [storyboard instantiateViewControllerWithIdentifier:@"TimeLine"];

    [self.topViewController.view addGestureRecognizer:self.panGesture];
    
    [self setAnchorRightRevealAmount:280.0f];
    self.underLeftWidthLayout = ECFullWidth;

    [self setAnchorLeftPeekAmount:40.f];
    self.underRightWidthLayout = ECFullWidth;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
