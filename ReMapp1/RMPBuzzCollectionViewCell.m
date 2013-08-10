//
//  RMPBuzzCollectionViewCell.m
//  ReMapp1
//
//  Created by nishiba on 2013/08/04.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "RMPBuzzCollectionViewCell.h"
#import "RMPPlaceViewController.h"
#import "RMPSlidingViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation RMPBuzzCollectionViewCell

#pragma mark - initialization

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
    }
    return self;
}


- (void)setValuesWithBuzz:(RMPBuzzPlace *)buzz
{
     self.nameLabel.text = buzz.userName;
     self.bodyLabel.text = buzz.text;
     self.timeLabel.text = buzz.date;
    
    [self.iconImageView setImageWithURL:[NSURL URLWithString:buzz.iconURL]
                       placeholderImage:[UIImage imageNamed:@"NO_IMAGE.png"]];
    
    [self.buzzImageView setImageWithURL:[NSURL URLWithString:buzz.imageURL]
                       placeholderImage:[UIImage imageNamed:@"NO_IMAGE.png"]];
 
    // set image for like and mute button.
    UIImage *likeImage = [UIImage imageNamed:@"LIKE_BUTTON.png"];
    UIImage *likedImage = [UIImage imageNamed:@"LIKED_BUTTON.png"];
    UIImage *muteImage = [UIImage imageNamed:@"MUTE_BUTTON.png"];
    UIImage *mutedImage = [UIImage imageNamed:@"MUTED_BUTTON.png"];
    
     
     if (buzz.isLiked) {
         [self.likeButton setImage:likedImage forState:UIControlStateNormal];
         [self.likeButton setImage:likeImage forState:UIControlStateHighlighted];
     } else {
         [self.likeButton setImage:likeImage forState:UIControlStateNormal];
         [self.likeButton setImage:likedImage forState:UIControlStateHighlighted];
     }
     
     if (buzz.isMuted) {
         [self.muteButton setImage:mutedImage forState:UIControlStateNormal];
         [self.muteButton setImage:muteImage forState:UIControlStateHighlighted];
     } else {
         [self.muteButton setImage:muteImage forState:UIControlStateNormal];
         [self.muteButton setImage:mutedImage forState:UIControlStateHighlighted];
     }
}

@end