//
//  RMPJudgeButton.h
//  ReMapp1
//
//  Created by nishiba on 2013/10/04.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RMPJudgeButton : UIButton
@property (nonatomic) BOOL isJudged;
- (void)changeJudgement;
@end
