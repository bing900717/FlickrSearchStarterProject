//
//  RWTFlickrSearchResults.h
//  RWTFlickrSearch
//
//  Created by yaoxb on 2016/11/14.
//  Copyright © 2016年 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RWTFlickrSearchResults : NSObject

@property (nonatomic, strong) NSString *searchString;
@property (nonatomic, strong) NSArray *photos;
@property (nonatomic) NSUInteger totalResults;

@end
