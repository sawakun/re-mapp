//
//  RMPHTTPConnection.h
//  ReMapp1
//
//  Created by Masahiro Nishiba on 2013/07/19.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface RMPHTTPConnection : NSObject
+ (BOOL)loginWithEmail:(NSString*)email Password:(NSString*)password;
+ (BOOL)registerWithUserName:(NSString*)userName Email:(NSString*)email Password:(NSString*)password UserImage:(UIImage*)userImage;
+ (BOOL)logout;

+ (BOOL)sendNewBuzzWithUserSystemId:(NSInteger)userSystemId
                           BuzzText:(NSString*)buzzText
                           Location:(CLLocationCoordinate2D)location
                              Image:(UIImage*)image;

+ (BOOL)sendModifiedUserName:(NSString*)name
                       Email:(NSString*)email
                     Profile:(NSString*)profile;


+ (NSArray *)searchPointOfInterest:(NSString*)key;
+ (NSURL *)createPlaceDataURLWithConditions:(NSDictionary *)conditions;
@end
