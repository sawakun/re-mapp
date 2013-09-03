//
//  RMPSearchResultsCollectionView.m
//  ReMapp1
//
//  Created by nishiba on 2013/09/02.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "RMPSearchResultsCollectionView.h"
#import "RMPHTTPConnection.h"
#import "RMPSearchResultsCell.h"
#import "MapViewController.h"

@interface RMPSearchResultsCollectionView()
@end

@implementation RMPSearchResultsCollectionView

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
        self.delegate = self;
        self.dataSource = self;
        self.searchResults = nil;
        UINib *cell = [UINib nibWithNibName:@"RMPSearchResultsCell" bundle:nil];
        [self registerNib:cell forCellWithReuseIdentifier:@"RMPSearchResultsCell"];
    }
    return self;
}

- (void) setSearchResults:(NSArray*)newSearchResults {
    _searchResults = newSearchResults;
    [self reloadData];
}

- (void)searchPointOfInterest:(NSString*)key
{
    self.searchResults = [RMPHTTPConnection searchPointOfInterest:key];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.searchResults count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RMPSearchResultsCell *cell = (RMPSearchResultsCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"RMPSearchResultsCell" forIndexPath:indexPath];
    NSDictionary *thisData = self.searchResults[indexPath.row];
    cell.titleText = thisData[@"user_name"];
    cell.lon = [thisData[@"lon"] floatValue];
    cell.lat = [thisData[@"lat"] floatValue];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *thisData = self.searchResults[indexPath.row];
    [self.mapDelegate moveMapWithLon:[thisData[@"lon"] floatValue] Lat:[thisData[@"lat"] floatValue]];
}


@end
