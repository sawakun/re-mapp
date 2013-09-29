//
//  UIImage+_CameraRoll.h
//  ReMapp1
//
//  Created by nishiba on 2013/09/28.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RMPPickImageViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic) UIImage *pickedImage;
-(void)pickImageInCameraRoll;
@end
