//
//  RWTFlickrSearchImpl.m
//  RWTFlickrSearch
//
//  Created by yaoxb on 2016/11/14.
//  Copyright © 2016年 Colin Eberhardt. All rights reserved.
//

#import "RWTFlickrSearchImpl.h"
#import "RWTFlickrSearchResults.h"
#import "RWTFlickrPhoto.h"
#import <objectiveflickr/ObjectiveFlickr.h>
#import <LinqToObjectiveC/NSArray+LinqExtensions.h>

@interface RWTFlickrSearchImpl ()<OFFlickrAPIRequestDelegate>

@property (nonatomic, strong) NSMutableSet *requests;
@property (nonatomic, strong) OFFlickrAPIContext *flickrContext;


@end


@implementation RWTFlickrSearchImpl


- (instancetype)init
{
    self = [super init];
    if (self) {
        NSString *OFSampleAppAPIKey = @"e3bc8f361c44d960c914e2b5fdaf91e0";
        NSString *OFSampleAppSHaredSecret = @"65f11b769915c71a";
        _flickrContext = [[OFFlickrAPIContext alloc] initWithAPIKey:OFSampleAppAPIKey sharedSecret:OFSampleAppSHaredSecret];
        _requests = [NSMutableSet new];
    }
    return self;
}


- (RACSignal *)flickrSearchSignal:(NSString *)searchString
{
    
    return [self signalFromAPIMethod:@"flickr.photos.search" arguments:@{@"text":searchString,
                                                                         @"sort":@"interestingness-desc"} transform:^id(NSDictionary *response)
    {
        RWTFlickrSearchResults *results = [RWTFlickrSearchResults new];
        results.searchString = searchString;
        results.totalResults = [[response valueForKeyPath:@"photos.total"] integerValue];
        
        NSArray *photos = [response valueForKeyPath:@"photos.photo"];
        results.photos = [photos linq_select:^id(NSDictionary * jsonPhoto) {
            
            RWTFlickrPhoto *photo = [RWTFlickrPhoto new];
            photo.title = [jsonPhoto objectForKey:@"title"];
            photo.identifier = [jsonPhoto objectForKey:@"id"];
            photo.url = [self.flickrContext photoSourceURLFromDictionary:jsonPhoto size:OFFlickrSmallSize];
            return photo;
        }];
        
        return results;
    }];
    

}


- (RACSignal *)signalFromAPIMethod:(NSString *)method
                         arguments:(NSDictionary *)args
                         transform:(id(^)(NSDictionary *response))block
{
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        OFFlickrAPIRequest *flickrRequest = [[OFFlickrAPIRequest alloc] initWithAPIContext:self.flickrContext];
        flickrRequest.delegate = self;
        [self.requests addObject:flickrRequest];
        
        RACSignal *successSignal = [self rac_signalForSelector:@selector(flickrAPIRequest:didCompleteWithResponse:) fromProtocol:@protocol(OFFlickrAPIRequestDelegate)];
        
        [[[successSignal map:^id(RACTuple * value) {
            return value.second;
        }]
        map:block]
        
        subscribeNext:^(id x) {
            [subscriber sendNext:x];
            [subscriber sendCompleted];
        }];
    
        [flickrRequest callAPIMethodWithGET:method arguments:args];
        
        
        
        return [RACDisposable disposableWithBlock:^{
            [self.requests removeObject:flickrRequest];
        }];
    }];
    
}

@end
