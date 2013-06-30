//
//  ViewController.m
//  ReMapp1
//
//  Created by nishiba on 2013/06/29.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "MapViewController.h"
#import "BuzzData.h"
#import "Buzz.h"

@interface MapViewController ()

@end

@implementation MapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // set Map
    self.mapView.delegate = self;
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = 35.6584;
    zoomLocation.longitude = 139.7017;
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 1000.0, 1000.0);
    [_mapView setRegion:viewRegion animated:NO];
    
    // set InfoView
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
    _infoViewController = [storyboard instantiateViewControllerWithIdentifier:@"Info"];
    [_infoViewController.view setFrame:self.view.bounds];
    [self addChildViewController:_infoViewController];
    [self.view addSubview:_infoViewController.view];
    [_infoViewController didMoveToParentViewController:self];
    
    //calculate points of center of InfoView
    float headlineHeight = 80.0f;
    float xcenter = self.view.center.x;
    float height = self.view.frame.size.height;
    float infoHeight = _infoViewController.view.frame.size.height;
    _hiddenCenter = CGPointMake(xcenter, height + infoHeight * 0.5f);
    _lowerCenter = CGPointMake(xcenter, height + infoHeight * 0.5f - headlineHeight);
    _middleCenter = CGPointMake(xcenter, height);
    _upperCenter = CGPointMake(xcenter, height * 0.5);
    
    //get BuzzData
    _buzzData = [BuzzData sharedInstance];
    [_buzzData reload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _infoViewController.view.center = _lowerCenter;
    
    
    // show Buzz points
    NSMutableArray *annotations = [NSMutableArray array];
    for (Buzz *buzz in _buzzData.buzzes)
    {
        MKPointAnnotation *pointAnnotation = [[MKPointAnnotation alloc] init];
        pointAnnotation.coordinate = CLLocationCoordinate2DMake(buzz.lot, buzz.lat);
        pointAnnotation.title = @"TestTitle";
        [annotations addObject:pointAnnotation];
    }
    [_mapView addAnnotations:annotations];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) moveInfoUp
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

-(MKAnnotationView*)mapView:(MKMapView*)mapView viewForAnnotation:(id)annotation{
    
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    MKAnnotationView *annotationView;
    NSString* identifier = @"Pin";
    annotationView = (MKAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if(nil == annotationView) {
        annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
    }
    
    
    annotationView.image = [UIImage imageNamed:@"pin.png"];
    annotationView.centerOffset = CGPointMake(-10, -10);
    annotationView.canShowCallout = NO;
    annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    annotationView.annotation = annotation;
    
    return annotationView;
}


@end
