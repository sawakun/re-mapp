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


@implementation RMPBuzzCollectionViewCell
static CGPoint _currentLikeAndMuteViewCenter;

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
        [self setUp];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setUp];
    }
    NSLog(@"initWithCoder %@, %@", self.likeAndMuteView, self.iconImageView);
    return self;
}

- (void)setUp
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(frameDidMove:)
                                                 name:RMPPlaceViewControllerFrameDidMove
                                               object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(frameDidMove:)
                                                 name:RMPSlidingViewBottomViewDidMove
                                               object:nil];
}

- (void)configureLayout
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _currentLikeAndMuteViewCenter = CGPointMake(self.frame.size.width / 2.0, self.frame.size.height - self.likeAndMuteView.frame.size.height / 2.0);
    });
    NSLog(@"_currentLikeAndMuteViewCenter:%f",_currentLikeAndMuteViewCenter.y);
    self.likeAndMuteView.layer.position = _currentLikeAndMuteViewCenter;
}

- (void)frameDidMove:(NSNotification *)center
{
    CGFloat originY = [center.userInfo[@"frame.origin.y"] floatValue];
    CGFloat newCenterY = originY;
    if (originY < 320) {
        newCenterY = self.frame.size.height - originY - self.likeAndMuteView.frame.size.height / 2.0;
    }
    CGPoint newCenter = CGPointMake(self.frame.size.width / 2.0, newCenterY);
    self.likeAndMuteView.layer.position = newCenter;
    _currentLikeAndMuteViewCenter = newCenter;

}

- (void)setValuesWithBuzz:(RMPBuzzPlace *)buzz
{
     [self configureLayout];
     self.nameLabel.text = buzz.userName;
     self.bodyLabel.text = buzz.text;
     self.timeLabel.text = buzz.date;
     
     self.iconImageView.image = buzz.iconImage;
//     if (self.iconImageView.image == nil) {
//     [self downloadIconImage:buzz forIndexPath:indexPath];
//     }
     
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