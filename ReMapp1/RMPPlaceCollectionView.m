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
    static NSString *CellIdentifier = @"RMPBuzzCollectionViewCell";
    RMPPlace *buzz = [_buzzData buzzAtIndex:indexPath.row];
    RMPBuzzCollectionViewCell *cell = (RMPBuzzCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.nameLabel.text = buzz.userName;
    cell.bodyLabel.text = buzz.text;
    [cell.bodyLabel setNumberOfLines:0];
    [cell.bodyLabel sizeToFit];
    cell.timeLabel.text = buzz.date;
    
    cell.iconImageView.image = buzz.iconImage;
    if (cell.iconImageView.image == nil) {
        [self downloadIconImage:buzz forIndexPath:indexPath];
    }
    
    return cell;
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
    [self reloadData];
    NSInteger annotationIndex = [center.userInfo[@"annotationIndex"] intValue];
    CGFloat pageWidth = self.frame.size.width;
    CGPoint newPoint = CGPointMake(pageWidth * annotationIndex, self.contentOffset.y);
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
