//
//  InfoViewController.m
//  ReMapp1
//
//  Created by nishiba on 2013/06/30.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "InfoViewController.h"
#import "InfoCell.h"
#import "MapViewController.h"

@interface InfoViewController ()

@end

@implementation InfoViewController

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
    _infoTableView.transform = CGAffineTransformMakeRotation(M_PI * 0.5f);
    _infoTableView.pagingEnabled = YES;
    _infoTableView.bounces = NO;
    _infoTableView.showsVerticalScrollIndicator = NO;
    _infoTableView.rowHeight = self.view.frame.size.width;
    [_infoTableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"InfoCell";
    InfoCell *cell = (InfoCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.contentView.transform = CGAffineTransformMakeRotation(M_PI * (-0.5f));
    return cell;
}

- (IBAction)swipeUp:(id)sender {
    MapViewController *parent = (MapViewController *)self.parentViewController;
    [parent moveInfoUp];
}

- (IBAction)swipeDown:(id)sender {
    MapViewController *parent = (MapViewController *)self.parentViewController;
    [parent moveInfoDown];
}
@end
