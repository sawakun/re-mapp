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
#import "RMPBuzzData.h"
#import "RMPPlace.h"
#import "MapViewController.h"
#import "RMPMapView.h"

NSString *const InfoCellDidMove = @"InfoCellDidMove";

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
    // set info table
    _infoTableView.transform = CGAffineTransformMakeRotation(M_PI * 0.5f);
    _infoTableView.pagingEnabled = YES;
    _infoTableView.bounces = NO;
    _infoTableView.showsVerticalScrollIndicator = NO;
    _infoTableView.rowHeight = self.view.frame.size.width;
    [_infoTableView reloadData];
    
    self.buzzData = [RMPBuzzData sharedManager];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showNthCell:) name:RMPMapViewDidSelectAnnotation object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reload) name:RMPBuzzDataReloaded object:self.buzzData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)reload
{
    [self.infoTableView reloadData];
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
    RMPBuzzPlace *buzz = [_buzzData buzzAtIndex:indexPath.row];
    InfoCell *cell = (InfoCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSData *iconData = [NSData dataWithContentsOfURL:[NSURL URLWithString:buzz.iconURL]];
        cell.iconImageView.image = [UIImage imageWithData:iconData];
    });
    cell.nameLabel.text = buzz.userName;
    cell.buzzLabel.text = buzz.text;
    cell.dateLabel.text = buzz.date;

    cell.contentView.transform = CGAffineTransformMakeRotation(M_PI * (-0.5f));
    return cell;
}

- (void)showNthCell:(NSNotification *)center
{
    NSInteger annotationIndex = [center.userInfo[@"annotationIndex"] intValue];
    CGFloat pageWidth = _infoTableView.frame.size.width;
    CGPoint newPoint = CGPointMake(_infoTableView.contentOffset.x,  pageWidth * annotationIndex);
    [_infoTableView setContentOffset:newPoint animated:NO];
}


#pragma mark - Table view delegate


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat pageWidth = scrollView.frame.size.width;
    float fractionalPage = scrollView.contentOffset.y / pageWidth;

    //post notification
    NSDictionary *userInfo = @{@"annotationIndex":[NSNumber numberWithInteger:fractionalPage]};
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:InfoCellDidMove
                                                            object:self
                                                          userInfo:userInfo];
    });
}

@end
