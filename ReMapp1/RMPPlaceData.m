//
//  RMPBuzzListData.m
//  ReMapp1
//
//  Created by nishiba on 2013/08/11.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import "RMPPlaceData.h"
#import "RMPPlace.h"
#import "RMPUser.h"
#import "RMPPlaceData+protected.h"

NSString *const RMPPlaceDataReloaded = @"RMPPlaceDataReloaded";

@interface RMPPlaceData()
@property (nonatomic) NSMutableArray *places;
@end


@implementation RMPPlaceData

- (id)init
{
    self = [super init];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)setUp
{
    self.places = [[NSMutableArray alloc] init];
}

- (NSInteger)count
{
    return [self.places count];
}

- (BOOL)availableForPlace:(RMPPlace*)place
{
    return YES;
}

- (void)reload
{
    dispatch_queue_t queue = dispatch_queue_create("com.re-mapp", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        [self fetchNewDataWithConditions:nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:RMPPlaceDataReloaded object:self userInfo:nil];
        });
    });
}



- (void)fetchNewDataWithConditions:(NSDictionary *)conditions
{
    //json
    // /api/listen?lat={lat}&lon={lon}&rad={rad}
    NSString *urlStr = @"http://re-mapp.herokuapp.com/api/listen?lat=35.685562&lon=139.753562&rad=0.3";
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url
                                                cachePolicy:NSURLRequestReloadIgnoringCacheData
                                            timeoutInterval:30.0f];
    
    self.currentRequestNumber = (self.currentRequestNumber + 1) % 1000;
    int thisRequestNumber = self.currentRequestNumber;
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest
                                       queue:queue
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
    {

        if (thisRequestNumber != self.currentRequestNumber || error != nil || [data length] == 0) {
            return;
        }
        
        NSString *dataStr = [[NSString alloc] initWithData:data encoding:NSJapaneseEUCStringEncoding];
        if (dataStr == nil) {
            return;
        }
        
        NSData *jsonData = [dataStr dataUsingEncoding:NSUTF8StringEncoding];
        NSArray *buzzArray = [NSJSONSerialization JSONObjectWithData:jsonData
                                                             options:NSJSONReadingAllowFragments
                                                               error:nil];
        
        [self.places removeAllObjects];
        for (NSDictionary *buzzDictionary in buzzArray) {
            RMPPlace *place = [RMPPlaceFactory createPlace:buzzDictionary];
            [self.places addObject:place];
        }
        return;
    }];
}


- (RMPPlace *)placeAtIndex:(NSInteger)index
{
    if (index >= [self.places count] || self.places == nil) {
        return nil;
    }
    return [self.places objectAtIndex:index];
}

@end



@implementation RMPMutePlaceData
- (BOOL)availableForPlace:(RMPPlace*)place
{
    return (place.mute);
}

@end

@implementation RMPCheckPlaceData
- (BOOL)availableForPlace:(RMPPlace*)place
{
    return (place.like);
}

@end

@interface RMPYourTimePlaceData()
@property (nonatomic) RMPUser *user;
@end

@implementation RMPYourTimePlaceData
- (id)init
{
    self = [super init];
    if (self) {
        self.user = [RMPUser sharedManager];
    }
    return self;
}

- (BOOL)availableForPlace:(RMPPlace*)place
{
    return (place.userId == self.user.systemId);
}

@end
