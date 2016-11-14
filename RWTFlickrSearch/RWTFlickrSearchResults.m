//
//  RWTFlickrSearchResults.m
//  RWTFlickrSearch
//
//  Created by yaoxb on 2016/11/14.
//  Copyright © 2016年 Colin Eberhardt. All rights reserved.
//

#import "RWTFlickrSearchResults.h"

@implementation RWTFlickrSearchResults

- (NSString *)description {
    return [NSString stringWithFormat:@"searchString=%@, totalresults=%lU, photos=%@",
            self.searchString, self.totalResults, self.photos];
}

@end
