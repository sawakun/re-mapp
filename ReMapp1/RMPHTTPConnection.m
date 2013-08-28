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
    // JSON to post
    /*
     {
     "user_id":3,
     "buzz_body":"test data:18",
     "buzz_img_url":"http://re-mapp.herokuapp.com/assets/images/IMG_0732.jpg",
     "lat":35.106876588753444,
     "lon":139.10971074251088,
     "buzz_type":"eat"
     }
     */
    //uploading image

    NSString *url=@"";
    NSMutableURLRequest *requestForImage;
    requestForImage =
    [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://re-mapp.herokuapp.com/api/uploadTest"]
                            cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    NSData *imageData = [[NSData alloc] initWithData:UIImagePNGRepresentation(image)];
    //set HTTP POST
    [requestForImage setHTTPMethod:@"POST"];
    [requestForImage setValue:@"image/png" forHTTPHeaderField:@"Accept"];
    [requestForImage setValue:@"image/png" forHTTPHeaderField:@"Content-Type"];
    [requestForImage setValue:[NSString stringWithFormat:@"%d",
                       [imageData length]] forHTTPHeaderField:@"Content-Length"];
    [requestForImage setHTTPBody: imageData];
    
    //response
    NSURLResponse *respForImage=nil;
    NSError *errForImage=nil;
    
    NSData *resultForImage;
    NSArray *resultArrayForImage;
    BOOL *flagForImage = TRUE;
    while(flagForImage){
        //HTTP request send
        resultForImage = [NSURLConnection sendSynchronousRequest:requestForImage
                                       returningResponse:&respForImage error:&errForImage];
        resultArrayForImage = [NSJSONSerialization JSONObjectWithData:resultForImage
                                                      options:NSJSONReadingAllowFragments
                                                                error:&errForImage];
    }
    if([resultArrayForImage count]!=0) url=resultArrayForImage[0];
    
    //TODO: treating buzz_type
    // upload buzz data
    NSMutableDictionary *mutableDic = [NSMutableDictionary dictionary];
    [mutableDic setValue:[NSString stringWithFormat:@"%d", userSystemId] forKey:@"user_id"];
    [mutableDic setValue:buzzText forKey:@"buzz_body"];
    [mutableDic setValue:url forKey:@"buzz_img_url"];
    [mutableDic setValue:[NSString stringWithFormat:@"%f", location.latitude] forKey:@"lat"];
    [mutableDic setValue:[NSString stringWithFormat:@"%f", location.longitude] forKey:@"lon"];
    [mutableDic setValue:@"buzz" forKey:@"buzz_type"];
    
    //convert to JSON
    NSError*   error = nil;
    NSData *requestData = [NSJSONSerialization dataWithJSONObject:mutableDic options:NSJSONWritingPrettyPrinted error:&error];
    
    //debug
    NSArray *array = [NSJSONSerialization JSONObjectWithData:requestData
                                                     options:NSJSONReadingAllowFragments
                                                       error:&error];
    
    NSMutableURLRequest *request;
    request =
    [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://re-mapp.herokuapp.com/api/post"]
                            cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    //set HTTP POST
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json"
   forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%d",
                       [requestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: requestData];
    
    //response
    NSURLResponse *resp=nil;
    NSError *err=nil;
    
    NSData *result;
    NSArray *resultArray;
    BOOL *flag = TRUE;
    while(flag){
        //HTTP request send
        result = [NSURLConnection sendSynchronousRequest:request
                                           returningResponse:&resp error:&err];
        resultArray = [NSJSONSerialization JSONObjectWithData:result
                                                     options:NSJSONReadingAllowFragments
                                                       error:&error];
        //TODO: check succeeded in sending
        //TODO: show dialog and ask 'resend' or 'save to draft'
        flag=FALSE;
    }
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

@end
