//
//  RMPPlaceTimeLineDetailCell.m
//  ReMapp1
//
//  Created by nishiba on 2013/08/10.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "RMPPlaceDetailCell.h"
#import "RMPPlace.h"


@implementation RMPPlaceDetailCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setDataWithPlace:(RMPPlace *)place
{
    // set data to screen
}

+ (CGFloat)heightForPlace:(RMPPlace *)place
{
    return 200.0f;
}

@end


@implementation RMPPlaceDetailCellFactory

+ (RMPPlaceDetailCell *)createCellWithCollectionView:(UICollectionView *)collectionView
                                      cellForItemAtIndexPath:(NSIndexPath *)indexPath
                                                       place:(RMPPlace *)place
{
    RMPPlaceDetailCell *cell = (RMPPlaceDetailCell *)[collectionView dequeueReusableCellWithReuseIdentifier:[[place class] detailCellIdentifier] forIndexPath:indexPath];
    [cell setDataWithPlace:place];
    return cell;
}

@end
