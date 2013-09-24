//
//  RMPShopCell.h
//  ReMapp1
//
//  Created by nishiba on 2013/08/10.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "RMPPlaceCell.h"

@interface RMPShopCell : RMPPlaceCell
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet RMPHeightToFitLabel *buzzBodyLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end
