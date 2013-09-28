//
//  RMPTimeLineViewController.m
//  ReMapp1
//
//  Created by nishiba on 2013/08/08.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "RMPMapTimeLineViewController.h"
#import "RMPTimeLineDetailViewController.h"
#import "RMPMapPlaceData.h"
#import "RMPPlace.h"
#import "RMPPlaceCell.h"
#import "RMPTimeLineDetailViewController.h"
#import "AMBlurView.h"
#import <QuartzCore/QuartzCore.h>


@implementation RMPMapTimeLineViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    _placeData = [RMPMapPlaceData sharedManager];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reload) name:RMPBuzzMapDataReloaded object:_placeData];
}

- (void)viewWillAppear:(BOOL)animated
{
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
