//
//  RMPPlaceTimeLineCollectionViewCell.m
//  ReMapp1
//
//  Created by nishiba on 2013/08/08.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "RMPPlaceCell.h"
#import "RMPBuzzCell.h"
#import "RMPPlace.h"


@implementation RMPPlaceCell
+ (CGFloat)heightForPlace:(RMPPlace *)place
{
    return 100.0f;
}

- (void)setDataWithPlace:(RMPPlace *)place
{

}

@end




@implementation RMPPlaceCellFactory
+ (RMPPlaceCell *)createCellWithCollectionView:(UICollectionView *)collectionView
                                              cellForItemAtIndexPath:(NSIndexPath *)indexPath
                                                               place:(RMPPlace *)place
{
    RMPPlaceCell *cell = (RMPPlaceCell *)[collectionView
                                                          dequeueReusableCellWithReuseIdentifier:[[place class] timeLineCellIdentifier]
                                                          forIndexPath:indexPath];
    [cell setDataWithPlace:place];
    return cell;
}
@end