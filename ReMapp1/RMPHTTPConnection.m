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
+ (BOOL)judgeBuzz:(NSInteger)buzzId State:(BOOL)state Kind:(enum RMPJudgeKind)kind
{
    //UNDER CONSTRUCTION
    return YES;
}


+ (BOOL)loginWithEmail:(NSString*)email Password:(NSString*)password
{
    // UNDER CONSTRUCTION
    sleep(2);
    return YES;
}

+ (BOOL)registerWithUserName:(NSString*)userName Email:(NSString*)email Password:(NSString*)password UserImage:(UIImage*)userImage
{
    // UNDER CONSTRUCTION
    sleep(2);
    return YES;
}

+ (BOOL)logout
{
    // UNDER CONSTRUCTION
    sleep(2);
    return YES;
}

+ (BOOL)sendModifiedUserName:(NSString*)name
                       Email:(NSString*)email
                     Profile:(NSString*)profile
{
    // UNDER CONSTRUCTION
    
    RMPUser *user = [RMPUser sharedManager];
    user.name = name;
    user.email = email;
    user.profile = profile;
    return TRUE;
}

+ (BOOL)sendNewBuzzWithUserSystemId:(NSInteger)userSystemId
                           BuzzText:(NSString*)buzzText
                           Location:(CLLocationCoordinate2D)location
                              Image:(UIImage*)image
{    
    // post JSON like as follows
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
    
    //upload image and get url
    NSString *buzz_img_url=[self sendImage:image userSystemId:userSystemId];
    
    // upload buzz data
    NSMutableDictionary *mutableDic = [NSMutableDictionary dictionary];
    [mutableDic setValue:[NSNumber numberWithInt:userSystemId] forKey:@"user_id"];
    [mutableDic setValue:buzzText forKey:@"buzz_body"];
    [mutableDic setValue:buzz_img_url forKey:@"buzz_img_url"];
    [mutableDic setValue:[NSNumber numberWithDouble:location.latitude] forKey:@"lat"];
    [mutableDic setValue:[NSNumber numberWithDouble:location.longitude] forKey:@"lon"];
    //TODO: treating buzz_type
    [mutableDic setValue:@"buzz" forKey:@"buzz_type"];
    
    //convert to JSON
    NSError*   errorJson = nil;
    NSData *requestData = [NSJSONSerialization dataWithJSONObject:mutableDic options:NSJSONWritingPrettyPrinted error:&errorJson];

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://re-mapp.herokuapp.com/api/post"] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];

// for debug. send to localhost
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://localhost:9000/api/post"] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    
    //set HTTP POST
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%d", [requestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: requestData];
    
    //response
    NSURLResponse *response=nil;
    NSError *error=nil;
    NSData *result;
    NSMutableDictionary *resultDic;
    BOOL flag = YES;
    while(flag){
        //HTTP request send
        result = [NSURLConnection sendSynchronousRequest:request
                                           returningResponse:&response error:&error];
        resultDic = [NSJSONSerialization JSONObjectWithData:result
                                                     options:NSJSONReadingAllowFragments
                                                       error:&errorJson];
        NSString *status = [resultDic objectForKey:@"status"];
        if(![status isEqualToString:@"ok"]){
            //TODO: show dialog and ask 'resend' or 'save to draft'
            
        }else{
            // successfully posted
            flag=NO;
        }
    }
    return TRUE;
}


+ (NSString*)sendImage:(UIImage*)image userSystemId:(NSInteger)userSystemId
{
    //upload image
    NSString *url=@"";
    
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://re-mapp.herokuapp.com/api/uploadImage"] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    NSData *imageData = [[NSData alloc] initWithData:UIImagePNGRepresentation(image)];

    //set HTTP POST
    //TODO: treat image format png/jpg/gif
    [request setHTTPMethod:@"POST"];

    NSString *boundary = @"1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    
    NSMutableData *body = [NSMutableData data];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];

    //TODO: ここのfilenameがどこに使われるのか要調査
    [body appendData:[@"Content-Disposition: form-data; name=\"picture\"; filename=\"test.png\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];

    [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData dataWithData:imageData]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:body];
    
    //response
    NSURLResponse *response=nil;
    NSError *error=nil;
    NSError *errorJson=nil;
    NSData *result;
    NSMutableDictionary *resultDic;
    BOOL flag = YES;
    while(flag){
        //HTTP request send
        result = [NSURLConnection sendSynchronousRequest:request
                                       returningResponse:&response error:&error];
        resultDic = [NSJSONSerialization JSONObjectWithData:result
                                                    options:NSJSONReadingAllowFragments
                                                      error:&errorJson];
        NSString *status = [resultDic objectForKey:@"status"];
        if(![status isEqualToString:@"ok"]){
            //TODO: show dialog and ask 'resend' or 'save to draft'
            
        }else{
            // successfully posted
            flag=NO;
            url=[resultDic objectForKey:@"url"];
        }
    }
    return url;
}





+ (NSArray *)searchPointOfInterest:(NSString*)key
{
    // UNDER CONSTRUCTION - change url
    // /api/listen?lat={lat}&lon={lon}&rad={rad}
    NSString *urlStr = @"http://re-mapp.herokuapp.com/api/listen?lat=35.685562&lon=139.753562&rad=0.3";
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url
                                                cachePolicy:NSURLRequestReloadIgnoringCacheData
                                            timeoutInterval:30.0f];
    NSURLResponse *response;
    NSError *error;
    NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest
                                         returningResponse:&response
                                                     error:&error];
    
    if (error != nil || [data length] == 0) {
        return nil;
    }
    
    NSString *dataStr = [[NSString alloc] initWithData:data encoding:NSJapaneseEUCStringEncoding];

    NSData *jsonData = [dataStr dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *dataArray = [NSJSONSerialization JSONObjectWithData:jsonData
                                                         options:NSJSONReadingAllowFragments
                                                           error:nil];

    return dataArray;
}


+ (NSURL *)createPlaceDataURLWithConditions:(NSDictionary *)conditions
{
    // /api/listen?lat={lat}&lon={lon}&rad={rad}
    NSMutableString *urlStr = [NSMutableString stringWithString:@"http://re-mapp.herokuapp.com/api/listen?"];
    for (NSString *key in conditions) {
        [urlStr appendFormat:@"%@=%@&", key, conditions[key]];
    }
    
    // delete the last character of url
    [urlStr deleteCharactersInRange:NSMakeRange([urlStr length] - 1, 1)];
    
    NSLog(@"%@", urlStr);
    return [NSURL URLWithString:urlStr];
}


@end
