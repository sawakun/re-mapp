//
//  RMPTimeLineViewController.m
//  ReMapp1
//
//  Created by nishiba on 2013/08/08.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "RMPTimeLineViewController.h"
#import "RMPTimeLineDetailViewController.h"
#import "RMPPlaceData.h"
#import "RMPPlace.h"
#import "RMPPlaceCell.h"
#import "RMPTimeLineDetailViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "RMPMapPlaceData.h"

@interface RMPTimeLineViewController ()
@property RMPTimeLineDetailViewController *timeLineDetailViewController;
@property CGRect showFrame;
@property CGRect hideFrame;
@end

@implementation RMPTimeLineViewController

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
    self.timeLineCollectionView.dataSource = self;
    self.timeLineCollectionView.delegate = self;
    
    // set nib
    UINib *buzzCell = [UINib nibWithNibName:@"RMPBuzzCell" bundle:nil];
    UINib *shopCell = [UINib nibWithNibName:@"RMPShopCell" bundle:nil];
    UINib *eatCell  = [UINib nibWithNibName:@"RMPEatCell"  bundle:nil];
    UINib *playCell = [UINib nibWithNibName:@"RMPPlayCell" bundle:nil];
    [self.timeLineCollectionView registerNib:buzzCell forCellWithReuseIdentifier:@"RMPBuzzCell"];
    [self.timeLineCollectionView registerNib:shopCell forCellWithReuseIdentifier:@"RMPShopCell"];
    [self.timeLineCollectionView registerNib:eatCell  forCellWithReuseIdentifier:@"RMPEatCell"];
    [self.timeLineCollectionView registerNib:playCell forCellWithReuseIdentifier:@"RMPPlayCell"];
    
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
    self.timeLineDetailViewController = [storyboard instantiateViewControllerWithIdentifier:@"RMPTimeLineDetailViewController"];
    
    CGRect bounds = self.view.bounds;
    NSLog(@"%f", bounds.size.height);
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
    return _placeData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RMPPlace *place = [_placeData placeAtIndex:indexPath.row];
    return [RMPPlaceCellFactory createCellWithCollectionView:collectionView
                                              cellForItemAtIndexPath:indexPath
                                                               place:place];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout  *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RMPPlace *place = [_placeData placeAtIndex:indexPath.row];
    return CGSizeMake(320, place.heightForTimeLineCell);
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.timeLineDetailViewController.place = [_placeData placeAtIndex:indexPath.row];
    [UIView animateWithDuration:0.4f animations:^{
        [self.timeLineDetailViewController.view setFrame:self.showFrame];
    } completion:nil];
}


@end
