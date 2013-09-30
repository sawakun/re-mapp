//
//  RMPPlaceViewController.m
//  ReMapp1
//
//  Created by nishiba on 2013/08/04.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "RMPPlaceViewController.h"
#import "RMPSlidingViewController.h"
#import "RMPPlaceData.h"
#import "RMPMapPlaceData.h"
#import "RMPMapView.h"
#import "RMPPlace.h"
#import "RMPPlaceMapCell.h"
#import "constants.h"

NSString *const RMPPlaceViewControllerFrameDidMove = @"RMPPlaceViewControllerFrameDidMove";
NSString *const RMPPlaceCollectionViewCellDidMove = @"RMPPlaceCollectionViewCellDidMove";


@interface RMPPlaceViewController() <RMPSlidingBottomViewDelegate> {
    RMPSlidingViewController *_slidingViewController;
}
@property (weak, nonatomic) RMPPlaceData *placeData;
@end

@implementation RMPPlaceViewController

- (void)viewDidLoad
{
	// Do any additional setup after loading the view.
    UITapGestureRecognizer *singleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedView:)];
    [self.view addGestureRecognizer:singleTapGesture];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.placeData = (RMPPlaceData*)[RMPMapPlaceData sharedManager];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showCell:) name:RMPMapViewDidSelectAnnotation object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reload) name:RMPBuzzMapDataReloaded object:self.placeData];

    [self.collectionView removeGestureRecognizer:self.rmp_slidingViewController.bottomPanGesture];

    // set nib
    /*
    UINib *buzzCell = [UINib nibWithNibName:@"RMPBuzzDetailCell" bundle:nil];
    UINib *shopCell = [UINib nibWithNibName:@"RMPShopDetailCell" bundle:nil];
    UINib *eatCell  = [UINib nibWithNibName:@"RMPEatDetailCell"  bundle:nil];
    UINib *playCell = [UINib nibWithNibName:@"RMPPlayDetailCell" bundle:nil];
    [self.collectionView registerNib:buzzCell forCellWithReuseIdentifier:@"RMPBuzzDetailCell"];
    [self.collectionView registerNib:shopCell forCellWithReuseIdentifier:@"RMPShopDetailCell"];
    [self.collectionView registerNib:eatCell  forCellWithReuseIdentifier:@"RMPEatDetailCell"];
    [self.collectionView registerNib:playCell forCellWithReuseIdentifier:@"RMPPlayDetailCell"];
    */
    
    UINib *buzzCell = [UINib nibWithNibName:@"RMPBuzzMapCell" bundle:nil];
    [self.collectionView registerNib:buzzCell forCellWithReuseIdentifier:@"RMPBuzzMapCell"];

    
    CGFloat height =  self.view.frame.size.height;
    CGFloat width = self.view.frame.size.width;
    [self.collectionView setFrame:CGRectMake(0, 0, width, height)];
    [self.collectionView setContentSize:CGSizeMake(width, height)];
    [self.flowLayout setItemSize:CGSizeMake(width, height)];
}


- (void)frameDidMove
{
    // post notification
    NSDictionary *userInfo = @{@"frame.origin.y":[NSNumber numberWithFloat:self.view.frame.origin.y]};
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:RMPPlaceViewControllerFrameDidMove
                                                            object:self
                                                          userInfo:userInfo];

    });
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void) tappedView:(UIGestureRecognizer*)recognizer
{

    if (self.view.frame.origin.y >= 320.0) {
        CGRect newFrame = CGRectMake(self.view.frame.origin.x,  self.view.frame.size.height - SECOND_MAP_CELL_HEIGHT, self.view.frame.size.width, self.view.frame.size.height);
        self.view.frame = newFrame;
        [self frameDidMove];
    }
}


- (void)reload
{
    [self.collectionView reloadData];
}


- (void)showCell:(NSNotification *)center
{
    NSInteger annotationIndex = [center.userInfo[@"annotationIndex"] intValue];
    CGFloat offset = self.collectionView.frame.size.width * annotationIndex;
    CGPoint newPoint = CGPointMake(offset, self.collectionView.contentOffset.y);
    self.collectionView.contentOffset = newPoint;
}

#pragma mark - RMPSlidingBottomViewDelegate

- (void)bottomViewDidMove:(CGFloat)verticalCenter
{
    
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = scrollView.frame.size.width;
    int fractionalPage = MAX(scrollView.contentOffset.x / pageWidth, 0);
    
    //post notification
    NSDictionary *userInfo = @{@"annotationIndex":[NSNumber numberWithInteger:fractionalPage]};
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:RMPPlaceCollectionViewCellDidMove
                                                            object:self
                                                          userInfo:userInfo];
    });
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return self.placeData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RMPPlace *place = [self.placeData placeAtIndex:indexPath.row];
    
    return [RMPPlaceMapCellFactory createCellWithCollectionView:collectionView
                                         cellForItemAtIndexPath:indexPath
                                                          place:place];
}


@end
