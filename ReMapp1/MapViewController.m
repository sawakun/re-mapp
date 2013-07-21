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

@interface MapViewController ()

@end

NSString *const MapViewDidSelectAnnotation = @"MapViewDidSelectAnnotation";
NSString *const MapViewDidReload = @"MapViewDidReload";

@implementation MapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //set BuzzData
    self.buzzData = [RMPBuzzData sharedManager];
    
    // set Map
    self.mapView.delegate = self;
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
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(showAnnotationWhenReceiveNotification:)
                                                 name:InfoCellDidMove
                                               object:nil];
    [self.rightScratchView addGestureRecognizer:self.rmp_verticalSlidingViewController.rightPanGesture];
    [self.leftScratchView addGestureRecognizer:self.rmp_verticalSlidingViewController.leftPanGesture];
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self reload];
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
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:MapViewDidReload
                                                            object:self
                                                          userInfo:nil];
    });
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    [self reload];
}

- (IBAction)tappedToCurrentLocation:(id)sender {
    //self.mapView.showsUserLocation = YES;
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    [locationManager startUpdatingLocation];
    while (locationManager.location.coordinate.longitude == 0)
    {
        NSLog(@"%f, %f", locationManager.location.coordinate.latitude, locationManager.location.coordinate.longitude);
    }
    NSLog(@"%f, %f", locationManager.location.coordinate.latitude, locationManager.location.coordinate.longitude);
    self.mapView.centerCoordinate = locationManager.location.coordinate;
    [locationManager stopUpdatingLocation];
    //self.mapView.userLocationVisible = NO;
}

#pragma mark - MKMapViewDelegate
-(MKAnnotationView*)mapView:(MKMapView*)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]] ||
        ![annotation isKindOfClass:[RMPAnnotation class]]) {
        return nil;
    }
    
    RMPAnnotation *thisAnnotation = (RMPAnnotation*)annotation;
    NSString* identifier = thisAnnotation.identifier;
    
    MKAnnotationView *annotationView = (MKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if(nil == annotationView) {
        annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        annotationView.image = thisAnnotation.pinImage;
        annotationView.centerOffset = thisAnnotation.centerOffset;
        annotationView.canShowCallout = NO;
    }
    else {
        annotationView.annotation = annotation;
    }
    
    return annotationView;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    
    RMPSelectedAnnotation *selectedAnnotation = [[RMPSelectedAnnotation alloc] init];
    [UIView animateWithDuration:0.2f animations:^{
        view.image = selectedAnnotation.pinImage;
    }];
    
    //post notification
    RMPAnnotation *annotation = (RMPAnnotation *)view.annotation;
    NSDictionary *userInfo = @{@"annotationIndex":[NSNumber numberWithInteger:annotation.index]};
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:MapViewDidSelectAnnotation
                                                            object:self
                                                          userInfo:userInfo];
    });
    
    if (!self.rmp_verticalSlidingViewController.isBottomViewShowing) {
        [self.rmp_verticalSlidingViewController anchorBottomViewTo:RMPMiddle];
    }
}

- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view
{
    if (![view.annotation isKindOfClass:[RMPAnnotation class]]) {
        return;
    }
    
    RMPAnnotation *thisAnnotation = (RMPAnnotation*)view.annotation;
    view.image = thisAnnotation.pinImage;
}


@end
