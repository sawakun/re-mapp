//
//  RMPInitialVerticalSlidingViewController.m
//  ReMapp1
//
//  Created by nishiba on 2013/07/15.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "RMPInitialVerticalSlidingViewController.h"

@interface RMPInitialVerticalSlidingViewController ()

@end

@implementation RMPInitialVerticalSlidingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
    self.bottomViewController = [storyboard instantiateViewControllerWithIdentifier:@"InfoViewController"];
    self.underViewController = [storyboard instantiateViewControllerWithIdentifier:@"MapViewController"];
    self.bottomViewHeightAtMiddlePosition = 120.0f;
    [self anchorTopViewTo:RMPBottom];
    
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
