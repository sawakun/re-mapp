//
//  ViewController.m
//  ReMapp1
//
//  Created by nishiba on 2013/06/29.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "MapViewController.h"
#import "InfoViewController.h"
#import "BuzzData.h"
#import "Buzz.h"
#import "BuzzFormViewController.h"
#import "BuzzAnnotation.h"

@interface MapViewController ()

@end

@implementation MapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //set BuzzData
    _buzzData = [[BuzzData alloc] init];

    // set Map
    _mapView.delegate = self;
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = 35.6584;
    zoomLocation.longitude = 139.7017;
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 1000.0, 1000.0);
    [_mapView setRegion:viewRegion animated:NO];

    
    // set InfoView
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
    _infoViewController = (InfoViewController *)[storyboard instantiateViewControllerWithIdentifier:@"Info"];
    _infoViewController.buzzData = _buzzData;
    [_infoViewController.view setFrame:self.view.bounds];
    [self addChildViewController:_infoViewController];
    [self.view addSubview:_infoViewController.view];
    [_infoViewController didMoveToParentViewController:self];
    
    
    // set BuzzForm
    _buzzFormViewController = [storyboard instantiateViewControllerWithIdentifier:@"BuzzForm"];
    
    //calculate points of center of InfoView
    float headlineHeight = 120.0f;
    float xcenter = self.view.center.x;
    float height = self.view.frame.size.height;
    float infoHeight = _infoViewController.view.frame.size.height;
    _hiddenCenter = CGPointMake(xcenter, height + infoHeight * 0.5f);
    _lowerCenter = CGPointMake(xcenter, height + infoHeight * 0.5f - headlineHeight);
    _middleCenter = CGPointMake(xcenter, height);
    _upperCenter = CGPointMake(xcenter, height * 0.5);
        
    // regist UIGestureRecognizer
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.minimumPressDuration = 1.0;
    [self.mapView addGestureRecognizer:lpgr];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _infoViewController.view.center = _hiddenCenter;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // show Buzz points
    [self reload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showInfo
{
    CGPoint center = _infoViewController.view.center;
    if (center.y == _hiddenCenter.y)
    {
        [UIView animateWithDuration:0.5f animations:^{
            _infoViewController.view.center = _lowerCenter;
        }];
    }
}

- (void)moveInfoUp
{
    CGPoint center = _infoViewController.view.center;
    CGPoint newCenter = center;
    if (center.y == _hiddenCenter.y)
    {
        newCenter = _lowerCenter;
    }
    else if (center.y == _lowerCenter.y)
    {
        newCenter = _middleCenter;
    }
    else if (center.y == _middleCenter.y)
    {
        newCenter = _upperCenter;
    }
    
    [UIView animateWithDuration:0.5f animations:^{
        _infoViewController.view.center = newCenter;
    }];
}

- (void) moveInfoDown
{
    CGPoint center = _infoViewController.view.center;
    CGPoint newCenter = center;
    if (center.y == _upperCenter.y)
    {
        newCenter = _middleCenter;
    }
    else if (center.y == _middleCenter.y)
    {
        newCenter = _lowerCenter;
    }
    else if (center.y == _lowerCenter.y)
    {
        newCenter = _hiddenCenter;
    }
    
    [UIView animateWithDuration:0.5f animations:^{
        _infoViewController.view.center = newCenter;
    }];
}



-(MKAnnotationView*)mapView:(MKMapView*)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    static NSString* identifier = @"Pin";
    MKAnnotationView *annotationView = (MKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if(nil == annotationView) {
        annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        annotationView.image = [UIImage imageNamed:@"pin.png"];
        annotationView.canShowCallout = NO;
    }
    else {
        annotationView.annotation = annotation;
    }
    
    //annotationView.centerOffset = CGPointMake(-10, -10);
    //annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    
    return annotationView;
}

/*
- (void)mapView:(MKMapView *)map annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    NSLog(@"Test");
}
 */



- (void)showCenter:(NSInteger)index
{
    Buzz *buzz = [_buzzData buzzAtIndex:index];
    CLLocationCoordinate2D centerLocation;
    centerLocation.latitude = buzz.lat;
    centerLocation.longitude = buzz.lot;
    [self.mapView setCenterCoordinate:centerLocation animated:YES];
}


- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    BuzzAnnotation *annotation = (BuzzAnnotation *)view.annotation;
    [_infoViewController showNthCell:annotation.index];
    [self showInfo];
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
    static BuzzAnnotation *annotation;
    
    CGPoint tapPoint = [gestureRecognizer locationInView:self.mapView];
    CLLocationCoordinate2D touchMapCoordinate = [self.mapView convertPoint:tapPoint toCoordinateFromView:_mapView];
    
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded)
    {
        [self showBuzzForm:touchMapCoordinate];
        [_mapView removeAnnotation:annotation];
        return;
    }
    
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        annotation = [[BuzzAnnotation alloc] init];
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
    [_infoViewController.infoTableView reloadData];
    
    NSMutableArray *annotations = [NSMutableArray array];
    for (Buzz *buzz in _buzzData.buzzes)
    {
        [annotations addObject:buzz.annotation];
    }
    [_mapView removeAnnotations:_mapView.annotations];
    [_mapView addAnnotations:annotations];
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    [self reload];
}

@end
