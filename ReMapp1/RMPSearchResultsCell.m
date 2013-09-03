//
//  RMPSearchResultsCell.m
//  ReMapp1
//
//  Created by nishiba on 2013/09/03.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "RMPSearchResultsCell.h"

@implementation RMPSearchResultsCell

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (!self) {
        
    }
    return self;
}

- (void)setTitleText:(NSString *)titleText
{
    self.titleLabel.text = titleText;
}

- (NSString*)titleText
{
    return self.titleLabel.text;
}

@end
