//
//  RMPTrimImageViewController.m
//  ReMapp1
//
//  Created by nishiba on 2013/09/28.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "RMPTrimImageViewController.h"
#import "RMPPickImageViewController.h"
#import "UIImage+Trim.h"

@interface RMPTrimImageViewController ()
{
    CGFloat _head;
    CGFloat _tail;
    CGFloat _imageScale;
}
@end

@implementation RMPTrimImageViewController

- (void)setup {
    _head = 60.0f;
    _tail = 0.0f;
    self.imageView = [[UIImageView alloc] init];
    self.trimmedImage = [[UIImage alloc] init];
}
- (id)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.scrollView.delegate         = self;
    [self.scrollView addSubview:self.imageView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];

    // set scal limit for scroll view
    self.scrollView.frame = self.view.frame;
    self.scrollView.minimumZoomScale = 1;
    self.scrollView.maximumZoomScale = 4.0;
    
    // set tail
    _tail = self.view.frame.size.height - self.view.frame.size.width - _head - 20.0f;

    // set image view frame
    CGSize imageSize = self.imageView.image.size;
    CGRect newImageViewFrame = self.scrollView.frame;
    _imageScale = newImageViewFrame.size.width / imageSize.width;
    newImageViewFrame.size.height = imageSize.height * _imageScale;
    self.imageView.frame = CGRectMake(0, _head,  newImageViewFrame.size.width,  newImageViewFrame.size.height);
    
    // adjust scroll view size and position
    CGSize size = self.imageView.frame.size;
    size.height += _tail + _head;
    self.scrollView.contentSize = size;
    self.scrollView.contentOffset = CGPointMake(0, _head);
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.scrollView.zoomScale = 1.0;
    [self.navigationController setNavigationBarHidden:NO];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"RMPTrimImageViewControllerWillDisappear" object:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    CGSize size = self.imageView.frame.size;
    size.height += _tail + _head;
    self.scrollView.contentSize = size;
}

- (IBAction)tappedChoose:(id)sender {
    // trim image
    CGPoint offset = self.scrollView.contentOffset;
    CGFloat zoomScale = self.scrollView.zoomScale;
    CGFloat adjustScale = 1.0 / zoomScale / _imageScale;
    CGFloat imageSize = self.scrollView.frame.size.width * adjustScale;
    CGFloat imageX = (offset.x) * adjustScale;
    CGFloat imageY = (offset.y + 20.0f) * adjustScale;
    
    NSLog(@"%f, %f", imageX, imageY);
    self.trimmedImage = [self.imageView.image trimWithRect:CGRectMake(imageX, imageY, imageSize, imageSize)];
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)tappedCancel:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
