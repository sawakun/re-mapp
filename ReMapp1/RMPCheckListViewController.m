//
//  RMPCheckListViewController.m
//  ReMapp1
//
//  Created by nishiba on 2013/07/28.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "RMPCheckListViewController.h"
#import "RMPPlaceData.h"

@interface RMPCheckListViewController ()

@end

@implementation RMPCheckListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    _placeData = [[RMPCheckPlaceData alloc] init];
    [_placeData reload];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reload) name:RMPPlaceDataReloaded object:_placeData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tappedToReturnToMenu:(id)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
}
@end
