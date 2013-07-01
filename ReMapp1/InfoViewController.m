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
#import "BuzzData.h"
#import "Buzz.h"

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
    // get BuzzData
    _buzzData = [BuzzData sharedInstance];
    NSLog(@"N=%d", _buzzData.count);
    // set info table
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
    return _buzzData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"InfoCell";
    InfoCell *cell = (InfoCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    Buzz *buzz = [_buzzData buzzAtIndex:indexPath.row];
    cell.headlineLabel.text = buzz.text;
    cell.contentView.transform = CGAffineTransformMakeRotation(M_PI * (-0.5f));
    return cell;
}

- (void)showNthCell:(NSInteger)index
{
    CGFloat pageWidth = _infoTableView.frame.size.width;
    CGPoint newPoint = CGPointMake(_infoTableView.contentOffset.x,  pageWidth * index);
    [_infoTableView setContentOffset:newPoint animated:NO];
}

- (IBAction)swipeUp:(id)sender {
    MapViewController *parent = (MapViewController *)self.parentViewController;
    [parent moveInfoUp];
}

- (IBAction)swipeDown:(id)sender {
    MapViewController *parent = (MapViewController *)self.parentViewController;
    [parent moveInfoDown];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"bgView height = %f", self.view.frame.size.height);
    NSLog(@"width = %f", self.infoTableView.frame.size.width);
    NSLog(@"select = %d",indexPath.row);
}

/*
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat pageWidth = scrollView.frame.size.width;
    float fractionalPage = scrollView.contentOffset.y / pageWidth;
    NSLog(@"scroll = %f @scrollViewDidScroll", pageWidth);
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    CGFloat pageWidth = scrollView.frame.size.width;
    //float fractionalPage = scrollView.contentOffset.y / pageWidth;
    NSLog(@"scroll = %f @scrollViewDidEndDragging", pageWidth);
}
*/

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat pageWidth = scrollView.frame.size.width;
    float fractionalPage = scrollView.contentOffset.y / pageWidth;
    MapViewController *parent = (MapViewController *)self.parentViewController;
    [parent showCenter:fractionalPage];
}

@end
