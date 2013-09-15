//
//  RMPDetailViewController.m
//  ReMapp1
//
//  Created by nishiba on 2013/09/15.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "RMPDetailViewController.h"

@interface RMPDetailViewController ()

@end

@implementation RMPDetailViewController

// Background color of BUZZ.
static const NSUInteger BG_RED_BUZZ    = 30;
static const NSUInteger BG_GREEN_BUZZ  = 184;
static const NSUInteger BG_BLUE_BUZZ   = 203;
// Background color of EAT.
static const NSUInteger BG_RED_EAT     = 32;
static const NSUInteger BG_GREEN_EAT   = 200;
static const NSUInteger BG_BLUE_EAT    = 155;
// Background color of SHOP.
static const NSUInteger BG_RED_SHOP    = 86;
static const NSUInteger BG_GREEN_SHOP  = 198;
static const NSUInteger BG_BLUE_SHOP   = 35;
// Background color of PLAY.
static const NSUInteger BG_RED_PLAY    = 30;
static const NSUInteger BG_GREEN_PLAY  = 198;
static const NSUInteger BG_BLUE_PLAY   = 83;


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
    UINib *buzzViewNib = [UINib nibWithNibName:@"RMPBuzzView" bundle:nil];
    UIView *buzzView = [[buzzViewNib instantiateWithOwner:self options:nil] objectAtIndex:0];
    NSLog(@"%f, %f, %f, %f",
          buzzView.frame.origin.x,
          buzzView.frame.origin.y,
          buzzView.frame.size.width,
          buzzView.frame.size.height);
    [self.scrollView addSubview:buzzView];
    self.scrollView.contentSize = buzzView.bounds.size;
    // set background color
    [self.view setBackgroundColor:[UIColor colorWithRed:(BG_RED_BUZZ / 255.0)
                                                  green:(BG_GREEN_BUZZ / 255.0)
                                                   blue:(BG_BLUE_BUZZ / 255.0)
                                                  alpha:1.0]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
