//
//  RMPDetailViewController.m
//  ReMapp1
//
//  Created by nishiba on 2013/09/15.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "RMPDetailViewController.h"
#import "RMPPlaceAll.h"
#import "RMPPlaceView.h"

@interface RMPDetailViewController ()
@property (nonatomic) UIPanGestureRecognizer *panGesture;
@property CGRect hideFrame;
@end

@implementation RMPDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    CGRect bounds = self.view.bounds;
    self.hideFrame = CGRectMake(bounds.origin.x + bounds.size.width, bounds.origin.y, bounds.size.width, bounds.size.height);
    
    // Disable the pangesture.
    self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:nil];
    [self.view addGestureRecognizer:self.panGesture];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setPlace:(RMPPlace *)place
{
    UINib *placeViewNib = [UINib nibWithNibName:[place placeViewNibName] bundle:nil];
    RMPPlaceView *placeView = (RMPPlaceView *)[[placeViewNib instantiateWithOwner:self options:nil] objectAtIndex:0];
    [placeView setPlace:place];
    
    [self.scrollView addSubview:placeView];
    self.scrollView.contentSize = placeView.bounds.size;
    
    [self.view setBackgroundColor:[place backgroundColor]];
    self.userNameLabel.text = place.userName;
}

- (IBAction)tappedToHide:(id)sender {
    [UIView animateWithDuration:0.4f animations:^{
        [self.view setFrame:self.hideFrame];
    } completion:nil];
}

@end
