//
//  RMPBuzzCell.h
//  ReMapp1
//
//  Created by Masahiro Nishiba on 2013/07/20.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RMPBuzzCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *buzzLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end
