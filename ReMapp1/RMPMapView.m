//
//  RMPMapView.m
//  ReMapp1
//
//  Created by nishiba on 2013/07/22.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "RMPMapView.h"
#import "RMPAnnotation.h"
#import "RMPBuzzData.h"

NSString *const RMPMapViewDidSelectAnnotation = @"RMPMapViewDidSelectAnnotation";
NSString *const RMPMapViewRegionDidChangeAnimated = @"RMPMapViewRegionDidChangeAnimated";
NSString *const RMPMapViewDidDeselectAnnotationView = @"RMPMapViewDidDeselectAnnotationView";

@implementation RMPMapView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
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

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    CGPoint northEast = CGPointMake(self.bounds.origin.x+self.bounds.size.width,
                                    self.bounds.origin.y);
    CLLocationCoordinate2D neCoordinate = [self convertPoint:northEast toCoordinateFromView:self];
    
    CGPoint southWest = CGPointMake(self.bounds.origin.x,
                                    self.bounds.origin.y+self.bounds.size.height);
    CLLocationCoordinate2D swCoordinate = [self convertPoint:southWest toCoordinateFromView:self];
    

    NSDictionary *userInfo = @{@"northEastLat":[NSNumber numberWithDouble:neCoordinate.latitude],
                               @"northEastLot":[NSNumber numberWithDouble:neCoordinate.longitude],
                               @"southWestLat":[NSNumber numberWithDouble:swCoordinate.latitude],
                               @"southWestLot":[NSNumber numberWithDouble:swCoordinate.longitude]};
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:RMPMapViewRegionDidChangeAnimated
                                                            object:nil
                                                          userInfo:userInfo];
    });
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    
    RMPSelectedAnnotation *selectedAnnotation = [[RMPSelectedAnnotation alloc] init];
    [UIView animateWithDuration:0.2f animations:^{
        view.image = selectedAnnotation.pinImage;
        view.centerOffset = selectedAnnotation.centerOffset;
    }];
    
    //post notification
    RMPAnnotation *annotation = (RMPAnnotation *)view.annotation;
    NSDictionary *userInfo = @{@"annotationIndex":[NSNumber numberWithInteger:annotation.index]};
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:RMPMapViewDidSelectAnnotation
                                                            object:self
                                                          userInfo:userInfo];
    });
}

- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view
{
    if (![view.annotation isKindOfClass:[RMPAnnotation class]]) {
        return;
    }
    
    RMPAnnotation *thisAnnotation = (RMPAnnotation*)view.annotation;
    view.image = thisAnnotation.pinImage;

    //post notification
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:RMPMapViewDidDeselectAnnotationView
                                                            object:self
                                                          userInfo:nil];
    });
}
@end
