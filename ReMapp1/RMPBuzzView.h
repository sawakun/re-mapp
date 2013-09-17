//
//  RMPBuzzView.h
//  ReMapp1
//
//  Created by nishiba on 2013/09/15.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "RMPPlaceView.h"

@interface RMPBuzzView : RMPPlaceView
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *buzzImageView;
@property (weak, nonatomic) IBOutlet UILabel *buzzBodyLabel;

@end
