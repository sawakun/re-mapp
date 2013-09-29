//
//  RMPTrimImageViewController.h
//  ReMapp1
//
//  Created by nishiba on 2013/09/28.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RMPTrimImageViewController : UIViewController <UIScrollViewDelegate, UINavigationBarDelegate>
@property (nonatomic) UIImageView *imageView;
@property (nonatomic) UIImage *trimmedImage;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
- (IBAction)tappedChoose:(id)sender;
- (IBAction)tappedCancel:(id)sender;

@end
