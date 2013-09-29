//
//  RMPMenuViewController.m
//  ReMapp1
//
//  Created by nishiba on 2013/07/28.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "RMPMenuViewController.h"
#import "RMPSlidingViewController.h"
#import "RMPHTTPConnection.h"

@interface RMPMenuViewController ()

@end

@implementation RMPMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.scrollView.contentSize = self.innerView.bounds.size;
    self.scrollView.contentOffset = CGPointMake(0, 0);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tappedLogout:(id)sender {
    UIActionSheet *sheet =[[UIActionSheet alloc]
                           initWithTitle:@"Are you sure you'd like to log out from re:mapp?"
                           delegate:self
                           cancelButtonTitle:@"Cancel"
                           destructiveButtonTitle:@"LOG OUT"
                           otherButtonTitles:nil, nil];
    
    [sheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
    [sheet showInView:self.view];
}


#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == [actionSheet cancelButtonIndex]) {
        // do nothing
    }else if (buttonIndex == [actionSheet destructiveButtonIndex]) {
        // log out and back to opening view.
        BOOL logoutIsSuccess = [RMPHTTPConnection logout];
        if (logoutIsSuccess) {
            [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }else{
        //[selectLabel setText:[actionSheet buttonTitleAtIndex:buttonIndex]];
    }
}

@end
