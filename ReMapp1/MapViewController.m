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
#import "Buzz.h"
#import "BuzzFormViewController.h"
#import "RMPAnnotation.h"
#import "RMPSlidingViewController.h"
#import "InfoViewController.h"
#import "RMPAnnotation.h"
#import "RMPNonVisibleSearchBar.h"
#import "RMPMapView.h"

@interface MapViewController ()

@end

NSString *const MapViewDidReload = @"MapViewDidReload";

@implementation MapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // set Map
    //self.mapView.delegate = self;
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = 35.6584;
    zoomLocation.longitude = 139.7017;
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 10000.0, 10000.0);
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
                                             selector:@selector(reload)
                                                 name:RMPMapViewRegionDidChangeAnimated
                                               object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(hideInfoView)
                                                 name:RMPMapViewRegionDidChangeAnimated
                                               object:nil];
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //set BuzzData
    self.buzzData = [RMPBuzzData sharedManager];
    [self reload];
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
    Buzz *buzz = [_buzzData buzzAtIndex:index];
    CLLocationCoordinate2D centerLocation;
    centerLocation.latitude = buzz.lat;
    centerLocation.longitude = buzz.lot;
    [self.mapView setCenterCoordinate:centerLocation animated:YES];
}

- (void)showAnnotation:(NSInteger)index
{
    Buzz *buzz = [_buzzData buzzAtIndex:index];
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
    CGPoint northEast = CGPointMake(self.view.bounds.origin.x+self.view.bounds.size.width,
                                    self.view.bounds.origin.y);
    CLLocationCoordinate2D neCoordinate = [_mapView convertPoint:northEast toCoordinateFromView:_mapView];
    
    CGPoint southWest = CGPointMake(self.view.bounds.origin.x,
                                    self.view.bounds.origin.y+self.view.bounds.size.height);
    CLLocationCoordinate2D swCoordinate = [_mapView convertPoint:southWest toCoordinateFromView:_mapView];
    
    [_buzzData reloadWithNorthEastCordinate:neCoordinate SouthWestCoordinate:swCoordinate];
    
    NSMutableArray *annotations = [NSMutableArray array];
    for (Buzz *buzz in _buzzData.buzzes)
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
    [[self view] endEditing:YES];
}

@end
