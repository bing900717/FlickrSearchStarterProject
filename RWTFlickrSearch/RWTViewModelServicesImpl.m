//
//  RWTViewModelServicesImpl.m
//  RWTFlickrSearch
//
//  Created by yaoxb on 2016/11/14.
//  Copyright © 2016年 Colin Eberhardt. All rights reserved.
//

#import "RWTViewModelServicesImpl.h"
#import "RWTFlickrSearchImpl.h"

@interface RWTViewModelServicesImpl ()

@property (nonatomic, strong) RWTFlickrSearchImpl *searchServices;

@end

@implementation RWTViewModelServicesImpl

- (instancetype)init
{
    self = [super init];
    if (self) {
        _searchServices = [RWTFlickrSearchImpl new];
    }
    return self;
}

- (id<RWTFlickrSearch>)getFlickrSearchService
{
    return self.searchServices;
    
}




@end
