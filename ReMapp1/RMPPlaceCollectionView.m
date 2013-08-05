//
//  RMPPlaceCollectionView.m
//  ReMapp1
//
//  Created by nishiba on 2013/08/04.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "RMPPlaceCollectionView.h"
#import "RMPBuzzCollectionViewCell.h"
#import "RMPBuzzData.h"
#import "RMPPlace.h"
#import "RMPMapView.h"

NSString *const RMPPlaceCollectionViewCellDidMove = @"RMPPlaceCollectionViewCellDidMove";


@interface RMPPlaceCollectionView()
@property (weak, nonatomic) RMPBuzzData *buzzData;
@end

@implementation RMPPlaceCollectionView

#pragma mark - initialization

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setUp];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)setUp
{
    self.dataSource = self;
    self.delegate = self;
    self.buzzData = [RMPBuzzData sharedManager];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showCell:) name:RMPMapViewDidSelectAnnotation object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reload) name:RMPBuzzDataReloaded object:self.buzzData];
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
    
    return [RMPPlaceCollectionViewCellFactory createCellWithCollectionView:collectionView
                                                    cellForItemAtIndexPath:indexPath
                                                                     place:place];
}

- (void)downloadIconImage:(RMPPlace *)buzz forIndexPath:(NSIndexPath *)indexPath
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSData *iconData = [NSData dataWithContentsOfURL:[NSURL URLWithString:buzz.iconURL]];
        buzz.iconImage = [UIImage imageWithData:iconData];
        RMPBuzzCollectionViewCell *cell = (RMPBuzzCollectionViewCell*)[self cellForItemAtIndexPath:indexPath];
        cell.iconImageView.image= buzz.iconImage;
    });
}

- (void)reload
{
    [self reloadData];
}


- (void)showCell:(NSNotification *)center
{
    // Load the cells of both sides, to arrage layouts correctly.
    static dispatch_once_t onceToken;
    static CGRect bounds;
    dispatch_once(&onceToken, ^{
        CGRect thisBounds = self.bounds;
        bounds = CGRectMake(thisBounds.origin.x + 1, thisBounds.origin.y, thisBounds.size.width - 2, thisBounds.size.height);
    });
    self.bounds = bounds;
    
    
    NSInteger annotationIndex = [center.userInfo[@"annotationIndex"] intValue];
    CGFloat offset = self.frame.size.width * annotationIndex;
    CGPoint newPoint = CGPointMake(offset, self.contentOffset.y);
    self.contentOffset = newPoint;
}


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

@end
