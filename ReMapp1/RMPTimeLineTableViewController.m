//
//  RMPTimeLineViewController.m
//  ReMapp1
//
//  Created by nishiba on 2013/07/20.
//  Copyright (c) 2013年 nishiba. All rights reserved.
// test

#import "RMPTimeLineTableViewController.h"
#import "Buzz.h"
#import "RMPBuzzData.h"
#import "RMPBuzzCell.h"

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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reload) name:RMPBuzzDataReloaded object:self.buzzData];
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
    Buzz *buzz = [self.buzzData buzzAtIndex:indexPath.row];
    
    RMPBuzzCell *cell = (RMPBuzzCell*)[tableView
                                       dequeueReusableCellWithIdentifier:CellIdentifier
                                       forIndexPath:indexPath];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSData *iconData = [NSData dataWithContentsOfURL:[NSURL URLWithString:buzz.iconURL]];
        cell.iconImageView.image = [UIImage imageWithData:iconData];
    });
    cell.nameLabel.text = buzz.userName;
    cell.buzzLabel.text = buzz.text;
    [cell.buzzLabel setNumberOfLines:0];
    [cell.buzzLabel sizeToFit];
    cell.dateLabel.text = buzz.date;
     return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Buzz *buzz = [self.buzzData buzzAtIndex:indexPath.row];
    CGSize maximumLabelSize = CGSizeMake(296,999);
    
    NSString *cellText = buzz.text;
    UIFont *cellFont = [UIFont systemFontOfSize:16];
    CGSize expectedLabelSize = [cellText sizeWithFont:cellFont
                                     constrainedToSize:maximumLabelSize
                                         lineBreakMode:NSLineBreakByWordWrapping];
    
    return expectedLabelSize.height + 70;
    
    /*
     UIFont *cellFont = [UIFont fontWithName:@"System" size:14.0];
     CGSize constraintSize = CGSizeMake(230.0f, MAXFLOAT);
     CGSize labelSize = [cellText sizeWithFont:cellFont constrainedToSize:constraintSize lineBreakMode:NSLineBreakByWordWrapping];
     */
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

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

@end
