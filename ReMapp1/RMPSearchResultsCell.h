//
//  RMPSearchResultsCell.h
//  ReMapp1
//
//  Created by nishiba on 2013/09/03.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RMPSearchResultsCell : UICollectionViewCell
@property (nonatomic) CGFloat lon;
@property (nonatomic) CGFloat lat;
@property (nonatomic) NSString *titleText;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end

