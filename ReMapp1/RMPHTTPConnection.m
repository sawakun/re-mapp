//
//  RMPHTTPConnection.m
//  ReMapp1
//
//  Created by Masahiro Nishiba on 2013/07/19.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "RMPHTTPConnection.h"

@implementation RMPHTTPConnection
+ (BOOL)sendNewBuzzWithUserSystemId:(NSString*)userSystemId
                           BuzzText:(NSString*)buzzText
                           Location:(CLLocationCoordinate2D)location
                              Image:(UIImage*)image
{
    // I send a new buzz data (userSystemId, buzzText, lat, lot, image) to the serve.
    // The following is a test code.
    
    static NSString *fileName = @"BuzzData.csv";
    
    NSDate *nowDate = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSString *nowDateString = [formatter stringFromDate:nowDate];

    //make a new  csv line
    NSString *newLine = [[NSString alloc] initWithFormat:@"\n%@,%@,%@,%@,%f,%f,%@",
                         nowDateString,
                         userSystemId,
                         buzzText,
                         @"",
                         location.latitude,
                         location.longitude,
                         nowDateString];
    addCSVFile(fileName, newLine);
    return TRUE;
}
@end
