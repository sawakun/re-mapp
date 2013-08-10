//
//  RMPImageUploader.h
//  ImageUploader
//
//  Created by nishiba on 2013/08/10.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RMPPostRequestCreator : NSObject 
- (void)setPostString:(NSObject *)stringValue withPostName:(NSString *)postName;
- (void)setPostImage:(UIImage *)image withPostName:(NSString *)postName fileName:(NSString *)fileName;
- (NSURLRequest *)createRequestWithURL:(NSURL *)url;
@end
