//
//  RMPMuteListViewController.m
//  ReMapp1
//
//  Created by nishiba on 2013/07/28.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "RMPMuteListViewController.h"
#import "RMPPlaceData.h"

@interface RMPMuteListViewController ()

@end

@implementation RMPMuteListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    _placeData = [[RMPMutePlaceData alloc] init];
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
