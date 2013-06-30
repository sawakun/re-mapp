//
//  ViewController.h
//  ReMapp1
//
//  Created by nishiba on 2013/06/29.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController <MKMapViewDelegate>
{
    @private
    UIViewController *infoViewController;
    CGPoint hiddenCenter;
    CGPoint lowerCenter;
    CGPoint middleCenter;
    CGPoint upperCenter;
}
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

- (void) moveInfoUp;
- (void) moveInfoDown;

@end
