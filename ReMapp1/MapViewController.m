//
//  ViewController.m
//  ReMapp1
//
//  Created by nishiba on 2013/06/29.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.mapView.delegate = self;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
    infoViewController = [storyboard instantiateViewControllerWithIdentifier:@"Info"];
    [infoViewController.view setFrame:self.view.bounds];
    [self addChildViewController:infoViewController];
    [self.view addSubview:infoViewController.view];
    [infoViewController didMoveToParentViewController:self];
    
    //calculate points of center
    float headlineHeight = 80.0f;
    float xcenter = self.view.center.x;
    float height = self.view.frame.size.height;
    float infoHeight = infoViewController.view.frame.size.height;
    hiddenCenter = CGPointMake(xcenter, height + infoHeight * 0.5f);
    lowerCenter = CGPointMake(xcenter, height + infoHeight * 0.5f - headlineHeight);
    middleCenter = CGPointMake(xcenter, height);
    upperCenter = CGPointMake(xcenter, height * 0.5);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    infoViewController.view.center = lowerCenter;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) moveInfoUp
{
    CGPoint center = infoViewController.view.center;
    CGPoint newCenter;
    if (center.y == hiddenCenter.y)
    {
        newCenter = lowerCenter;
    }
    else if (center.y == lowerCenter.y)
    {
        newCenter = middleCenter;
    }
    else if (center.y == middleCenter.y)
    {
        newCenter = upperCenter;
    }
    
    [UIView animateWithDuration:0.5f animations:^{
        infoViewController.view.center = newCenter;
    }];
}

- (void) moveInfoDown
{
    CGPoint center = infoViewController.view.center;
    CGPoint newCenter;
    if (center.y == upperCenter.y)
    {
        newCenter = middleCenter;
    }
    else if (center.y == middleCenter.y)
    {
        newCenter = lowerCenter;
    }
    else if (center.y == lowerCenter.y)
    {
        newCenter = hiddenCenter;
    }
    
    [UIView animateWithDuration:0.5f animations:^{
        infoViewController.view.center = newCenter;
    }];
}

@end
