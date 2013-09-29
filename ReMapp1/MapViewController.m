//
//  ViewController.m
//  ReMapp1
//
//  Created by nishiba on 2013/06/29.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "MapViewController.h"
#import "RMPMapPlaceData.h"
#import "RMPPlace.h"
#import "BuzzFormViewController.h"
#import "RMPAnnotation.h"
#import "RMPSlidingViewController.h"
#import "RMPAnnotation.h"
#import "RMPMapView.h"
#import "RMPPlaceViewController.h"
#import "RMPPlaceData.h"
#import "RMPHTTPConnection.h"
#import "RMPSearchResultsCollectionView.h"
#import "RMPImageEffect.h"
#import "RMPMovingImageView.h"

@interface MapViewController () {
    RMPMovingImageView *_writeImageView;
    UIImageView *_monochromeMapView;
    CGFloat offsetImageView;
}
@end

NSString *const MapViewDidReload = @"MapViewDidReload";

@implementation MapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //set BuzzData
    self.buzzData = [RMPMapPlaceData sharedManager];

    // set Map
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = 35.6584;
    zoomLocation.longitude = 139.7017;
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 3000.0, 3000.0);
    [self.mapView setRegion:viewRegion animated:NO];
    self.mapView.showsUserLocation = NO;
    
    // set BuzzForm
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
    self.buzzFormViewController = [storyboard instantiateViewControllerWithIdentifier:@"BuzzForm"];
    
    // related to serach bar
    self.searchBar.delegate = self;
    self.searchBar.delegate = self;
    
    // related to search results view
    self.searchResultsCollectionView.mapDelegate = self;
    
    // regist UIGestureRecognizer
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.minimumPressDuration = 1.0;
    [self.mapView addGestureRecognizer:lpgr];
    [self.rightScratchView addGestureRecognizer:self.rmp_verticalSlidingViewController.rightPanGesture];
    [self.leftScratchView addGestureRecognizer:self.rmp_verticalSlidingViewController.leftPanGesture];

    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(showAnnotationWhenReceiveNotification:)
                                                 name:RMPPlaceCollectionViewCellDidMove
                                               object:nil];
    
    //set the map delegate
    self.mapView.delegate = self.mapView;
    
    //set sliding view delegate
    self.rmp_verticalSlidingViewController.delegate = self;
    self.maskView.alpha = 0;
 
    //set notifications related to the map
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(showInfoView)
                                                 name:RMPMapViewDidSelectAnnotation
                                               object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(hideInfoView)
                                                 name:RMPMapViewRegionDidChangeAnimated
                                               object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reload)
                                                 name:RMPBuzzMapDataReloaded
                                               object:self.buzzData];
    
    // For write form
    _monochromeMapView = [[UIImageView alloc] initWithFrame:self.mapView.frame];
    RMPWriteFormAnnotation *writeAnnotation = [[RMPWriteFormAnnotation alloc] init];
    _writeImageView = [[RMPMovingImageView alloc] initWithFrame:CGRectMake(0, 0, writeAnnotation.pinImage.size.width, writeAnnotation.pinImage.size.height)];
    _writeImageView.image = writeAnnotation.pinImage;
    _writeImageView.centerOffset = writeAnnotation.centerOffset;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)showInfoView
{
    if (!self.rmp_verticalSlidingViewController.isBottomViewShowing) {
        [self.rmp_verticalSlidingViewController anchorBottomViewTo:RMPMiddle];
    }
}

- (void)hideInfoView
{
    if (self.rmp_verticalSlidingViewController.isBottomViewShowing) {
        [self.rmp_verticalSlidingViewController anchorBottomViewTo:RMPBottom];
    }
}



- (void)showCenter:(NSInteger)index
{
    RMPPlace *buzz = [_buzzData placeAtIndex:index];
    CLLocationCoordinate2D centerLocation;
    centerLocation.latitude = buzz.lat;
    centerLocation.longitude = buzz.lon;
    [self.mapView setCenterCoordinate:centerLocation animated:YES];
}

- (void)showAnnotation:(NSInteger)index
{
    RMPPlace *buzz = [_buzzData placeAtIndex:index];
    [_mapView selectAnnotation:buzz.annotation animated:NO];
}

- (void)showAnnotationWhenReceiveNotification:(NSNotification *)center
{
    [self showAnnotation:[center.userInfo[@"annotationIndex"] intValue]];
}




/**
    Drag writeFormPin.
    When dragging ends, show write form view.
 */
- (void)handleLongPress:(UIGestureRecognizer *)gestureRecognizer
{
    // values to displace pin
    static const CGFloat offset = 100.0f;
    
    CGPoint tapPoint = [gestureRecognizer locationInView:self.mapView];
    tapPoint.y -= offset;
 
    // Dragging ended.
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded)
    {
        
        // get corordinate which the pin is pointing at
        CLLocationCoordinate2D touchMapCoordinate
            = [self.mapView convertPoint:tapPoint toCoordinateFromView:_mapView];
        // show buzz form
        [self showBuzzForm:touchMapCoordinate];
        // remove filter from map view
        [_monochromeMapView removeFromSuperview];
        [_writeImageView removeFromSuperview];
        return;
    }
    
    // Dragging starts
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        // add filter to map view
        // transform map view to image
        UIImage *mapImage = [RMPImageEffect imageWithView:self.mapView];
        // make map image to be monochrome
        UIImage *monochromeMapImage = [RMPImageEffect monochromeImageWithImage:mapImage];
        _monochromeMapView.frame = self.mapView.frame;
        _monochromeMapView.image = monochromeMapImage;
        [self.view addSubview:_monochromeMapView];
        [self.view addSubview:_writeImageView];
    }
    
    // Dragging continues.
    [_writeImageView moveToPosition:tapPoint];
}

- (void)reload
{
    NSMutableArray *annotations = [self.buzzData annotations];
    //NSArray *oldAnnotations = self.mapView.annotations;
    NSMutableArray *oldAnnotations = [self.mapView.annotations mutableCopy];
    [oldAnnotations removeObjectsInArray:annotations];
    [_mapView addAnnotations:annotations];
    [_mapView removeAnnotations:oldAnnotations];
    NSLog(@"Call 'reload' in MapViewController with Annoations(%d).", annotations.count);
}


- (IBAction)tappedToCurrentLocation:(id)sender {
    self.mapView.showsUserLocation = YES;
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    [locationManager startUpdatingLocation];
    self.mapView.centerCoordinate = locationManager.location.coordinate;
    [locationManager stopUpdatingLocation];
    [NSTimer scheduledTimerWithTimeInterval:5.0f
                                     target:self
                                   selector:@selector(stopShowUserLocation:)
                                   userInfo:nil
                                    repeats:NO];
}

- (void)stopShowUserLocation:(NSTimer *)timer
{
    self.mapView.showsUserLocation = NO;
}

- (void)searchResultsViewDisappear
{
    [UIView animateWithDuration:0.3f animations:^{self.searchResultsView.alpha = 0.0f;} completion:nil];
    [self.searchBar setShowsCancelButton:NO animated:YES];
}

#pragma mark - Buzz Form

- (void)showBuzzForm:(CLLocationCoordinate2D)tapPoint
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
    BuzzFormViewController *buzzFormViewController = [storyboard instantiateViewControllerWithIdentifier:@"BuzzForm"];
    buzzFormViewController.location = tapPoint;
    [self presentViewController:buzzFormViewController animated:YES completion:NULL];
}


#pragma mark - RMPSearchResultsCollectionViewDelegate

- (void)moveMapWithLon:(CGFloat)lon Lat:(CGFloat)lat
{
    CLLocationCoordinate2D centerLocation;
    centerLocation.latitude = lat;
    centerLocation.longitude = lon;
    [self.mapView setCenterCoordinate:centerLocation animated:YES];
    [self searchResultsViewDisappear];
    [self.searchBar resignFirstResponder];
}



#pragma mark - UISearchBarDelsegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [UIView animateWithDuration:0.3f animations:^{
        self.searchResultsView.alpha = 1.0f;
    } completion:nil];
    [searchBar setShowsCancelButton:YES animated:YES];
    return;
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    //[self searchResultsViewDisappear];
    return;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    [self searchResultsViewDisappear];
}

- (void) searchBarSearchButtonClicked: (UISearchBar *) searchBar {
    [self.activityIndicatorView startAnimating];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
        [self.searchResultsCollectionView searchPointOfInterest:searchBar.text];
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.searchResultsCollectionView reloadData];
            [self.activityIndicatorView stopAnimating];
            [self.searchBar resignFirstResponder];
        });
    });
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    self.searchResultsCollectionView.searchResults = nil;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}


#pragma mark - RMPSlidingViewDelegate
- (void)leftViewDidMove:(CGFloat)horizontalCenter
{
//    self.maskView.alpha = 0.00000976562 * (horizontalCenter + 160) * (horizontalCenter + 160);
}



@end
