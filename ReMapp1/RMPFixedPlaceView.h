//
//  RMPBuzzView.h
//  ReMapp1
//
//  Created by nishiba on 2013/09/15.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "RMPPlaceView.h"

@interface RMPFixedPlaceView : RMPPlaceView
@property (weak, nonatomic) IBOutlet UIImageView *buzzImageView;
@property (weak, nonatomic) IBOutlet UILabel *buzzBodyLabel;

@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *siteURLLabel;

@end
