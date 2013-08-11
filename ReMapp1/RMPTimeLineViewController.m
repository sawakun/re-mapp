//
//  RMPTimeLineViewController.m
//  ReMapp1
//
//  Created by nishiba on 2013/08/08.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "RMPTimeLineViewController.h"
#import "RMPTimeLineDetailViewController.h"
#import "RMPBuzzMapData.h"
#import "RMPPlace.h"
#import "RMPPlaceTimeLineCell.h"
#import "RMPTimeLineDetailViewController.h"
#import <QuartzCore/QuartzCore.h>


@interface RMPTimeLineViewController ()
@property RMPTimeLineDetailViewController *timeLineDetailViewController;
@property CGRect showFrame;
@property CGRect hideFrame;
@property (weak, nonatomic) RMPBuzzMapData *buzzData;
@end

@implementation RMPTimeLineViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self setUp];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self setUp];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)setUp
{
    self.buzzData = [RMPBuzzMapData sharedManager];
    self.timeLineCollectionView.dataSource = self;
    self.timeLineCollectionView.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reload) name:RMPBuzzMapDataReloaded object:self.buzzData];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
    self.timeLineDetailViewController = [storyboard instantiateViewControllerWithIdentifier:@"RMPTimeLineDetailViewController"];
    
    CGRect bounds = self.view.bounds;
    self.hideFrame = CGRectMake(bounds.origin.x + bounds.size.width, bounds.origin.y, bounds.size.width, bounds.size.height);
    self.showFrame = CGRectMake(bounds.origin.x, bounds.origin.y, bounds.size.width, bounds.size.height);
    [self addChildViewController:self.timeLineDetailViewController];
    [self.timeLineDetailViewController didMoveToParentViewController:self];
    [self.timeLineDetailViewController.view setFrame:self.hideFrame];
    [self.view addSubview:self.timeLineDetailViewController.view];
}

- (void)reload
{
    [self.timeLineCollectionView reloadData];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return self.buzzData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RMPPlace *place = [_buzzData buzzAtIndex:indexPath.row];
    return [RMPPlaceTimeLineCellFactory createCellWithCollectionView:collectionView
                                              cellForItemAtIndexPath:indexPath
                                                               place:place];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout  *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RMPPlace *place = [_buzzData buzzAtIndex:indexPath.row];
    return CGSizeMake(320, place.heightForTimeLineCell);
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.timeLineDetailViewController.place = [_buzzData buzzAtIndex:indexPath.row];
    [UIView animateWithDuration:0.4f animations:^{
        [self.timeLineDetailViewController.view setFrame:self.showFrame];
    } completion:nil];
}


@end
