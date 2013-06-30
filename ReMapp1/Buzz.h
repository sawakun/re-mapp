//
//  Buzz.h
//  Model
//
//  Created by nishiba on 2013/06/30.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Buzz : NSObject
{
@private
    NSString *_id;
    NSString *_userId;
    NSString *_text;
    NSString *_img;
    NSString *_date;
    float _lot;
    float _lat;
}

@property (nonatomic, readonly) NSString* userId;
@property (nonatomic, readonly) NSString* text;
@property (nonatomic, readonly) NSString* img;
@property (nonatomic, readonly) NSString* date;
@property (nonatomic, readonly) float lot;
@property (nonatomic, readonly) float lat;



- (id)initWithBuzz:(NSDictionary *)buzz;
- (id)initWithArray:(NSArray *)buzz;

@end
