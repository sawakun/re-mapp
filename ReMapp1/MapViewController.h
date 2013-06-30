//
//  ViewController.h
//  ReMapp1
//
//  Created by nishiba on 2013/06/29.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@class BuzzData;

@interface MapViewController : UIViewController <MKMapViewDelegate>
{
    @private
    UIViewController *_infoViewController;
    CGPoint _hiddenCenter;
    CGPoint _lowerCenter;
    CGPoint _middleCenter;
    CGPoint _upperCenter;
    BuzzData *_buzzData;
}
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

- (void) moveInfoUp;
- (void) moveInfoDown;

@end
