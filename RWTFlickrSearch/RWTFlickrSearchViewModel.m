//
//  RWTFlickrSearchViewModel.m
//  RWTFlickrSearch
//
//  Created by yaoxb on 2016/11/14.
//  Copyright © 2016年 Colin Eberhardt. All rights reserved.
//

#import "RWTFlickrSearchViewModel.h"

@interface RWTFlickrSearchViewModel ()

@property (nonatomic, weak) id<RWTViewModelServices>services;


@end

@implementation RWTFlickrSearchViewModel

- (instancetype)initWithServices:(id<RWTViewModelServices>)services
{
    self = [super init];
    if (self) {
        _services = services;
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    self.title = @"Flickr search";
    RACSignal *validSearchSignal = [[RACObserve(self, searchText) map:^id(NSString * value) {
        return @(value.length > 3);
    }] distinctUntilChanged];
    [validSearchSignal subscribeNext:^(id x) {
        NSLog(@"search text is valid %@",x);
    }];
    
    self.executeSearch = [[RACCommand alloc] initWithEnabled:validSearchSignal signalBlock:^RACSignal *(id input) {
        return [self executeSearchSignal];
    }];
}

- (RACSignal *)executeSearchSignal
{
    return [[[self.services getFlickrSearchService] flickrSearchSignal:self.searchText] logAll];
    
}


@end
