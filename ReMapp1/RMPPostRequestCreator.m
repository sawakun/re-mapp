//
//  RMPImageUploader.m
//  ImageUploader
//
//  Created by nishiba on 2013/08/10.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "RMPPostRequestCreator.h"


static NSString *KEY_POST_NAME              = @"postName";
static NSString *KEY_POST_STRING            = @"postString";
static NSString *KEY_POST_IMAGE             = @"postImage";
static NSString *KEY_POST_IMAGE_FILE_NAME   = @"postImageFileName";
static NSString *BOUNDARY                   = @"-----iOS";

@interface RMPPostRequestCreator()
@property (nonatomic) NSMutableArray *postStrings;
@property (nonatomic) NSMutableArray *postImages;
@property (nonatomic) NSMutableData *receiveData;
@end

@implementation RMPPostRequestCreator

- (id)init
{
    self = [super init];
    if (self) {
        self.postStrings = [[NSMutableArray alloc] initWithCapacity:0];
        self.postImages = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}


- (void)setPostString:(NSObject *)stringValue withPostName:(NSString *)postName
{
    NSDictionary *stringDictionary = [NSDictionary dictionaryWithObjectsAndKeys:stringValue, KEY_POST_STRING,
                                      postName, KEY_POST_NAME, nil];
    [self.postStrings addObject:stringDictionary];
}

- (void)setPostImage:(UIImage *)image withPostName:(NSString *)postName fileName:(NSString *)fileName
{
    NSDictionary *imageDictionary = [NSDictionary dictionaryWithObjectsAndKeys:image, KEY_POST_IMAGE,
                                     postName, KEY_POST_NAME,
                                     fileName, KEY_POST_IMAGE_FILE_NAME, nil];
    [self.postImages addObject:imageDictionary];
}

- (NSURLRequest *)createRequestWithURL:(NSURL *)url
{
    // post body
    NSMutableData *body = [[NSMutableData alloc] init];
    
    // add params
    for (NSDictionary *stringDictionary in self.postStrings) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", BOUNDARY] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",
                           [stringDictionary objectForKey:KEY_POST_NAME]] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"%@\r\n",
                           [stringDictionary objectForKey:KEY_POST_STRING]] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    // add images
    NSRegularExpression *checkJpeg = [NSRegularExpression regularExpressionWithPattern:@"[.](?:jpg|jpeg)$"
                                                                               options:NSRegularExpressionCaseInsensitive
                                                                                 error:nil];
    NSData *imageData;
    for (NSDictionary *imageDictionary in self.postImages) {
        NSString *contentType;
        NSTextCheckingResult *isMatch;
        NSString *imageFileName = [imageDictionary objectForKey:KEY_POST_IMAGE_FILE_NAME];
        NSString *postName = [imageDictionary objectForKey:KEY_POST_NAME];
        isMatch = [checkJpeg firstMatchInString:imageFileName options:0 range:NSMakeRange(0, imageFileName.length)];
        
        if (isMatch) {
            contentType = @"image/jpeg";
            imageData = UIImageJPEGRepresentation([imageDictionary objectForKey:KEY_POST_IMAGE], 1.0f);
        }
        else {
            contentType = @"image/png";
            imageData = UIImagePNGRepresentation([imageDictionary objectForKey:KEY_POST_IMAGE]);
        }
        
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", BOUNDARY] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n",
                           postName, imageFileName] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Type: %@\r\n", contentType] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:imageData];
        [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", BOUNDARY] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    // set the body of the post to the request.
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url
                                                                cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                            timeoutInterval:30];
	[request setHTTPMethod:@"POST"];
	[request setValue:[NSString stringWithFormat:@"%d", [body length]] forHTTPHeaderField:@"Content-Length"];
	[request setValue:[NSString stringWithFormat:@"multipart/form-data; boundary=%@", BOUNDARY] forHTTPHeaderField:@"Content-Type"];
	[request setHTTPBody:body];
    
    return request;
}

@end

