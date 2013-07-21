//
//  RMPInitialVerticalSlidingViewController.m
//  ReMapp1
//
//  Created by nishiba on 2013/07/15.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "RMPInitialSlidingViewController.h"

@interface RMPInitialSlidingViewController ()

@end

@implementation RMPInitialSlidingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
    self.bottomViewController = [storyboard instantiateViewControllerWithIdentifier:@"InfoViewController"];
    self.underViewController = [storyboard instantiateViewControllerWithIdentifier:@"MapViewController"];
    self.rightViewController = [storyboard instantiateViewControllerWithIdentifier:@"TimeLine"];
    self.leftViewController = [storyboard instantiateViewControllerWithIdentifier:@"Menu"];
    self.bottomViewHeightAtMiddlePosition = 120.0f;
    self.anchorRightPeekAmount = 20.0f;
    self.anchorLeftPeekAmount = 20.0f;
    [self anchorBottomViewTo:RMPBottom];
    [self anchorRightViewTo:RMPRight];
    [self anchorLeftViewTo:RMPLeft];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
