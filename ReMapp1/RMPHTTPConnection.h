//
//  RMPHTTPConnection.h
//  ReMapp1
//
//  Created by Masahiro Nishiba on 2013/07/19.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "CSVHandler.h"

@interface RMPHTTPConnection : NSObject
+ (BOOL)sendNewBuzzWithUserSystemId:(NSString*)userSystemId
                           BuzzText:(NSString*)buzzText
                           Location:(CLLocationCoordinate2D)location
                              Image:(UIImage*)image;
@end
