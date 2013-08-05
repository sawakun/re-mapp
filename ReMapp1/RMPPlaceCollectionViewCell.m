//
//  RMPPlaceCollectionViewCell.m
//  ReMapp1
//
//  Created by nishiba on 2013/08/05.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "RMPPlaceCollectionViewCell.h"
#import "RMPBuzzCollectionViewCell.h"
#import "RMPPlayCollectionViewCell.h"
#import "RMPEatCollectionViewCell.h"
#import "RMPShopCollectionViewCell.h"
#import "RMPPlace.h"

@implementation RMPPlaceCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)initWithPlace:(RMPPlace *)place
{
}

@end


@implementation RMPPlaceCollectionViewCellFactory
+ (RMPPlaceCollectionViewCell *)createCellWithCollectionView:(UICollectionView *)collectionView
                                      cellForItemAtIndexPath:(NSIndexPath *)indexPath
                                                       place:(RMPPlace *)place
{
    static NSString *buzzCellIdentifier = @"RMPBuzzCollectionViewCell";
    static NSString *shopCellIdentifier = @"RMPShopCollectionViewCell";
    static NSString *eatCellIdentifier = @"RMPEatCollectionViewCell";
    static NSString *playCellIdentifier = @"RMPPlayCollectionViewCell";

    // !!NEED REFACTERING!!
    if ([place isKindOfClass:[RMPBuzzPlace class]]) {
        RMPBuzzCollectionViewCell *cell = (RMPBuzzCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:buzzCellIdentifier forIndexPath:indexPath];
        [cell setValuesWithBuzz:(RMPBuzzPlace *)place];
        return cell;
    }
    else if ([place isKindOfClass:[RMPShopPlace class]]) {
        RMPShopCollectionViewCell *cell = (RMPShopCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:shopCellIdentifier forIndexPath:indexPath];
        //[cell setValuesWithBuzz:(RMPBuzzPlace *)place];
        return cell;

    }
    else if ([place isKindOfClass:[RMPEatPlace class]]) {
        RMPEatCollectionViewCell *cell = (RMPEatCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:eatCellIdentifier forIndexPath:indexPath];
        //[cell setValuesWithBuzz:(RMPBuzzPlace *)place];
        return cell;

    }
    else if ([place isKindOfClass:[RMPPlayPlace class]]) {
        RMPPlayCollectionViewCell *cell = (RMPPlayCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:playCellIdentifier forIndexPath:indexPath];
        //[cell setValuesWithBuzz:(RMPBuzzPlace *)place];
        return cell;
    
    }
    else {
        NSLog(@"ERROR in RMPPlaceCollectionViewCellFactory!");
    }

    return nil;
}
@end