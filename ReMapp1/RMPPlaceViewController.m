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
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(frameDidMove)
                                                 name:RMPSlidingViewBottomViewDidMove
                                               object:nil];

    
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
    NSLog(@"x=%f", self.view.frame.origin.x);
    NSLog(@"y=%f", self.view.frame.origin.y);
    NSLog(@"width=%f", self.view.frame.size.width);
    NSLog(@"height=%f", self.view.frame.size.height);

    if (self.view.frame.origin.y >= 320.0) {
        CGRect newFrame = CGRectMake(self.view.frame.origin.x, 295, self.view.frame.size.width, self.view.frame.size.height);
        self.view.frame = newFrame;
        [self frameDidMove];
    }
    
}

@end
