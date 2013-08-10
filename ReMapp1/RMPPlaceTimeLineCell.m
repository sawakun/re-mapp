//
//  RMPPlaceTimeLineCollectionViewCell.m
//  ReMapp1
//
//  Created by nishiba on 2013/08/08.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "RMPPlaceTimeLineCell.h"
#import "RMPBuzzTimeLineCell.h"
#import "RMPPlace.h"


@implementation RMPPlaceTimeLineCell
+ (CGFloat)heightForPlace:(RMPPlace *)place
{
    return 100.0f;
}

- (void)setDataWithPlace:(RMPPlace *)place
{

}

@end




@implementation RMPPlaceTimeLineCellFactory
+ (RMPPlaceTimeLineCell *)createCellWithCollectionView:(UICollectionView *)collectionView
                                              cellForItemAtIndexPath:(NSIndexPath *)indexPath
                                                               place:(RMPPlace *)place
{
    RMPPlaceTimeLineCell *cell = (RMPPlaceTimeLineCell *)[collectionView
                                                          dequeueReusableCellWithReuseIdentifier:[[place class] timeLineCellIdentifier]
                                                          forIndexPath:indexPath];
    [cell setDataWithPlace:place];
    return cell;
}
@end