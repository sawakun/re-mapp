//
//  RMPMapView.h
//  ReMapp1
//
//  Created by nishiba on 2013/07/22.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import <MapKit/MapKit.h>

/** Notification that gets posted when an annotation was selected. */
extern NSString *const RMPMapViewDidSelectAnnotation;
/** Notification that gets posted when the region was changed. */
extern NSString *const RMPMapViewRegionDidChangeAnimated;
/** Notification that gets posted when an annotation was deselected. */
extern NSString *const RMPMapViewDidDeselectAnnotationView;

@interface RMPMapView : MKMapView <MKMapViewDelegate>

@end
