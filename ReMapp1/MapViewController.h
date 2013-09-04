//
//  ViewController.h
//  ReMapp1
//
//  Created by nishiba on 2013/06/29.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "RMPAnnotation.h"
#import "RMPSlidingViewController.h"
#import "RMPSearchResultsCollectionView.h"

@class RMPMapPlaceData;
@class InfoViewController;
@class BuzzFormViewController;
@class RMPNonVisibleSearchBar;
@class RMPMapView;

/** Notification that gets posted when the map was reloaded. */
extern NSString *const MapViewDidReload;

@interface MapViewController : UIViewController <CLLocationManagerDelegate, UIAlertViewDelegate,
RMPSlidingViewDelegate, RMPSearchResultsCollectionViewDelegate, UISearchBarDelegate>

- (IBAction)tappedToCurrentLocation:(id)sender;
@property (nonatomic) BuzzFormViewController *buzzFormViewController;
@property (nonatomic) RMPMapPlaceData *buzzData;
@property (weak, nonatomic) IBOutlet UIView *rightScratchView;
@property (weak, nonatomic) IBOutlet UIView *leftScratchView;
@property (weak, nonatomic) IBOutlet RMPMapView *mapView;
@property (weak, nonatomic) IBOutlet RMPNonVisibleSearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIView *searchResultsView;


@property (weak, nonatomic) IBOutlet UIView *maskView;
@property (weak, nonatomic) IBOutlet RMPSearchResultsCollectionView *searchResultsCollectionView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;

- (void)showCenter:(NSInteger)index;
- (void)showAnnotation:(NSInteger)index;
- (void)moveMapWithLon:(CGFloat)lon Lat:(CGFloat)lat;
- (void)searchResultsViewDisappear;
@end

