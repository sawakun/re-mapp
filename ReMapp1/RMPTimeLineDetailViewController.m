//
//  RMPTimeLineDetailViewController.m
//  ReMapp1
//
//  Created by nishiba on 2013/08/09.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "RMPTimeLineDetailViewController.h"
#import "RMPBuzzData.h"
#import "RMPPlace.h"
#import "RMPPlaceTimeLineDetailCell.h"

@interface RMPTimeLineDetailViewController ()
@property CGRect hideFrame;
@property (nonatomic) UIPanGestureRecognizer *panGesture;
@end

@implementation RMPTimeLineDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGRect bounds = self.view.bounds;
    self.hideFrame = CGRectMake(bounds.origin.x + bounds.size.width, bounds.origin.y, bounds.size.width, bounds.size.height);
    self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                              action:nil];
    [self.view addGestureRecognizer:self.panGesture];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setPlace:(RMPPlace *)place
{
    [self.timeLineDetailCollectionView reloadData];
    _place = place;
}


- (IBAction)tappedToHide:(id)sender {
    [UIView animateWithDuration:0.4f animations:^{
        [self.view setFrame:self.hideFrame];
    } completion:nil];
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (self.place == nil) {
        return 0;
    }
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [RMPPlaceTimeLineDetailCellFactory createCellWithCollectionView:collectionView
                                              cellForItemAtIndexPath:indexPath
                                                               place:self.place];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout  *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(320, self.place.heightForDetailCell);
}
@end
