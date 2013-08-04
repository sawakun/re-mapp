//
//  RMPPlaceViewController.h
//  ReMapp1
//
//  Created by nishiba on 2013/08/04.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import <UIKit/UIKit.h>

/** Notification that gets posted when frame was moved. */
extern NSString *const RMPPlaceViewControllerFrameDidMove;


@class RMPPlaceCollectionView;
@interface RMPPlaceViewController : UIViewController
@property (weak, nonatomic) IBOutlet RMPPlaceCollectionView *collectionView;

@end
