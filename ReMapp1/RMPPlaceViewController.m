//
//  RMPPlaceViewController.m
//  ReMapp1
//
//  Created by nishiba on 2013/08/04.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "RMPPlaceViewController.h"
#import "RMPPlaceCollectionView.h"
#import "RMPSlidingViewController.h"

NSString *const RMPPlaceViewControllerFrameDidMove = @"RMPPlaceViewControllerFrameDidMove";


@implementation RMPPlaceViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UITapGestureRecognizer *singleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedView:)];
    [self.view addGestureRecognizer:singleTapGesture];
}


- (void)frameDidMove
{
    // post notification
    NSDictionary *userInfo = @{@"frame.origin.y":[NSNumber numberWithFloat:self.view.frame.origin.y]};
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:RMPPlaceViewControllerFrameDidMove
                                                            object:self
                                                          userInfo:userInfo];

    });
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void) tappedView:(UIGestureRecognizer*)recognizer
{

    if (self.view.frame.origin.y >= 320.0) {
        CGRect newFrame = CGRectMake(self.view.frame.origin.x,  self.view.frame.size.height - 140, self.view.frame.size.width, self.view.frame.size.height);
        self.view.frame = newFrame;
        [self frameDidMove];
    }
}

@end
