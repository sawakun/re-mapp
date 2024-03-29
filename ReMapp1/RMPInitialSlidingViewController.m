//
//  RMPInitialVerticalSlidingViewController.m
//  ReMapp1
//
//  Created by nishiba on 2013/07/15.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "RMPInitialSlidingViewController.h"
#import "constants.h"

@interface RMPInitialSlidingViewController ()
@end

@implementation RMPInitialSlidingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
    self.underViewController = [storyboard instantiateViewControllerWithIdentifier:@"MapViewController"];
    
    self.bottomViewController = [storyboard instantiateViewControllerWithIdentifier:@"RMPPlaceViewController"];
    self.rightViewController = [storyboard instantiateViewControllerWithIdentifier:@"RMPMapTimeLineViewController"];
    self.leftViewController = [storyboard instantiateViewControllerWithIdentifier:@"RMPMenuViewController"];
    
    self.bottomViewHeightAtMiddlePosition = FIRST_MAP_CELL_HEIGHT;
    self.anchorRightPeekAmount = 0.0f;
    self.anchorLeftPeekAmount = 0.0f;
    
    [self hideSubViews];
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


- (BOOL)shouldAutorotate
{
    return NO;
}


@end
