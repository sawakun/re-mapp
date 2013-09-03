//
//  RMPHTTPConnection.m
//  ReMapp1
//
//  Created by Masahiro Nishiba on 2013/07/19.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "RMPHTTPConnection.h"
#import "RMPUser.h"

@implementation RMPHTTPConnection
+ (BOOL)sendNewBuzzWithUserSystemId:(NSInteger)userSystemId
                           BuzzText:(NSString*)buzzText
                           Location:(CLLocationCoordinate2D)location
                              Image:(UIImage*)image
{
    // I send a new buzz data (userSystemId, buzzText, lat, lot, image) to the serve.
    // The following is a test code.
    /*
    static NSString *fileName = @"BuzzData.csv";
    
    NSDate *nowDate = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSString *nowDateString = [formatter stringFromDate:nowDate];

    //make a new  csv line
    NSString *newLine = [[NSString alloc] initWithFormat:@"\n%@,%d,%@,%@,%f,%f,%@",
                         nowDateString,
                         userSystemId,
                         buzzText,
                         @"",
                         location.latitude,
                         location.longitude,
                         nowDateString];
    //addCSVFile(fileName, newLine);
    */
    return TRUE;
}

+ (BOOL)sendModifiedUserName:(NSString*)name
                       Email:(NSString*)email
                     Profile:(NSString*)profile
{
    //Connect to the server...
    
    
    RMPUser *user = [RMPUser sharedManager];
    user.name = name;
    user.email = email;
    user.profile = profile;
    return TRUE;
}


+ (NSArray *)searchPointOfInterest:(NSString*)key
{
    // UNDER CONSTRUCTION - change url
    NSString *urlStr = @"http://re-mapp.herokuapp.com/api/listen/35.685562/139.753562/0.3";
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url
                                                cachePolicy:NSURLRequestReloadIgnoringCacheData
                                            timeoutInterval:30.0f];
    NSURLResponse *response;
    NSError *error;
    NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest
                                         returningResponse:&response
                                                     error:&error];
    if (error != nil) {
        return nil;
    }
    if ([data length] == 0) {
        return nil;
    }
    
    NSString *dataStr = [[NSString alloc] initWithData:data encoding:NSJapaneseEUCStringEncoding];

    NSData *jsonData = [dataStr dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *dataArray = [NSJSONSerialization JSONObjectWithData:jsonData
                                                         options:NSJSONReadingAllowFragments
                                                           error:nil];

    return dataArray;
}


@end
