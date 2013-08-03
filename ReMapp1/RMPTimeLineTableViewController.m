//
//  RMPTimeLineViewController.m
//  ReMapp1
//
//  Created by nishiba on 2013/07/20.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "RMPTimeLineTableViewController.h"
#import "RMPPlace.h"
#import "RMPBuzzData.h"
#import "RMPBuzzCell.h"
#import "RMPSlidingViewController.h"

@interface RMPTimeLineViewController ()
@property (nonatomic) RMPBuzzData *buzzData;
@end

@implementation RMPTimeLineViewController

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
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.buzzData = [RMPBuzzData sharedManager];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reload) name:RMPSlidingViewRightViewWillAppear object:self.rmp_verticalSlidingViewController];
}

- (void)reload
{
    [self.timeLineTableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.buzzData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"RMPBuzzCell";
    RMPBuzzPlace *buzz = [self.buzzData buzzAtIndex:indexPath.row];
    
    RMPBuzzCell *cell = (RMPBuzzCell*)[tableView
                                       dequeueReusableCellWithIdentifier:CellIdentifier
                                       forIndexPath:indexPath];
    cell.nameLabel.text = buzz.userName;
    cell.buzzLabel.text = buzz.text;
    [cell.buzzLabel setNumberOfLines:0];
    [cell.buzzLabel sizeToFit];
    cell.dateLabel.text = buzz.date;

    cell.iconImageView.image = buzz.iconImage;
    if (cell.iconImageView.image == nil) {
        [self downloadIconImage:buzz forIndexPath:indexPath];
    }
    return cell;
}

- (void)downloadIconImage:(RMPBuzzPlace *)buzz forIndexPath:(NSIndexPath *)indexPath
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSData *iconData = [NSData dataWithContentsOfURL:[NSURL URLWithString:buzz.iconURL]];
        buzz.iconImage = [UIImage imageWithData:iconData];
        RMPBuzzCell *cell = (RMPBuzzCell*)[self.timeLineTableView cellForRowAtIndexPath:indexPath];
        cell.iconImageView.image= buzz.iconImage;
    });
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RMPBuzzPlace *buzz = [self.buzzData buzzAtIndex:indexPath.row];
    CGSize maximumLabelSize = CGSizeMake(280,999);
    
    NSString *cellText = buzz.text;
    UIFont *cellFont = [UIFont systemFontOfSize:14];
    CGSize expectedLabelSize = [cellText sizeWithFont:cellFont
                                     constrainedToSize:maximumLabelSize
                                         lineBreakMode:NSLineBreakByWordWrapping];
    
    NSLog(@"%f, %f", expectedLabelSize.height, expectedLabelSize.width);
    return expectedLabelSize.height + 70;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (IBAction)tappedToReturnToMap:(id)sender {
    [self.rmp_verticalSlidingViewController anchorRightViewTo:RMPRight];
}
@end
