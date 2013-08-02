//
//  ViewController.m
//  ReMapp1
//
//  Created by nishiba on 2013/06/29.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "MapViewController.h"
#import "InfoViewController.h"
#import "RMPBuzzData.h"
#import "RMPPlace.h"
#import "BuzzFormViewController.h"
#import "RMPAnnotation.h"
#import "RMPSlidingViewController.h"
#import "InfoViewController.h"
#import "RMPAnnotation.h"
#import "RMPNonVisibleSearchBar.h"
#import "RMPMapView.h"

// TEST
@interface NSObject (Extension)
- (void)performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay;
@end

// TEST
@implementation NSObject (Extension)
- (void)performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay
{
    [self performSelector:@selector(executeBlock__:)
               withObject:[block copy]
               afterDelay:delay];
}

- (void)executeBlock__:(void (^)(void))block
{
    block();
}
@end

@interface MapViewController ()

@end

NSString *const MapViewDidReload = @"MapViewDidReload";

@implementation MapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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
    
    // regist UIGestureRecognizer
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.minimumPressDuration = 1.0;
    [self.mapView addGestureRecognizer:lpgr];
    [self.rightScratchView addGestureRecognizer:self.rmp_verticalSlidingViewController.rightPanGesture];
    [self.leftScratchView addGestureRecognizer:self.rmp_verticalSlidingViewController.leftPanGesture];

    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(showAnnotationWhenReceiveNotification:)
                                                 name:InfoCellDidMove
                                               object:nil];
    
    //set the map delegate
    self.mapView.delegate = self.mapView;
 
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
                                                 name:RMPBuzzDataReloaded
                                               object:self.buzzData];
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //set BuzzData
    self.buzzData = [RMPBuzzData sharedManager];
    // TEST
    //[self test];
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
    RMPBuzzPlace *buzz = [_buzzData buzzAtIndex:index];
    CLLocationCoordinate2D centerLocation;
    centerLocation.latitude = buzz.lat;
    centerLocation.longitude = buzz.lot;
    [self.mapView setCenterCoordinate:centerLocation animated:YES];
}

- (void)showAnnotation:(NSInteger)index
{
    RMPBuzzPlace *buzz = [_buzzData buzzAtIndex:index];
    [_mapView selectAnnotation:buzz.annotation animated:NO];
}

- (void)showAnnotationWhenReceiveNotification:(NSNotification *)center
{
    [self showAnnotation:[center.userInfo[@"annotationIndex"] intValue]];
}


- (void)showBuzzForm:(CLLocationCoordinate2D)tapPoint
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
    BuzzFormViewController *buzzFormViewController = [storyboard instantiateViewControllerWithIdentifier:@"BuzzForm"];
    buzzFormViewController.location = tapPoint;
    [self presentViewController:buzzFormViewController animated:YES completion:NULL];
}

- (void)handleLongPress:(UIGestureRecognizer *)gestureRecognizer
{
    static RMPWriteFormAnnotation *annotation;
    
    CGPoint tapPoint = [gestureRecognizer locationInView:self.mapView];
    CLLocationCoordinate2D touchMapCoordinate = [self.mapView convertPoint:tapPoint toCoordinateFromView:_mapView];
    
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded)
    {
        [self showBuzzForm:touchMapCoordinate];
        [self.mapView removeAnnotation:annotation];
        return;
    }
    
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        annotation = [[RMPWriteFormAnnotation alloc] init];
    }
    
    annotation.coordinate = touchMapCoordinate;
    [self.mapView addAnnotation:annotation];
}

- (void)reload
{

    NSMutableArray *annotations = [NSMutableArray array];
    for (RMPBuzzPlace *buzz in _buzzData.buzzes)
    {
        [annotations addObject:buzz.annotation];
    }
    [_mapView removeAnnotations:_mapView.annotations];
    [_mapView addAnnotations:annotations];
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

#pragma mark - UISearchBar

- (void) searchBarSearchButtonClicked: (UISearchBar *) searchBar {
    [searchBar resignFirstResponder];
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)test
{
     // TEST
     [self performBlock:^(void){
     double lat1 = 35.6584;
     double lot1 = 139.7017;
     double lat2 = lat1 - 1;
     double lot2 = lot1 - 2;
     NSDictionary *userInfo = @{@"northEastLat":[NSNumber numberWithDouble:lat1],
     @"northEastLot":[NSNumber numberWithDouble:lot1],
     @"southWestLat":[NSNumber numberWithDouble:lat2],
     @"southWestLot":[NSNumber numberWithDouble:lot2]};
     
     dispatch_async(dispatch_get_main_queue(), ^{
     [[NSNotificationCenter defaultCenter] postNotificationName:RMPMapViewRegionDidChangeAnimated
     object:nil
     userInfo:userInfo];
     });} afterDelay:1];
     
     
     // TEST
     [self performBlock:^(void){
     double lat1 = 30.6584;
     double lot1 = 130.7017;
     double lat2 = lat1 - 1;
     double lot2 = lot1 - 2;
     NSDictionary *userInfo = @{@"northEastLat":[NSNumber numberWithDouble:lat1],
     @"northEastLot":[NSNumber numberWithDouble:lot1],
     @"southWestLat":[NSNumber numberWithDouble:lat2],
     @"southWestLot":[NSNumber numberWithDouble:lot2]};
     
     dispatch_async(dispatch_get_main_queue(), ^{
     [[NSNotificationCenter defaultCenter] postNotificationName:RMPMapViewRegionDidChangeAnimated
     object:nil
     userInfo:userInfo];
     });} afterDelay:2];
     
     [self performBlock:^(void){
         double lat1 = 35.6584;
         double lot1 = 139.7017;
         double lat2 = lat1 - 1;
         double lot2 = lot1 - 2;
     NSDictionary *userInfo = @{@"northEastLat":[NSNumber numberWithDouble:lat1],
     @"northEastLot":[NSNumber numberWithDouble:lot1],
     @"southWestLat":[NSNumber numberWithDouble:lat2],
     @"southWestLot":[NSNumber numberWithDouble:lot2]};
     
     dispatch_async(dispatch_get_main_queue(), ^{
     [[NSNotificationCenter defaultCenter] postNotificationName:RMPMapViewRegionDidChangeAnimated
     object:nil
     userInfo:userInfo];
     });} afterDelay:3];
     
     
     [self performBlock:^(void){
     double lat1 = 20.6584;
     double lot1 = 120.7017;
     double lat2 = lat1 - 1;
     double lot2 = lot1 - 2;
     NSDictionary *userInfo = @{@"northEastLat":[NSNumber numberWithDouble:lat1],
     @"northEastLot":[NSNumber numberWithDouble:lot1],
     @"southWestLat":[NSNumber numberWithDouble:lat2],
     @"southWestLot":[NSNumber numberWithDouble:lot2]};
     
     dispatch_async(dispatch_get_main_queue(), ^{
     [[NSNotificationCenter defaultCenter] postNotificationName:RMPMapViewRegionDidChangeAnimated
     object:nil
     userInfo:userInfo];
     });} afterDelay:4];

    [self performBlock:^(void){
        double lat1 = 35.6584;
        double lot1 = 139.7017;
        double lat2 = lat1 - 1;
        double lot2 = lot1 - 2;
        NSDictionary *userInfo = @{@"northEastLat":[NSNumber numberWithDouble:lat1],
                                   @"northEastLot":[NSNumber numberWithDouble:lot1],
                                   @"southWestLat":[NSNumber numberWithDouble:lat2],
                                   @"southWestLot":[NSNumber numberWithDouble:lot2]};
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:RMPMapViewRegionDidChangeAnimated
                                                                object:nil
                                                              userInfo:userInfo];
        });} afterDelay:5];
    
    
    [self performBlock:^(void){
        double lat1 = 20.6584;
        double lot1 = 120.7017;
        double lat2 = lat1 - 1;
        double lot2 = lot1 - 2;
        NSDictionary *userInfo = @{@"northEastLat":[NSNumber numberWithDouble:lat1],
                                   @"northEastLot":[NSNumber numberWithDouble:lot1],
                                   @"southWestLat":[NSNumber numberWithDouble:lat2],
                                   @"southWestLot":[NSNumber numberWithDouble:lot2]};
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:RMPMapViewRegionDidChangeAnimated
                                                                object:nil
                                                              userInfo:userInfo];
        });} afterDelay:6];
}

@end
