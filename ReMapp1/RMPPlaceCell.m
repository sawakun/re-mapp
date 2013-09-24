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
#import "UIImageView+WebCache.h"

@implementation RMPPlaceCell
+ (CGFloat)heightForPlace:(RMPPlace *)place
{
        
    CGSize maximumLabelSize = CGSizeMake(245,9999);
    
    UIFont *cellFont = [UIFont systemFontOfSize:14];
    CGSize expectedLabelSize = [place.buzzBody sizeWithFont:cellFont
                                         constrainedToSize:maximumLabelSize
                                             lineBreakMode:NSLineBreakByWordWrapping];
    
    //adjust the label the the new height.
    return expectedLabelSize.height + 55.0f;
}


- (void)setDataWithPlace:(RMPPlace *)place
{
    self.userNameLabel.text = place.userName;
    self.buzzBodyLabel.text = place.buzzBody;
    
    // NSDateFormatter
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY/MM/dd hh:mm:ss"];
    self.timeLabel.text = [formatter stringFromDate:place.time];
    
    [self.userImageView setImageWithURL:[NSURL URLWithString:place.userImgURL]
                       placeholderImage:[UIImage imageNamed:@"NO_IMAGE.png"]];
    
}


@end




@implementation RMPPlaceCellFactory
+ (RMPPlaceCell *)createCellWithCollectionView:(UICollectionView *)collectionView
                                              cellForItemAtIndexPath:(NSIndexPath *)indexPath
                                                               place:(RMPPlace *)place
{
    RMPPlaceCell *cell = (RMPPlaceCell *)[collectionView dequeueReusableCellWithReuseIdentifier:[[place class] timeLineCellIdentifier]
                                                                                   forIndexPath:indexPath];
    [cell setDataWithPlace:place];
    return cell;
}
@end