//
//  ViewController.h
//  ReMapp1
//
//  Created by nishiba on 2013/06/29.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "ECSlidingViewController.h"
#import "RMPAnnotation.h"

@class BuzzData;
@class InfoViewController;
@class BuzzFormViewController;

/** Notification that gets posted when an annotation was selected. */
extern NSString *const MapViewDidSelectAnnotation;
/** Notification that gets posted when the map was reloaded. */
extern NSString *const MapViewDidReload;

@interface MapViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate, UIAlertViewDelegate>
- (IBAction)tappedToCurrentLocation:(id)sender;
@property (nonatomic) BuzzFormViewController *buzzFormViewController;
@property (nonatomic) BuzzData *buzzData;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
- (void)showCenter:(NSInteger)index;
- (void)showAnnotation:(NSInteger)index;
@end

