//
//  RMPSearchResultsCollectionView.h
//  ReMapp1
//
//  Created by nishiba on 2013/09/02.
//  Copyright (c) 2013年 nishiba. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RMPSearchResultsCollectionViewDelegate <NSObject>
- (void)moveMapWithLon:(CGFloat)lon Lat:(CGFloat)lat;
@end

@interface RMPSearchResultsCollectionView : UICollectionView <UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, assign) id <RMPSearchResultsCollectionViewDelegate> mapDelegate;
@property (nonatomic) NSArray *searchResults;
- (void)searchPointOfInterest:(NSString*)key;
@end


